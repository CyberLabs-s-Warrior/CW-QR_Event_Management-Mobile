import '../../domain/entities/auth_token.dart';

class AuthTokenModel extends AuthToken {
  const AuthTokenModel({required super.token, required super.expiresAt});

  factory AuthTokenModel.fromJson(Map<String, dynamic> data) {
    return AuthTokenModel(token: data['token'], expiresAt: data['expires_at']);
  }

  Map<String, dynamic> toJson() {
    return {'token': token, 'expires_at': expiresAt};
  }
}
