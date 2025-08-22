import 'package:dartz/dartz.dart';
import 'package:qr_event_management/core/error/failure.dart';
import 'package:qr_event_management/features/Home/domain/entities/HomeSummaryEntity.dart';
import 'package:qr_event_management/features/Home/domain/repositories/home_repository.dart';

class HomeSummaryUsecase {
  final HomeRepository homeRepository;

  HomeSummaryUsecase(this.homeRepository);

  Future<Either<Failure, HomeSummaryEntity>> execute(
    String token,
    int userId,
  ) async {
    return homeRepository.getHomeSummary(token, userId);
  }
}
