import 'package:codebase_assignment/features/users/domain/entities/user_entity.dart';

class UserResponseEntity {
  final int page;
  final int perPage;
  final int total;
  final int totalPages;
  final List<UserEntity> users;

  const UserResponseEntity({
    required this.page,
    required this.perPage,
    required this.total,
    required this.totalPages,
    required this.users,
  });
}
