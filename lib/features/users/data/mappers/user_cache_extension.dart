import 'dart:convert';

import 'package:codebase_assignment/core/service/shared_prefs/shared_pref_service.dart';
import 'package:codebase_assignment/features/users/data/dto/user_dto.dart';

extension UserDtoPerPageCache on SharedPreferencesService {
  static String _keyForPage(int page) => 'cached_users_page_$page';

  Future<void> cacheUserPage(int page, List<UserDto> users) async {
    final jsonList = users.map((u) => u.toJson()).toList();
    final jsonString = jsonEncode(jsonList);
    await setString(_keyForPage(page), jsonString);
  }

  List<UserDto> getUserPage(int page) {
    final jsonString = getString(_keyForPage(page));
    if (jsonString == null) return [];

    final List<dynamic> decoded = jsonDecode(jsonString);
    return decoded.map((e) => UserDto.fromJson(e)).toList();
  }

  Future<void> clearAllUserPages() async {
    for (int page = 1; page < 100; page++) {
      final key = _keyForPage(page);
      if (getString(key) != null) {
        await removePreference(key);
      } else {
        break; // stop when no more cached pages are found
      }
    }
  }

  Future<List<UserDto>> getAllCachedUsers() async {
    List<UserDto> allUsers = [];
    for (int page = 1; page < 100; page++) {
      final users = getUserPage(page);
      if (users.isEmpty) break;
      allUsers.addAll(users);
    }
    return allUsers;
  }
}
