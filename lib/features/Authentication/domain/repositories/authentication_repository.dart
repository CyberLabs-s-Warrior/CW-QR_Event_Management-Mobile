import 'package:qr_event_management/features/Authentication/domain/entities/user.dart';

abstract class AuthenticationRepository {
  Future<User> login(User login);
}
