import 'package:qr_event_management/features/EventDashboard/domain/entities/attendee.dart';

class AttendeeModel extends AttendeeEntity {
  final String firstName;
  final String lastName;

  const AttendeeModel({
    required super.id,
    required this.firstName,
    required this.lastName,
    required super.phoneNumber,
    required super.email,
    required super.code,
    required super.createdAt,
    required super.updatedAt,
  }) : super(fullName: "$firstName $lastName");

  factory AttendeeModel.fromJson(Map<String, dynamic> data) {
    return AttendeeModel(
      firstName: data['first_name'] ?? '',
      lastName: data['last_name'] ?? '',
      id: data['id'] ,
      phoneNumber: data['phone_number'] ?? '-',
      email: data['email'] ?? '-',
      code: data['code'] ?? '-',
      createdAt: data['created_at'] ?? '-',
      updatedAt: data['updated_at'] ?? '-',
    );
  }
  

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'phone_number': phoneNumber,
      'email': email,
      'code': code,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
