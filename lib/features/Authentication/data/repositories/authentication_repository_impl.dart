import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import '../models/user_model.dart';
import '../../../../core/error/failure.dart';
import '../datasources/remote_datasource.dart';
import '../../domain/entities/forgot_password.dart';
import '../../domain/entities/user.dart';
import '../../domain/entities/verify_code.dart';
import '../../domain/repositories/authentication_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

        final userFromLocal = await sharedPreferences.get('user');

        print('from-shared-preferences: ${userFromLocal}');
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
  void logout(String token) async {
    try {
      authenticationRemoteDataSource.logout(token);

      await sharedPreferences.remove("user");
    } catch (e) {
      print('Failed');
    }
  }
}
