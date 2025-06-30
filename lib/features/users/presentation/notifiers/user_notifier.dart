import 'dart:async';
import 'dart:convert';
import 'package:codebase_assignment/core/network/api_result.dart';
import 'package:codebase_assignment/core/di/service_locator.dart';
import 'package:codebase_assignment/core/service/shared_prefs/shared_pref_service.dart';
import 'package:codebase_assignment/features/users/data/dto/user_dto.dart';
import 'package:codebase_assignment/features/users/data/mappers/user_dto_mapper_extension.dart';
import 'package:codebase_assignment/features/users/domain/entities/user_entity.dart';
import 'package:codebase_assignment/features/users/domain/usecase/user_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_notifier.g.dart';

final userSearchQueryProvider = StateProvider<String>((ref) => '');

const String _cachedUsersKey = 'cached_users';

@Riverpod(keepAlive: true)
class UserNotifier extends _$UserNotifier {
  late final UserUseCase _useCase;
  late final SharedPreferencesService _prefs;

  int _currentPage = 1;
  final int _perPage = 10;
  bool _isLastPage = false;
  bool _isLoadingMore = false;

  bool get isLoadingMore => _isLoadingMore;

  @override
  FutureOr<List<UserEntity>?> build() async {
    _useCase = getIt<UserUseCase>();
    _prefs = await SharedPreferencesService.getInstance();
    return await getFirstUsers();
  }

  Future<List<UserEntity>?> getFirstUsers() async {
    _currentPage = 1;
    _isLastPage = false;

    final result = await _useCase.getUsers(page: _currentPage, perPage: _perPage);

    if (result is Success<List<UserEntity>>) {
      final users = result.data;
      _isLastPage = users.length < _perPage;

      await _cacheUserList(users);
      state = AsyncValue.data(users);
    } else {
      final cached = await _getCachedUsers();
      if (cached != null && cached.isNotEmpty) {
        state = AsyncValue.data(cached);
      } else {
        state = AsyncValue.error(
          (result as dynamic).errors?.message ?? "Failed to load users",
          StackTrace.current,
        );
      }
    }

    return state.value;
  }

  Future<void> fetchMoreUsers() async {
    if (_isLastPage || _isLoadingMore) return;

    _isLoadingMore = true;
    _currentPage++;

    final result = await _useCase.getUsers(page: _currentPage, perPage: _perPage);

    if (result is Success<List<UserEntity>>) {
      final newUsers = result.data;
      _isLastPage = newUsers.length < _perPage;

      final updatedList = [...?state.value, ...newUsers];
      state = AsyncValue.data(updatedList);

      await _cacheUserList(updatedList);
    }

    _isLoadingMore = false;
  }

  Future<void> _cacheUserList(List<UserEntity> users) async {
    final dtos = users.map((e) => e.toDto()).toList();
    final jsonList = dtos.map((e) => e.toJson()).toList();
    final encoded = json.encode(jsonList);
    await _prefs.setString(_cachedUsersKey, encoded);
  }

  Future<List<UserEntity>?> _getCachedUsers() async {
    final raw = _prefs.getString(_cachedUsersKey);
    if (raw == null) return null;

    try {
      final List<dynamic> jsonList = json.decode(raw);
      final dtos = jsonList.map((e) => UserDto.fromJson(e)).toList();
      return dtos.map((e) => e.toEntity()).toList();
    } catch (e) {
      debugPrint("Failed to parse cached users: $e");
      return null;
    }
  }
}
