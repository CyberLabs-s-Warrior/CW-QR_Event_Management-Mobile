import 'package:dartz/dartz.dart';
import 'package:qr_event_management/core/error/failure.dart';
import 'package:qr_event_management/features/EventDashboard/domain/entities/attendance_data_entity.dart';
import 'package:qr_event_management/features/EventDashboard/domain/repositories/event_dashboard_repository.dart';

class ScanIdentityCheckUsecase {
  final EventDashboardRepository eventDashboardRepository;

  ScanIdentityCheckUsecase(this.eventDashboardRepository);

  Future<Either<Failure, AttendanceDataEntity>> execute(
    token,
    eventId,
    code,
  ) async {
    return await eventDashboardRepository.scanIdentityCheck(token, eventId, code);
  }
}
