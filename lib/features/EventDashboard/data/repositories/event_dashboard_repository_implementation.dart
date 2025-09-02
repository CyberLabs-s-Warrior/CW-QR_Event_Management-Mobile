import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../datasources/event_dashboard_remote_datasource.dart';
import '../../domain/entities/event_entity.dart';
import '../../domain/repositories/event_dashboard_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventDashboardRepositoryImplementation
    implements EventDashboardRepository {
  final SharedPreferences sharedPreferences;
  final EventDashboardRemoteDatasource eventDashboardRemoteDatasource;

  EventDashboardRepositoryImplementation({
    required this.sharedPreferences,
    required this.eventDashboardRemoteDatasource,
  });

  @override
  Future<Either<Failure, EventEntity>> getEventById(token, eventId) async {
    try {
      final List<ConnectivityResult> connectivityResult =
          await (Connectivity().checkConnectivity());

      if (connectivityResult.contains(ConnectivityResult.none)) {
        final result = await eventDashboardRemoteDatasource.getEventById(
          token,
          eventId,
        );

        return Right(result);
      } else {
        final result = await eventDashboardRemoteDatasource.getEventById(
          token,
          eventId,
        );

        return Right(result);
      }
    } catch (e) {
      return Left(SimpleFailure(e.toString()));
    }
  }
}
