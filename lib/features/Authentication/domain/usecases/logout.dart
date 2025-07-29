import 'package:qr_event_management/features/Authentication/domain/repositories/authentication_repository.dart';

class Logout {
  final AuthenticationRepository authenticationRepository;

  const Logout(this.authenticationRepository);

  void execute(String token) {
    return authenticationRepository.logout(token);
  }
}
