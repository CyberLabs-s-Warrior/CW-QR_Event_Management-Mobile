import 'package:dartz/dartz.dart';
import 'package:qr_event_management/core/error/failure.dart';
import 'package:qr_event_management/features/Authentication/domain/entities/verify_code.dart';
import 'package:qr_event_management/features/Authentication/domain/repositories/authentication_repository.dart';

class VerifyCode {
  final AuthenticationRepository authenticationRepository;

  VerifyCode(this.authenticationRepository);

  Future<Either<Failure, VerifyCodeEntities>> execute(
    isWithEmail,
    phoneNumber,
    email,
    otp,
  ) async {
    return await authenticationRepository.verifyCode(
      isWithEmail,
      phoneNumber,
      email,
      otp,
    );
  }
}
