import 'package:dartz/dartz.dart';
import 'package:qr_event_management/core/error/failure.dart';
import 'package:qr_event_management/features/EventDashboard/domain/entities/attendance_data_entity.dart';
import 'package:qr_event_management/features/EventDashboard/domain/repositories/event_dashboard_repository.dart';

class ScanAttendanceUsecase {
  final EventDashboardRepository eventDashboardRepository;

  ScanAttendanceUsecase(this.eventDashboardRepository);

  Future<Either<Failure, AttendanceDataEntity>> execute(
    token,
    eventId,
    code,
  ) async {
    return await eventDashboardRepository.scanAttendance(token, eventId, code);
  }
}
