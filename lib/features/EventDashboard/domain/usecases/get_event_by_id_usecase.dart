import 'package:dartz/dartz.dart';
import 'package:qr_event_management/core/error/failure.dart';
import 'package:qr_event_management/features/EventDashboard/domain/entities/event_entity.dart';
import 'package:qr_event_management/features/EventDashboard/domain/repositories/event_dashboard_repository.dart';

class GetEventByIdUsecase {
  final EventDashboardRepository eventDashboardRepository;

  GetEventByIdUsecase(this.eventDashboardRepository);

  Future<Either<Failure, EventEntity>> execute(token, eventId) async {
    return await eventDashboardRepository.getEventById(token, eventId);
  }
}
