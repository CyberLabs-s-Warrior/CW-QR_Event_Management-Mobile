import 'package:dartz/dartz.dart';
import '../entities/recovery_password.dart';

import '../../../../core/error/failure.dart';
import '../entities/forgot_password.dart';
import '../entities/user.dart';
import '../entities/verify_code.dart';

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
  Future<Either<Failure, User>> getUser();
  Future<Either<Failure, RecoveryPasswordEntity>> recoveryPassword(
    bool isWithEmail,
    String? phoneNumber,
    String? email,
    String newPassword,
    String newPasswordConfirmation
  );

  Future<Either<Failure, bool>> logout();
}
