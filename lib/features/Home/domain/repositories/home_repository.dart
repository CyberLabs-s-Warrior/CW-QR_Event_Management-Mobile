import 'package:dartz/dartz.dart';
import 'package:qr_event_management/core/error/failure.dart';
import 'package:qr_event_management/features/Home/domain/entities/HomeEventHistoryEntity.dart';
import 'package:qr_event_management/features/Home/domain/entities/HomeSummaryEntity.dart';

abstract class HomeRepository {
  Future<Either<Failure, HomeSummaryEntity>> getHomeSummary(String token, int userId);
  Future<Either<Failure, HomeEventHistoryEntity>> getHomeEventHistory(String token, int userId);
}