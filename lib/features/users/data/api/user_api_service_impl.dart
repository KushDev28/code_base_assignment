import 'package:codebase_assignment/core/constants/api_constant.dart';
import 'package:codebase_assignment/core/network/api_facade.dart';
import 'package:codebase_assignment/features/users/data/api/user_api_service.dart';
import 'package:codebase_assignment/features/users/data/dto/user_response_dto.dart';

class UserApiServiceImpl implements UserApiService {
  final ApiFacade apiFacade;

  UserApiServiceImpl(this.apiFacade);

  @override
  Future<UserResponseDto> getUsers({
    required int page,
    required int perPage,
  }) async {
    final response = await apiFacade.get(
      ApiConstants.users,
      queryParams: {
        'page': page,
        'per_page': perPage,
      },

    );

    return UserResponseDto.fromJson(response.data);
  }
}
