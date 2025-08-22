import 'dart:convert';

import 'package:qr_event_management/core/error/exceptions.dart';
import 'package:qr_event_management/features/Home/data/models/HomeSummaryModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class HomeLocalDatasource {
  Future<HomeSummaryModel> getHomeSummary();
}

class HomeLocalDatasourceImplementation extends HomeLocalDatasource {
  final SharedPreferences sharedPreferences;

  HomeLocalDatasourceImplementation({required this.sharedPreferences});

  @override
  Future<HomeSummaryModel> getHomeSummary() async {
    final jsonString = sharedPreferences.getString('home_summary');
    if (jsonString == null) throw GeneralException(message: "Home Summary not found");
    return HomeSummaryModel.fromJson(json.decode(jsonString));
  }
}
