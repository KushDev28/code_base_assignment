import 'package:codebase_assignment/core/network/api_config.dart';
import 'package:codebase_assignment/core/network/api_facade.dart';
import 'package:codebase_assignment/core/service/shared_prefs/shared_pref_service.dart';
import 'package:codebase_assignment/features/users/data/api/user_api_service.dart';
import 'package:codebase_assignment/features/users/data/api/user_api_service_impl.dart';
import 'package:codebase_assignment/features/users/data/data_source/user_data_source.dart';
import 'package:codebase_assignment/features/users/data/repository/user_repository_impl.dart';
import 'package:codebase_assignment/features/users/domain/repositories/user_repository.dart';
import 'package:codebase_assignment/features/users/domain/usecase/user_usecase.dart';
import 'package:codebase_assignment/features/users/domain/usecase/user_usecase_impl.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

Future<void> setupLocator() async {
  /// Setup SharedPreferences
  final prefs = await SharedPreferencesService.getInstance();
  getIt.registerSingleton<SharedPreferencesService>(prefs);

  /// API Config & Facade
  getIt.registerSingleton<ApiConfig>(DefaultApiConfig());
  getIt.registerSingleton<ApiFacade>(ApiFacade());

  /// User API service & data source
  getIt.registerSingleton<UserApiService>(
    UserApiServiceImpl(getIt<ApiFacade>()),
  );

  getIt.registerSingleton<UserRemoteDataSource>(
    UserRemoteDataSource(getIt<UserApiService>()),
  );

  /// Repository
  getIt.registerSingleton<UserRepository>(
    UserRepositoryImpl(
      remoteDataSource: getIt<UserRemoteDataSource>(),
      prefs: getIt<SharedPreferencesService>(),
    ),
  );

  /// UseCase
  getIt.registerSingleton<UserUseCase>(
    UserUseCaseImpl(getIt<UserRepository>()),
  );
}
