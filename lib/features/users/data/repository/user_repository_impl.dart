import 'package:codebase_assignment/core/network/api_result.dart';
import 'package:codebase_assignment/core/service/shared_prefs/shared_pref_service.dart';
import 'package:codebase_assignment/features/users/data/data_source/user_data_source.dart';
import 'package:codebase_assignment/features/users/data/dto/user_response_dto.dart';
import 'package:codebase_assignment/features/users/data/mappers/user_cache_extension.dart';
import 'package:codebase_assignment/features/users/data/mappers/user_dto_mapper_extension.dart';
import 'package:codebase_assignment/features/users/domain/entities/user_entity.dart';
import 'package:codebase_assignment/features/users/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final SharedPreferencesService prefs;

  UserRepositoryImpl({
    required this.remoteDataSource,
    required this.prefs,
  });

  @override
  Future<ApiResult<List<UserEntity>>> getUsers({
    int page = 1,
    int perPage = 10,
  }) async {
    final result = await remoteDataSource.fetchUsers(
      page: page,
      perPage: perPage,
    );

    if (result is Success<UserResponseDto>) {
      final userDtos = result.data.data;

      // Cache per-page data
      await prefs.cacheUserPage(page, userDtos);

      final userEntities = userDtos.map((dto) => dto.toEntity()).toList();
      return Success(userEntities);
    }

    // If failure, try getting that page from cache
    if (result is Failed || result is ServerError || result is InternalError) {
      final cachedDtos = prefs.getUserPage(page);
      if (cachedDtos.isNotEmpty) {
        final cachedEntities = cachedDtos.map((dto) => dto.toEntity()).toList();
        return Success(cachedEntities);
      }
    }

    // Handle various failure cases
    if (result is Failed<UserResponseDto>) {
      return Failed(result.error);
    }
    if (result is ServerError<UserResponseDto>) {
      return ServerError(result.error);
    }
    if (result is InternalError<UserResponseDto>) {
      return InternalError(result.message);
    }
    return InternalError("Unknown error in UserRepositoryImpl");
  }
}
