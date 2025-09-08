import 'package:flutter/material.dart';
import '../../../../core/constant/enum_status.dart';
import '../../../../core/error/clean_error_message_cleaner.dart';
import '../../domain/usecases/change_password_usecase.dart';

class ChangePasswordProvider extends ChangeNotifier {
  final ChangePasswordUsecase changePasswordUsecase;

  ChangePasswordProvider({required this.changePasswordUsecase});

  String? _errorMessage;
  String? _message;

  String? get cleanErrorMessage => _errorMessage.cleanErrorMessage;
  String? get message => _message;
  ResponseStatus _changePasswordStatus = ResponseStatus.initial;

  ResponseStatus get changePasswordStatus => _changePasswordStatus;

  void _setChangePasswordStatus(ResponseStatus status) {
    _changePasswordStatus = status;
    notifyListeners();
  }

  Future<void> changePassword({
    required String token,
    required int userId,
    required String currentPassword,
    required String newPassword,
    required String newPasswordConfirmation,
  }) async {
    _setChangePasswordStatus(ResponseStatus.loading);

    final result = await changePasswordUsecase.execute(
      token: token,
      userId: userId,
      currentPassword: currentPassword,
      newPassword: newPassword,
      newPasswordConfirmation: newPasswordConfirmation,
    );

    result.fold(
      (failure) {
        _errorMessage = failure.message;
        _setChangePasswordStatus(ResponseStatus.error);
      },
      (message) {
        _message = message;
        _setChangePasswordStatus(ResponseStatus.success);
      },
    );
  }

  void resetAllStatus() {
    _changePasswordStatus = ResponseStatus.initial;
    _message = null;
    _errorMessage = null;
    notifyListeners();
  }
}
