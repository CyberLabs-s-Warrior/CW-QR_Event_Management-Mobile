import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String username;
  final String email;
  final String phoneNumber;
  final String role;
  final String createdAt;
  final String updatedAt;

  const User({
    required this.id,
    required this.username,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
    required this.role,
    required this.phoneNumber,
  });

  @override
  List<Object?> get props => [
    username,
    email,
    createdAt,
    updatedAt,
    role,
    phoneNumber,
  ];
}
