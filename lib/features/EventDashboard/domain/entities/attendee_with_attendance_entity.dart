import 'package:equatable/equatable.dart';
import 'package:qr_event_management/features/EventDashboard/domain/entities/attendance.dart';
import 'package:qr_event_management/features/EventDashboard/domain/entities/attendee.dart';

class AttendeeWithAttendanceEntity extends Equatable {
  final AttendeeEntity attendeeEntity;
  final AttendanceEntity attendanceEntity;

  const AttendeeWithAttendanceEntity({
    required this.attendeeEntity,
    required this.attendanceEntity,
  });
  
  @override
  List<Object?> get props => [attendeeEntity, attendanceEntity];
}
