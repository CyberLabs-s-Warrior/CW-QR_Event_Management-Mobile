import 'package:dartz/dartz.dart';
import 'package:qr_event_management/core/error/failure.dart';
import 'package:qr_event_management/features/Home/domain/entities/HomeEventHistoryEntity.dart';
import 'package:qr_event_management/features/Home/domain/repositories/home_repository.dart';

class HomeEventHistoryUsecase {
  final HomeRepository homeRepository;

  HomeEventHistoryUsecase({required this.homeRepository});


  Future<Either<Failure, HomeEventHistoryEntity>> execute(String token, int userId) {
    return homeRepository.getHomeEventHistory(token, userId);
  } 
}