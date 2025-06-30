


import 'package:codebase_assignment/features/users/data/dto/user_dto.dart';
import 'package:codebase_assignment/features/users/domain/entities/user_entity.dart';

/// Converts [UserDto] → [UserEntity]
extension UserDtoMapper on UserDto {
  UserEntity toEntity() {
    return UserEntity(
      id: id,
      email: email,
      firstName: firstName,
      lastName: lastName,
      avatar: avatar,
    );
  }
}

/// Converts [UserEntity] → [UserDto]
extension UserEntityMapper on UserEntity {
  UserDto toDto() {
    return UserDto(
      id: id,
      email: email,
      firstName: firstName,
      lastName: lastName,
      avatar: avatar,
    );
  }
}
