import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/constant/constant.dart';
import '../../../../core/error/exceptions.dart';
import '../models/event_model.dart';

abstract class EventDashboardRemoteDatasource {
  Future<EventModel> getEventById(token, eventId);
}

class EventDashboardRemoteDatasourceImplementation
    implements EventDashboardRemoteDatasource {
  final http.Client client;

  EventDashboardRemoteDatasourceImplementation({required this.client});

  @override
  Future<EventModel> getEventById(token, eventId) async {
    final response = await client.get(
      Uri.parse(Constant.endpoint('/event/$eventId')),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    // print('from event dashboard response: ${jsonEncode(response)}');

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);

      print('from event dashboard body: $data');

      return EventModel.fromJson(data);
    } else if (response.statusCode == 404) {
      throw GeneralException(message: 'Event not found');
    } else {
      Map<String, dynamic> e = jsonDecode(response.body);
      print('from event dashboard error: $e');
      throw GeneralException(message: 'Something Error');
    }
  }
}
