import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/forgot_password.dart';
import '../../domain/entities/user.dart';
import '../../domain/entities/verify_code.dart';
import '../../domain/repositories/authentication_repository.dart';
import '../datasources/remote_datasource.dart';
import '../models/recovery_password.dart';
import '../models/user_model.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final AuthenticationRemoteDataSource authenticationRemoteDataSource;
  final SharedPreferences sharedPreferences;

  AuthenticationRepositoryImpl({
    required this.authenticationRemoteDataSource,
    required this.sharedPreferences,
  });

  @override
  Future<Either<Failure, User>> signIn(String email, String password) async {
    try {
      final List<ConnectivityResult> connectivityResult =
          await (Connectivity().checkConnectivity());

      if (connectivityResult.contains(ConnectivityResult.none)) {
        return Left(ConnectionFailure('No available network connection.'));
      } else {
        final UserModel result = await authenticationRemoteDataSource.signIn(
          email,
          password,
        );

        print('auth-repository-success: ${result}');

        String userJson = jsonEncode(result.toJson());
        await sharedPreferences.setString("user", userJson);

        // if (result.token != null && result.expiresAt != null) {
        await sharedPreferences.setString(
          "auth_data",
          jsonEncode({"token": result.token, "expires_at": result.expiresAt}),
        );
        // }

        final userFromLocal = sharedPreferences.get('user');
        final tokenFromLocal = sharedPreferences.get('auth_data');

        print("from-shared-preferences-auth_data: $tokenFromLocal");

        print('from-shared-preferences-user: ${userFromLocal}');
        return Right(result);
      }
    } catch (e) {
      print(e);
      return Left(SimpleFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ForgotPasswordEntities>> forgotPassword(
    bool isWithEmail,
    String? phoneNumber,
    String? email,
  ) async {
    try {
      final List<ConnectivityResult> connectivityResult =
          await (Connectivity().checkConnectivity());

      if (connectivityResult.contains(ConnectivityResult.none)) {
        // no network
        return Left(ConnectionFailure('No available network connection.'));
      } else {
        final result = await authenticationRemoteDataSource.forgotPassword(
          isWithEmail,
          phoneNumber,
          email,
        );

        return Right(result);
      }
    } catch (e) {
      print(e);
      return Left(SimpleFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, VerifyCodeEntities>> verifyCode(
    bool isWithEmail,
    String? phoneNumber,
    String? email,
    String otp,
  ) async {
    try {
      final List<ConnectivityResult> connectivityResult =
          await (Connectivity().checkConnectivity());

      if (connectivityResult.contains(ConnectivityResult.none)) {
        // no network
        return Left(ConnectionFailure('No available network connection.'));
      } else {
        final result = await authenticationRemoteDataSource.verifyCode(
          isWithEmail,
          phoneNumber,
          email,
          otp,
        );

        return Right(result);
      }
    } catch (e) {
      return Left(SimpleFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> logout() async {
    try {
      // authenticationRemoteDataSource.logout(token);

      // final result = await sharedPreferences.remove("user");
      // await sharedPreferences.clear();

      final List<ConnectivityResult> connectivityResult =
          await (Connectivity().checkConnectivity());

      if (connectivityResult.contains(ConnectivityResult.none)) {
        print(
          'No connection found, clearing local data without logout endpoint',
        );

        return _clearLocalData();
      } else {
        // get current user
        final userResult = await getUser();

        return userResult.fold(
          (failure) {
            // no user found, just clear local data
            print('No user found for logout, clearing local data');
            return _clearLocalData();
          },
          (user) async {
            // user found, logout from server first
            if (user.token.isNotEmpty) {
              await authenticationRemoteDataSource.logout(user.token);
            }
            return _clearLocalData();
          },
        );
      }
    } catch (e) {
      print('Logout Error: $e');
      return _clearLocalData();
    }
  }

  Future<Either<Failure, bool>> _clearLocalData() async {
    try {
      await sharedPreferences.remove("user");
      await sharedPreferences.remove("home_summary");
      await sharedPreferences.clear();
      return Right(true);
    } catch (e) {
      print('Failed to clear local data: $e');
      return Left(SimpleFailure('Failed to logout'));
    }
  }

  // local
  @override
  Future<Either<Failure, User>> getUser() async {
    try {
      final userJson = sharedPreferences.getString('user');
      print('User get from local: $userJson');
      if (userJson == null) {
        return Left(SimpleFailure('No user found.'));
      }
      print('from getUser(): $userJson');
      final userModel = UserModel.fromJson(jsonDecode(userJson));
      return Right(userModel);
    } catch (e) {
      print('Error while get user from local: $e');
      return Left(SimpleFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, RecoveryPasswordModel>> recoveryPassword(
    bool isWithEmail,
    String? phoneNumber,
    String? email,
    String newPassword,
    String newPasswordConfirmation,
  ) async {
    try {
      final List<ConnectivityResult> connectivityResult =
          await (Connectivity().checkConnectivity());

      if (connectivityResult.contains(ConnectivityResult.none)) {
        print("from-recovery-password-result-in-repo-impl: No Connection");

        return Left(SimpleFailure('No Connection Available.'));
      } else {
        final result = await authenticationRemoteDataSource.recoveryPassword(
          isWithEmail,
          phoneNumber,
          email,
          newPassword,
          newPasswordConfirmation,
        );

        print("from-recovery-password-result-in-repo-impl: $result");

        return Right(result);
      }
    } catch (e) {
      print("from-recovery-password-result-in-repo-impl-error: $e");

      return Left(SimpleFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> refreshToken() async {
    try {
      final List<ConnectivityResult> connectivityResult =
          await (Connectivity().checkConnectivity());

      if (connectivityResult.contains(ConnectivityResult.none)) {
        print(
          'No connection found, clearing local data without logout endpoint',
        );

        return _clearLocalData();
      } else {
        final userResult = await getUser();

        return userResult.fold(
          (failure) {
            // no user found, just clear local data
            print('No user found for logout, clearing local data');
            return Right(false);
          },
          (user) async {
            // user found, logout from server first
            if (user.token.isNotEmpty) {
              await authenticationRemoteDataSource.refreshToken(user!.token);
            }
            return Right(true);
          },
        );
      }
    } catch (e) {
      print('Logout Error: $e');
      return Left(GeneralFailure('$e'));
    }
  }
}
