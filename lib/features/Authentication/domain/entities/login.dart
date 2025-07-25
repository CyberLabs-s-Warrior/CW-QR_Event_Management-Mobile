import 'package:equatable/equatable.dart';

class Login extends Equatable {
  final String username;
  final String email;
  final String expired;
  final String jwtExpired;

  const Login({
    required this.username,
    required this.email,
    required this.expired,
    required this.jwtExpired,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [username, email, expired, jwtExpired];
}
