import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'features/Authentication/domain/usecases/recovery_password.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/Authentication/data/datasources/remote_datasource.dart';
import 'features/Authentication/data/repositories/authentication_repository_impl.dart';
import 'features/Authentication/domain/repositories/authentication_repository.dart';
import 'features/Authentication/domain/usecases/forgot_password.dart';
import 'features/Authentication/domain/usecases/get_user.dart';
import 'features/Authentication/domain/usecases/logout.dart';
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
    () => AuthenticationRemoteDataSourceImplementation(client: myInjection()),
  );

  // Repository
  myInjection.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(
      authenticationRemoteDataSource: myInjection(),
      sharedPreferences: myInjection(),
    ),
  );

  // Use Cases
  myInjection.registerLazySingleton(() => SignIn(myInjection()));
  myInjection.registerLazySingleton(() => ForgotPassword(myInjection()));
  myInjection.registerLazySingleton(() => VerifyCode(myInjection()));
  myInjection.registerLazySingleton(() => GetUser(myInjection()));
  myInjection.registerLazySingleton(() => Logout(myInjection()));
  myInjection.registerLazySingleton(() => RecoveryPassword(myInjection()));

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
}
