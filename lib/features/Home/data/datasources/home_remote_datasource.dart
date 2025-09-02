import '../models/HomeEventHistoryModel.dart';
import '../models/HomeSummaryModel.dart';

abstract class HomeRemoteDatasource {
  Future<HomeSummaryModel> getHomeSummary(String token, int userId);
  Future<List<HomeEventHistoryModel>> getHomeEventHistory(String token, int userId);
}