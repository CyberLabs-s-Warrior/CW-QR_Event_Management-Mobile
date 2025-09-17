import 'package:dartz/dartz.dart';
import 'package:qr_event_management/core/error/failure.dart';
import 'package:qr_event_management/features/EventDashboard/domain/entities/list_attendees_entity.dart';
import 'package:qr_event_management/features/EventDashboard/domain/repositories/event_dashboard_repository.dart';

class GetEventAttendeesUsecase {
  final EventDashboardRepository eventDashboardRepository;

  GetEventAttendeesUsecase(this.eventDashboardRepository);

  Future<Either<Failure, ListAttendeesEntity>> execute(token, eventId) async {
    return await eventDashboardRepository.getEventAttendees(token, eventId);
  }
}