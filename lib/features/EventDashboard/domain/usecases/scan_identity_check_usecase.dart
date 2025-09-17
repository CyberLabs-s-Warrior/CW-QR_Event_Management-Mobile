import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/attendance_data_entity.dart';
import '../repositories/event_dashboard_repository.dart';

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
