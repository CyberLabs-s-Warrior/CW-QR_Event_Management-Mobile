import 'package:qr_event_management/features/Home/data/models/HomeSummaryModel.dart';

abstract class HomeRemoteDatasource {
  Future<HomeSummaryModel> getHomeSummary(String token, int userId);
}