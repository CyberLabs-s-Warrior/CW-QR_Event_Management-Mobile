import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:qr_event_management/core/error/failure.dart';
import 'package:qr_event_management/features/Home/data/datasources/home_local_datasource.dart';
import 'package:qr_event_management/features/Home/data/datasources/home_remote_datasource.dart';
import 'package:qr_event_management/features/Home/data/models/HomeSummaryModel.dart';
import 'package:qr_event_management/features/Home/domain/entities/HomeEventHistoryEntity.dart';
import 'package:qr_event_management/features/Home/domain/entities/HomeSummaryEntity.dart';
import 'package:qr_event_management/features/Home/domain/repositories/home_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeRepositoryImplementation extends HomeRepository {
  final HomeRemoteDatasource homeRemoteDatasource;
  final HomeLocalDatasource homeLocalDatasource;
  final SharedPreferences sharedPreferences;

  HomeRepositoryImplementation({
    required this.homeRemoteDatasource,
    required this.homeLocalDatasource,
    required this.sharedPreferences,
  });

  @override
  Future<Either<Failure, HomeSummaryEntity>> getHomeSummary(String token, int userId) async {
    try {
      final List<ConnectivityResult> connectivityResult =
          await (Connectivity().checkConnectivity());

      if (connectivityResult.contains(ConnectivityResult.none)) {
        HomeSummaryModel result = await homeLocalDatasource.getHomeSummary();

        print('no connection: $result');

        return Right(result);
      } else {
        HomeSummaryModel result = await homeRemoteDatasource.getHomeSummary(token, userId);

        print(result);

        sharedPreferences.setString('home_summary', jsonEncode(result));

        return Right(result);
      }
    } catch (e) {
      return Left(SimpleFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, HomeEventHistoryEntity>> getHomeEventHistory(String token, int userId) {
    try {

    } catch (e) {
      
    }
  }
}
