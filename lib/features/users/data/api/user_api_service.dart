import 'package:codebase_assignment/features/users/data/dto/user_response_dto.dart';

abstract class UserApiService {
  Future<UserResponseDto> getUsers({required int page,required int perPage});
}
