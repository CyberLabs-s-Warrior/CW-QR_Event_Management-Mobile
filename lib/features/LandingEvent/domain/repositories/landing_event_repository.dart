import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/event_entities.dart';

abstract class LandingEventRepository {
  Future<Either<Failure, List<EventEntities>>> getEventUpcoming(
    String token,
    int userId,
  );
  Future<Either<Failure, List<EventEntities>>> getEventOngoing(
    String token,
    int userId,
  );
  Future<Either<Failure, List<EventEntities>>> getEventPast(
    String token,
    int userId,
  );
}
