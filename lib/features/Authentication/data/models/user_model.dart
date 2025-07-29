import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.username,
    required super.email,
    required super.createdAt,
    required super.updatedAt,
    required super.role,
    required super.phoneNumber,
  });

  // convert object json ke model
  factory UserModel.fromJson(Map<String, dynamic> data) {
    return UserModel(
      id: data['id'],
      username: data['username'],
      email: data['email'],
      createdAt: data['created_at'],
      updatedAt: data['updated_at'],
      role: data['role'],
      phoneNumber: data['phone_number'],
    );
  }

  // convert model ke json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'updated_at': updatedAt,
      'created_at': createdAt,
      'phone_number': phoneNumber,
      'role': role,
    };
  }
}
