import 'package:dartz/dartz.dart';
import 'package:qr_event_management/core/error/failure.dart';
import 'package:qr_event_management/features/Authentication/domain/entities/user.dart';
import 'package:qr_event_management/features/Authentication/domain/repositories/authentication_repository.dart';

class SignIn {
  final AuthenticationRepository authenticationRepository;

  const SignIn(this.authenticationRepository);

  Future<Either<Failure, User>> execute(String email, String password) async {
    return await authenticationRepository.signIn(email, password);
  }
}
