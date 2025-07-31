import 'package:flutter/material.dart';
import '../../domain/entities/forgot_password.dart';
import '../../domain/entities/user.dart';
import '../../domain/entities/verify_code.dart';
import '../../domain/usecases/forgot_password.dart';
import '../../domain/usecases/sign_in.dart';
import '../../domain/usecases/verify_code.dart';

enum AuthStatus { initial, loading, success, error }

class AuthenticationProvider extends ChangeNotifier {
  final SignIn signInUseCase;
  final ForgotPassword forgotPasswordUseCase;
  final VerifyCode verifyCodeUseCase;

  AuthenticationProvider({
    required this.signInUseCase,
    required this.forgotPasswordUseCase,
    required this.verifyCodeUseCase,
  });

  // state variable
  AuthStatus _authStatus = AuthStatus.initial;
  AuthStatus _forgotPasswordStatus = AuthStatus.initial;
  AuthStatus _verifyCodeStatus = AuthStatus.initial;

  User? _currentUser;
  late ForgotPasswordEntities _forgotPasswordResult;
  late VerifyCodeEntities _verifyCodeResult;

  String? _errorMessage;

  // getter
  AuthStatus get authStatus => _authStatus;
  AuthStatus get forgotPasswordStatus => _forgotPasswordStatus;
  AuthStatus get verifyCodeStatus => _verifyCodeStatus;

  User? get currentUser => _currentUser;
  ForgotPasswordEntities? get forgotPasswordResult => _forgotPasswordResult;
  VerifyCodeEntities? get verifyCodeResult => _verifyCodeResult;

  String? get errorMessage => _errorMessage;

  bool get isLoading => _authStatus == AuthStatus.loading;
  bool get isForgotPasswordLoading =>
      _forgotPasswordStatus == AuthStatus.loading;
  bool get isVerifyCodeLoading => _verifyCodeStatus == AuthStatus.loading;

  String get cleanErrorMessage {
    if (_errorMessage == null) return 'An error occurred';

    // remop exception class name
    String cleanMessage = _errorMessage!;

    if (cleanMessage.startsWith('EmptyException: ')) {
      cleanMessage = cleanMessage.replaceFirst('EmptyException: ', '');
    }
    if (cleanMessage.startsWith('GeneralException: ')) {
      cleanMessage = cleanMessage.replaceFirst('GeneralException: ', '');
    }
    if (cleanMessage.startsWith('ServerException: ')) {
      cleanMessage = cleanMessage.replaceFirst('ServerException: ', '');
    }

    return cleanMessage;
  }

  Future<void> signIn(String email, String password) async {
    _setAuthStatus(AuthStatus.loading);

    final result = await signInUseCase.execute(email, password);
    print(result);

    result.fold(
      (failure) {
        print(
          'error message: ${failure.message}, result: ${result}, all failure: $failure',
        );
        _errorMessage = failure.message;
        _setAuthStatus(AuthStatus.error);
      },
      (user) {
        _currentUser = user;
        _setAuthStatus(AuthStatus.success);
      },
    );
  }

  Future<void> sendForgotPassword({
    required bool isWithEmail,
    String? phoneNumber,
    String? email,
  }) async {
    _setForgotPasswordStatus(AuthStatus.loading);

    final result = await forgotPasswordUseCase.execute(
      isWithEmail,
      phoneNumber,
      email,
    );

    print(result);
    result.fold(
      (failure) {
        _errorMessage = failure.message;
        _setForgotPasswordStatus(AuthStatus.error);
      },
      (forgotPasswordResult) {
        _forgotPasswordResult = forgotPasswordResult;
        _setForgotPasswordStatus(AuthStatus.success);
      },
    );
  }

  Future<void> verifyCode({
    required bool isWithEmail,
    String? phoneNumber,
    String? email,
    required String otp,
  }) async {
    _setVerifyCodeStatus(AuthStatus.loading);

    final result = await verifyCodeUseCase.execute(
      isWithEmail,
      phoneNumber,
      email,
      otp,
    );

    result.fold(
      (failure) {
        _errorMessage = failure.message;
        _setVerifyCodeStatus(AuthStatus.error);
      },
      (verifyCodeResult) {
        _verifyCodeResult = verifyCodeResult;
        _setVerifyCodeStatus(AuthStatus.success);
      },
    );
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  // reset states
  void resetAuthStatus() {
    _setAuthStatus(AuthStatus.initial);
  }

  void resetForgotPasswordStatus() {
    _setForgotPasswordStatus(AuthStatus.initial);
  }

  void resetVerifyCodeStatus() {
    _setVerifyCodeStatus(AuthStatus.initial);
  }

  // private mthod
  void _setAuthStatus(AuthStatus status) {
    _authStatus = status;
    notifyListeners();
  }

  void _setForgotPasswordStatus(AuthStatus status) {
    _forgotPasswordStatus = status;
    notifyListeners();
  }

  void _setVerifyCodeStatus(AuthStatus status) {
    _verifyCodeStatus = status;
    notifyListeners();
  }
}
