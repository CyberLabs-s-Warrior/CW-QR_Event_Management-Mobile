import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';

import '../entities/forgot_password.dart';
import '../entities/verify_code.dart';

import '../entities/user.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, User>> signIn(String email, String password);
  Future<Either<Failure, ForgotPasswordEntities>> forgotPassword(
    bool isWithEmail,
    String? phoneNumber,
    String? email,
  );
  Future<Either<Failure, VerifyCodeEntities>> verifyCode(
    bool isWithEmail,
    String? phoneNumber,
    String? email,
    String otp,
  );

  void logout(String token);
}
