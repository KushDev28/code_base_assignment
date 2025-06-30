import 'package:codebase_assignment/core/network/api_error.dart';
import 'package:codebase_assignment/core/network/api_result.dart';
import 'package:codebase_assignment/features/users/data/api/user_api_service.dart';
import 'package:codebase_assignment/features/users/data/dto/user_response_dto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class UserRemoteDataSource {
  final UserApiService apiService;

  UserRemoteDataSource(this.apiService);

  Future<ApiResult<UserResponseDto>> fetchUsers({
    required int page,
    required int perPage,
  }) async {
    try {
      final dto = await apiService.getUsers(page: page, perPage: perPage);
      return Success(dto);
    } on DioException catch (e) {
      debugPrint("DioException: ${e.message}");
      return ServerError(ApiError(message: e.message));
    } catch (e) {
      debugPrint("Unexpected error: $e");
      return InternalError("Unexpected error: $e");
    }
  }
}
