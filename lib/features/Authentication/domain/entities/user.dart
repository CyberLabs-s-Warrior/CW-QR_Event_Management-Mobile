import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String username;
  final String email;
  final String createdAt;
  final String updatedAt;

  const User({
    required this.username,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [username, email, createdAt, updatedAt];
}
