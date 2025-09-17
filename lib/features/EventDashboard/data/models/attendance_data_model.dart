import 'package:qr_event_management/features/EventDashboard/data/models/attendance_model.dart';
import 'package:qr_event_management/features/EventDashboard/data/models/attendee_model.dart';
import 'package:qr_event_management/features/EventDashboard/domain/entities/attendance_data_entity.dart';

class AttendanceDataModel extends AttendanceDataEntity {
  const AttendanceDataModel({
    required super.attendanceEntity,
    required super.attendeeEntity,
    required super.success,
    required super.message,
    required super.qrCode,
  });

  factory AttendanceDataModel.fromJson(Map<String, dynamic> data) {
    return AttendanceDataModel(
      attendanceEntity: AttendanceModel.fromJson(data['data']['attendance']),
      attendeeEntity: AttendeeModel.fromJson(data['data']['attendee']),
      qrCode: data['data']['qr_code']['qrcode_data'] ?? '',
      success: data['success'] ?? false,
      message: data['message'] ?? '',
    );
  }

  
}
