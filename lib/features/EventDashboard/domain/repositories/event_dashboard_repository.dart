import 'package:dartz/dartz.dart';
import 'package:qr_event_management/features/EventDashboard/domain/entities/attendance_data_entity.dart';
import 'package:qr_event_management/features/EventDashboard/domain/entities/list_attendees_entity.dart';

import '../../../../core/error/failure.dart';
import '../entities/event_entity.dart';

abstract class EventDashboardRepository {
  Future<Either<Failure, EventEntity>> getEventById(token, eventId);
  Future<Either<Failure, AttendanceDataEntity>> scanAttendance(
    token,
    eventId,
    code,
  );
  Future<Either<Failure, AttendanceDataEntity>> scanIdentityCheck(
    token,
    eventId,
    code,
  );
  Future<Either<Failure, ListAttendeesEntity>> getEventAttendees(
    token,
    eventId,
  );
  Future<Either<Failure, bool>> updateAttendeesStatus(
    token,
    eventId,
    List<Map<String, dynamic>> attendeesData,
  );
}
