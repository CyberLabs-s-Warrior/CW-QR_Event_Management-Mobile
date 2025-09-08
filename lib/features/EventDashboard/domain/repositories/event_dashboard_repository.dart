import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/event_entity.dart';

abstract class EventDashboardRepository {
  Future<Either<Failure, EventEntity>> getEventById(token, eventId); 
}