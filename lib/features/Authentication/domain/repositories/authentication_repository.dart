import '../entities/user.dart';

abstract class AuthenticationRepository {
  Future<User> login(User login);
}
