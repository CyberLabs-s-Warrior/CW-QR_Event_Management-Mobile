import 'package:equatable/equatable.dart';
import 'package:qr_event_management/features/EventDashboard/domain/entities/attendee_with_attendance_entity.dart';

class ListAttendeesEntity extends Equatable {
  final List<AttendeeWithAttendanceEntity> attendeeWithAttendance;
  final bool success;

  const ListAttendeesEntity({
    required this.attendeeWithAttendance,
    required this.success,
  });

  @override
  List<Object?> get props => [attendeeWithAttendance];
}
