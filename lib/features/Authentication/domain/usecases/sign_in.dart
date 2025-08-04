import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/user.dart';
import '../repositories/authentication_repository.dart';

class SignIn {
  final AuthenticationRepository authenticationRepository;

  const SignIn(this.authenticationRepository);

  Future<Either<Failure, User>> execute(String email, String password) async {
    return await authenticationRepository.signIn(email, password);
  }
}
