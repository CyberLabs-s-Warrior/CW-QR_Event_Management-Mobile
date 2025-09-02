import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:qr_event_management/core/constant/constant.dart';
import 'package:qr_event_management/core/error/exceptions.dart';

abstract class ChangePasswordRemoteDatasource {
  Future<String> changePassword({required String token, required int userId});
}

class ChangePasswordRemoteDataSourceImplementation
    implements ChangePasswordRemoteDatasource {
  final http.Client client;

  ChangePasswordRemoteDataSourceImplementation({required this.client});

  @override
  Future<String> changePassword({
    required String token,
    required int userId,
  }) async {
    final response = await client.put(
      Uri.parse(Constant.endpoint('/user/$userId/change-password')),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    print('from change-password response: $response');

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = jsonDecode(response.body);

      return body['message'];
    } else if (response.statusCode == 400) {
      final Map<String, dynamic> body = jsonDecode(response.body);

      throw GeneralException(message: body['error']);
    } else {
      final Map<String, dynamic> body = jsonDecode(response.body);

      print('from change-password error: $body');
      throw ServerException(message: 'Something Error');
    }
  }
}
