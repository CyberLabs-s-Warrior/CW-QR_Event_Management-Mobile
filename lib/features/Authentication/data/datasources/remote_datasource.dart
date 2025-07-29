import '../models/user_model.dart';
import '../../domain/entities/verify_code.dart';
import '../../domain/usecases/forgot_password.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> signIn(String email, String password);
  Future<ForgotPassword> forgotPassword(
    bool isWithEmail,
    String? phoneNumber,
    String? email,
  );
  Future<VerifyCodeEntities> verifyCode(
    bool isWithEmail,
    String? phoneNumber,
    String? email,
    String otp,
  );

  void logout(String token);
}
