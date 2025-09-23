import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/attendance_data_entity.dart';
import '../entities/event_entity.dart';
import '../entities/list_attendees_entity.dart';

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
