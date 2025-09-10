import 'package:dartz/dartz.dart';
import 'package:qr_event_management/core/error/failure.dart';
import 'package:qr_event_management/features/Authentication/domain/entities/authorization_entity.dart';
import 'package:qr_event_management/features/Authentication/domain/repositories/authentication_repository.dart';

class GetAuthorization {
  final AuthenticationRepository authenticationRepository;

  GetAuthorization(this.authenticationRepository);

  Future<Either<Failure, AuthorizationEntity>> execute() {
    return authenticationRepository.getAuthorization();
  }
}
