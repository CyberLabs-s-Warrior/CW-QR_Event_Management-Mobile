import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:qr_event_management/features/Home/data/datasources/home_local_datasource.dart';
import 'package:qr_event_management/features/Home/data/datasources/home_remote_datasource.dart';
import 'package:qr_event_management/features/Home/data/datasources/home_remote_datasource_implementation.dart';
import 'package:qr_event_management/features/Home/data/repositories/home_repository_implementation.dart';
import 'package:qr_event_management/features/Home/domain/repositories/home_repository.dart';
import 'package:qr_event_management/features/Home/domain/usecases/home_summary_usecase.dart';
import 'package:qr_event_management/features/Home/presentation/provider/home_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/Authentication/data/datasources/remote_datasource.dart';
import 'features/Authentication/data/repositories/authentication_repository_impl.dart';
import 'features/Authentication/domain/repositories/authentication_repository.dart';
import 'features/Authentication/domain/usecases/forgot_password.dart';
import 'features/Authentication/domain/usecases/get_user.dart';
import 'features/Authentication/domain/usecases/logout.dart';
import 'features/Authentication/domain/usecases/recovery_password.dart';
import 'features/Authentication/domain/usecases/sign_in.dart';
import 'features/Authentication/domain/usecases/verify_code.dart';
import 'features/Authentication/presentation/provider/authentication_provider.dart';

final GetIt myInjection = GetIt.instance;

Future<void> init() async {
  // External dependencies
  final sharedPreferences = await SharedPreferences.getInstance();
  myInjection.registerLazySingleton(() => sharedPreferences);
  myInjection.registerLazySingleton(() => http.Client());

  // Data sources
  myInjection.registerLazySingleton<AuthenticationRemoteDataSource>(
    //auth
    () => AuthenticationRemoteDataSourceImplementation(client: myInjection()),
  );
  myInjection.registerLazySingleton<HomeRemoteDatasource>(
    //home
    () => HomeRemoteDatasourceImplementation(
      client: myInjection(),
    ),
  );
  myInjection.registerLazySingleton<HomeLocalDatasource>(
    // home
    () =>
        HomeLocalDatasourceImplementation(sharedPreferences: sharedPreferences),
  );

  // Repository
  myInjection.registerLazySingleton<AuthenticationRepository>(
    // auth
    () => AuthenticationRepositoryImpl(
      authenticationRemoteDataSource: myInjection(),
      sharedPreferences: sharedPreferences,
    ),
  );

  myInjection.registerLazySingleton<HomeRepository>(
    // home
    () => HomeRepositoryImplementation(
      homeRemoteDatasource: myInjection(),
      homeLocalDatasource: myInjection(),
      sharedPreferences: sharedPreferences,
    ),
  );

  // Use Cases
  myInjection.registerLazySingleton(() => SignIn(myInjection()));
  myInjection.registerLazySingleton(() => ForgotPassword(myInjection()));
  myInjection.registerLazySingleton(() => VerifyCode(myInjection()));
  myInjection.registerLazySingleton(() => GetUser(myInjection()));
  myInjection.registerLazySingleton(() => Logout(myInjection()));
  myInjection.registerLazySingleton(() => RecoveryPassword(myInjection()));
  myInjection.registerLazySingleton(() => HomeSummaryUsecase(myInjection()));

  // Providers
  myInjection.registerFactory(
    () => AuthenticationProvider(
      signInUseCase: myInjection(),
      forgotPasswordUseCase: myInjection(),
      verifyCodeUseCase: myInjection(),
      getUserUseCase: myInjection(),
      logoutUseCase: myInjection(),
      recoveryPasswordUseCase: myInjection(),
    ),
  );

  myInjection.registerFactory(
    () => HomeProvider(homeSummaryUsecase: myInjection()),
  );
}
