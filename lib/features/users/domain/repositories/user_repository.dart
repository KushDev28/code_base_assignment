import 'package:codebase_assignment/core/network/api_result.dart';
import 'package:codebase_assignment/features/users/domain/entities/user_entity.dart';


abstract class UserRepository {
  Future<ApiResult<List<UserEntity>>> getUsers({
    int page,
    int perPage,
  });
}