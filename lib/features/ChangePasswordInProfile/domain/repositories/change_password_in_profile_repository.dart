import 'package:dartz/dartz.dart';
import 'package:qr_event_management/core/error/failure.dart';

abstract class ChangePasswordInProfileRepository {
  Future<Either<Failure, String>> changePassword(token, userId);
}