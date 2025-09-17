import 'package:qr_event_management/features/EventDashboard/data/models/attendance_model.dart';
import 'package:qr_event_management/features/EventDashboard/data/models/attendee_model.dart';
import 'package:qr_event_management/features/EventDashboard/domain/entities/attendee_with_attendance_entity.dart';

class AttendeeWithAttendanceModel extends AttendeeWithAttendanceEntity {
  const AttendeeWithAttendanceModel({
    required super.attendeeEntity,
    required super.attendanceEntity,
  });

  factory AttendeeWithAttendanceModel.fromJson(Map<String, dynamic> data) {
    return AttendeeWithAttendanceModel(
      attendeeEntity: AttendeeModel.fromJson(data),
      attendanceEntity: AttendanceModel.fromJson(data['attendance']),
    );
  }

  static List<AttendeeWithAttendanceModel> fromJsonList(List data) {
    if (data.isEmpty) return [];

    return data
        .map((singleAttendee) => AttendeeWithAttendanceModel.fromJson(singleAttendee))
        .toList();
  }
}
