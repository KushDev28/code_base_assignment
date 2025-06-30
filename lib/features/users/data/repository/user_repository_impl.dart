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

      if (page == 1) {
        await prefs.cacheUserDtos(userDtos);
      }

      final userEntities = userDtos.map((dto) => dto.toEntity()).toList();

      return Success(userEntities);
    }

    if (page == 1 &&
        (result is Failed || result is ServerError || result is InternalError)) {
      final cachedDtos = prefs.getCachedUserDtos();
      if (cachedDtos.isNotEmpty) {
        final cachedEntities = cachedDtos.map((dto) => dto.toEntity()).toList();
        return Success(cachedEntities);
      }
    }

    if (result is Failed) return Failed((result as Failed).error);
    if (result is ServerError) return ServerError((result as ServerError).error);
    if (result is InternalError) return InternalError((result as InternalError).message);

    return InternalError("Unknown error in UserRepositoryImpl");
  }
}


