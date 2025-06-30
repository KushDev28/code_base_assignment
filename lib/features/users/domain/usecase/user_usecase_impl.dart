import 'package:codebase_assignment/core/network/api_result.dart';
import 'package:codebase_assignment/features/users/domain/entities/user_entity.dart';
import 'package:codebase_assignment/features/users/domain/repositories/user_repository.dart';
import 'user_usecase.dart';

class UserUseCaseImpl implements UserUseCase {
  final UserRepository repository;

  UserUseCaseImpl(this.repository);

  @override
  Future<ApiResult<List<UserEntity>>> getUsers({
    int page = 1,
    int perPage = 10,
  }) {
    return repository.getUsers(page: page, perPage: perPage);
  }
}
