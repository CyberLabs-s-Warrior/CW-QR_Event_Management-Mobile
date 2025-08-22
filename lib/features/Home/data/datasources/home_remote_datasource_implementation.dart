import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:qr_event_management/core/constant/constant.dart';
import 'package:qr_event_management/core/error/exceptions.dart';
import 'package:qr_event_management/features/Home/data/datasources/home_remote_datasource.dart';
import 'package:qr_event_management/features/Home/data/models/HomeSummaryModel.dart';

class HomeRemoteDatasourceImplementation extends HomeRemoteDatasource {
  final http.Client client;

  HomeRemoteDatasourceImplementation({
    required this.client,
  });

  @override
  Future<HomeSummaryModel> getHomeSummary(String token, int userId) async {
    try {

      print('user_id: $userId');

      final result = await client.get(
        Uri.parse(Constant.endpoint("/user/$userId/events-summary")),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      Map<String, dynamic> data = jsonDecode(result.body);

      print('result body: $data');
      return HomeSummaryModel.fromJson(data);
    } catch (e) {
      print('result error: $e');
      throw GeneralException(message: "Cannot get data");
    }
  }
}
