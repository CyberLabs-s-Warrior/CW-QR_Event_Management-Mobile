import 'package:flutter/material.dart';
import '../../domain/entities/authorization_entity.dart';
import '../../domain/usecases/get_user_from_api.dart';

import '../../../../core/error/clean_error_message_cleaner.dart';
import '../../domain/entities/forgot_password.dart';
import '../../domain/entities/recovery_password.dart';
import '../../domain/entities/user.dart';
import '../../domain/entities/verify_code.dart';
import '../../domain/usecases/forgot_password.dart';
import '../../domain/usecases/get_user.dart';
import '../../domain/usecases/logout.dart';
import '../../domain/usecases/recovery_password.dart';
import '../../domain/usecases/refresh_token.dart';
import '../../domain/usecases/sign_in.dart';
import '../../domain/usecases/verify_code.dart';

enum AuthStatus { initial, loading, success, error }

class AuthenticationProvider extends ChangeNotifier {
  // logout

  final SignIn signInUseCase;
  final ForgotPassword forgotPasswordUseCase;
  final VerifyCode verifyCodeUseCase;
  final GetUser getUserUseCase;
  final Logout logoutUseCase;
  final RecoveryPassword recoveryPasswordUseCase;
  final RefreshToken refreshTokenUsecase;
  final GetUserFromApi getUserFromApiUsecase;

  AuthenticationProvider({
    required this.getUserUseCase,
    required this.signInUseCase,
    required this.logoutUseCase,
    required this.forgotPasswordUseCase,
    required this.verifyCodeUseCase,
    required this.recoveryPasswordUseCase,
    required this.refreshTokenUsecase,
    required this.getUserFromApiUsecase,
  });

  // state variable \/ init
  AuthStatus _authStatus = AuthStatus.initial;
  AuthStatus _forgotPasswordStatus = AuthStatus.initial;
  AuthStatus _verifyCodeStatus = AuthStatus.initial;
  AuthStatus _logoutStatus = AuthStatus.initial;
  AuthStatus _recoveryPasswordStatus = AuthStatus.initial;
  AuthStatus _getUserStatus = AuthStatus.initial;
  AuthStatus _refreshTokenStatus = AuthStatus.initial;
  AuthStatus _getUserFromApiStatus = AuthStatus.initial;

  AuthorizationEntity? _authorization;
  User? _userProfile;
  late ForgotPasswordEntities _forgotPasswordResult;
  late VerifyCodeEntities _verifyCodeResult;
  late RecoveryPasswordEntity _recoveryPasswordResult;

  String? _errorMessage;

  // getter
  AuthStatus get authStatus => _authStatus;
  AuthStatus get forgotPasswordStatus => _forgotPasswordStatus;
  AuthStatus get verifyCodeStatus => _verifyCodeStatus;
  AuthStatus get logoutStatus => _logoutStatus;
  AuthStatus get recoveryPasswordStatus => _recoveryPasswordStatus;
  AuthStatus get getUserStatus => _getUserStatus;
  AuthStatus get refreshTokenStatus => _refreshTokenStatus;
  AuthStatus get getUserFromApiStatus => _getUserFromApiStatus;

  // getter data location
  AuthorizationEntity? get authorization => _authorization;
  User? get userProfile => _userProfile;
  ForgotPasswordEntities? get forgotPasswordResult => _forgotPasswordResult;
  VerifyCodeEntities? get verifyCodeResult => _verifyCodeResult;
  RecoveryPasswordEntity? get recoveryPasswordResult => _recoveryPasswordResult;

  String? get errorMessage => _errorMessage;

  // getter loading
  bool get isLoading => _authStatus == AuthStatus.loading;
  bool get isForgotPasswordLoading =>
      _forgotPasswordStatus == AuthStatus.loading;
  bool get isVerifyCodeLoading => _verifyCodeStatus == AuthStatus.loading;
  bool get isRecoveryPasswordLoading =>
      _recoveryPasswordStatus == AuthStatus.loading;
  bool get isGetUserStatus => _getUserStatus == AuthStatus.loading;
  bool get isRefreshTokenStatus => _refreshTokenStatus == AuthStatus.loading;
  bool get isGetUserFromApiStatus =>
      _getUserFromApiStatus == AuthStatus.loading;

  String get cleanErrorMessage => _errorMessage.cleanErrorMessage;

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
        _authorization = user;
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

  Future<void> getUser() async {
    _setGetUserStatus(AuthStatus.loading);

    final result = await getUserUseCase.execute();
    result.fold(
      (failure) {
        _errorMessage = failure.message;
        _setGetUserStatus(AuthStatus.error);
      },
      (user) {
        _userProfile = user;
        _setGetUserStatus(AuthStatus.success);
      },
    );
  }

  Future<void> getUserFromApi({required String token}) async {
    _setGetUserFromApi(AuthStatus.loading);

    final result = await getUserFromApiUsecase.execute(token);
    result.fold(
      (failure) {
        _errorMessage = failure.message;
        _setGetUserFromApi(AuthStatus.error);
      },
      (user) {
        _userProfile = user;
        _setGetUserFromApi(AuthStatus.success);
      },
    );
  }

  Future<void> logout() async {
    _logoutStatus = AuthStatus.loading;
    notifyListeners();

    final result = await logoutUseCase.execute();

    result.fold(
      (failure) {
        print('Logout failed : ${failure.message}');
        _logoutStatus = AuthStatus.error;
      },
      (success) {
        print('Logout successful');

        resetAllStatus();
      },
    );
  }

  Future<void> refreshToken() async {
    _setRefreshTokenStatus(AuthStatus.loading);

    final result = await refreshTokenUsecase.execute();

    result.fold(
      (failure) {
        print('Logout failed : ${failure.message}');
        _setRefreshTokenStatus(AuthStatus.error);
      },
      (success) {
        print('logout successful');

        _setRefreshTokenStatus(AuthStatus.error);
      },
    );
  }

  void resetState() {
    _userProfile = null;
    _authorization = null;
    notifyListeners();
  }

  Future<void> recoveryPassword({
    required bool isWithEmail,
    String? phoneNumber,
    String? email,
    required String newPassword,
    required String newPasswordConfirmation,
  }) async {
    _setRecoveryPasswordStatus(AuthStatus.loading);

    final result = await recoveryPasswordUseCase.execute(
      isWithEmail,
      phoneNumber,
      email,
      newPassword,
      newPasswordConfirmation,
    );

    result.fold(
      (failure) {
        _errorMessage = failure.message;
        print('recovery-password-in-fold: ${failure.message}');
        _setRecoveryPasswordStatus(AuthStatus.error);
      },
      (result) {
        _setRecoveryPasswordStatus(AuthStatus.success);
      },
    );
  }

  // reset states
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  void resetAuthStatus() {
    _setAuthStatus(AuthStatus.initial);
  }

  void resetForgotPasswordStatus() {
    _setForgotPasswordStatus(AuthStatus.initial);
  }

  void resetVerifyCodeStatus() {
    _setVerifyCodeStatus(AuthStatus.initial);
  }

  void resetLogoutStatus() {
    _setLogoutStatus(AuthStatus.initial);
  }

  void resetRecoveryPasswordStatus() {
    _setRecoveryPasswordStatus(AuthStatus.initial);
  }

  void resetGetUserStatus() {
    _setGetUserStatus(AuthStatus.initial);
  }

  void resetRefreshToken() {
    _setRefreshTokenStatus(AuthStatus.initial);
  }

  void _resetGetUserFromApi() {
    _setGetUserFromApi(AuthStatus.initial);
  }

  void resetAllStatus() {
    resetLogoutStatus();
    resetAuthStatus();
    resetForgotPasswordStatus();
    resetVerifyCodeStatus();
    resetRecoveryPasswordStatus();
    resetGetUserStatus();
    resetRefreshToken();
    _resetGetUserFromApi();
  }

  // private method
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

  void _setLogoutStatus(AuthStatus status) {
    _logoutStatus = status;
    notifyListeners();
  }

  void _setRecoveryPasswordStatus(AuthStatus status) {
    _recoveryPasswordStatus = status;
    notifyListeners();
  }

  void _setGetUserStatus(AuthStatus status) {
    _getUserStatus = status;
    notifyListeners();
  }

  void _setRefreshTokenStatus(AuthStatus status) {
    _refreshTokenStatus = status;
    notifyListeners();
  }

  void _setGetUserFromApi(AuthStatus status) {
    _getUserFromApiStatus = status;
    notifyListeners();
  }
}
