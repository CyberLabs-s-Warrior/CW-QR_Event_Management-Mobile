import 'package:equatable/equatable.dart';

class AuthToken extends Equatable {
  final String token;
  final DateTime expiresAt;

  const AuthToken(this.token, this.expiresAt);

  bool get isExpired => DateTime.now().isAfter(expiresAt);

  @override
  List<Object?> get props => [token, expiresAt];
}
