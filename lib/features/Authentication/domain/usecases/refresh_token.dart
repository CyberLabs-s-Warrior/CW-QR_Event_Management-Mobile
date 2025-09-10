import 'package:dartz/dartz.dart';
import 'package:qr_event_management/features/Authentication/domain/entities/authorization_entity.dart';

import '../../../../core/error/failure.dart';
import '../repositories/authentication_repository.dart';

class RefreshToken {
  final AuthenticationRepository authenticationRepository;

  RefreshToken( this.authenticationRepository);

  Future<Either<Failure, AuthorizationEntity>> execute(String token) async {
    return await authenticationRepository.refreshToken(token);
  }
}
