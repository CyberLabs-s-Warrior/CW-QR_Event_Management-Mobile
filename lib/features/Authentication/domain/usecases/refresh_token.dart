import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../repositories/authentication_repository.dart';

class RefreshToken {
  final AuthenticationRepository authenticationRepository;

  RefreshToken( this.authenticationRepository);

  Future<Either<Failure, bool>> execute() async {
    return await authenticationRepository.refreshToken();
  }
}
