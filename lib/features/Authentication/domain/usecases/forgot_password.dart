import 'package:dartz/dartz.dart';
import 'package:qr_event_management/core/error/failure.dart';
import 'package:qr_event_management/features/Authentication/domain/entities/forgot_password_model.dart';
import 'package:qr_event_management/features/Authentication/domain/repositories/authentication_repository.dart';

class ForgotPassword {
  final AuthenticationRepository authenticationRepository;

  const ForgotPassword(this.authenticationRepository);

  Future<Either<Failure, ForgotPasswordEntities>> execute(
    isWithEmail,
    phoneNumber,
    email,
  ) async {
    return await authenticationRepository.forgotPassword(
      isWithEmail,
      phoneNumber,
      email,
    );
  }
}
