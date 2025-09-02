import 'package:dartz/dartz.dart';
import 'package:qr_event_management/core/error/failure.dart';
import 'package:qr_event_management/features/ChangePasswordInProfile/domain/repositories/change_password_in_profile_repository.dart';

class ChangePasswordUsecase {
  final ChangePasswordInProfileRepository changePasswordInProfileRepository;

  ChangePasswordUsecase(this.changePasswordInProfileRepository);

  Future<Either<Failure, String>> execute(token, userId) async {
    return await changePasswordInProfileRepository.changePassword(
      token,
      userId,
    );
  }
}
