import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../../../core/constant/constant.dart';
import '../../../../core/error/exceptions.dart';

abstract class ChangePasswordRemoteDatasource {
  Future<String> changePassword({
    required String token,
    required int userId,
    required String currentPassword,
    required String newPassword,
    required String newPasswordConfirmation,
  });
}

class ChangePasswordRemoteDataSourceImplementation
    implements ChangePasswordRemoteDatasource {
  final http.Client client;

  ChangePasswordRemoteDataSourceImplementation({required this.client});

  @override
  Future<String> changePassword({
    required String token,
    required int userId,
    required String currentPassword,
    required String newPassword,
    required String newPasswordConfirmation,
  }) async {
    final response = await client.put(
      Uri.parse(Constant.endpoint('/user/$userId/change-password')),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'current_password': currentPassword,
        'new_password': newPassword,
        'new_password_confirmation': newPasswordConfirmation,
      }),
    );

    print('from change-password response: $response');

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = jsonDecode(response.body);

      return body['message'];
    } else if (response.statusCode == 400) {
      final Map<String, dynamic> body = jsonDecode(response.body);

      return body['error'];
    } else {
      final Map<String, dynamic> body = jsonDecode(response.body);

      print('from change-password error: $body');
      return body['error'];
    }
  }
}
