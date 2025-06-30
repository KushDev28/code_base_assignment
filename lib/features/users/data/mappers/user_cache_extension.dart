
import 'dart:convert';
import 'package:codebase_assignment/core/service/shared_prefs/shared_pref_service.dart';

import '../dto/user_dto.dart';

///User Cache extension from shared Preference
extension UserDtoCache on SharedPreferencesService {
  static const _cachedUsersKey = 'cached_users';

  Future<void> cacheUserDtos(List<UserDto> users) async {
    final jsonList = users.map((u) => u.toJson()).toList();
    final jsonString = jsonEncode(jsonList);
    await setString(_cachedUsersKey, jsonString);
  }

  List<UserDto> getCachedUserDtos() {
    final jsonString = getString(_cachedUsersKey);
    if (jsonString == null) return [];

    final List<dynamic> decoded = jsonDecode(jsonString);
    return decoded.map((e) => UserDto.fromJson(e)).toList();
  }

  Future<void> clearCachedUserDtos() async {
    await removePreference(_cachedUsersKey);
  }
}

