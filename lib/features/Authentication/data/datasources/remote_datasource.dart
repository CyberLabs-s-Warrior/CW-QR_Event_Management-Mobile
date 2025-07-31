import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/constant/constant.dart';
import '../../../../core/error/exceptions.dart';
import '../models/forgot_password_model.dart';
import '../models/user_model.dart';
import '../models/verify_code_model.dart';

abstract class AuthenticationRemoteDataSource {
  Future<UserModel> signIn(String email, String password);
  Future<ForgotPasswordModel> forgotPassword(
    bool isWithEmail,
    String? phoneNumber,
    String? email,
  );
  Future<VerifyCodeModel> verifyCode(
    bool isWithEmail,
    String? phoneNumber,
    String? email,
    String otp,
  );

  void logout(String token);
}

class AuthenticationRemoteDataSourceImplementation
    extends AuthenticationRemoteDataSource {
  final http.Client client;

  AuthenticationRemoteDataSourceImplementation({required this.client});

  @override
  Future<UserModel> signIn(email, password) async {
    final response = await client.post(
      Uri.parse("${Constant.api}/user/sign-in"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"email": email, "password": password}),
    );

    print(response.toString());

    if (response.statusCode == 200) {
      Map<String, dynamic> dataBody = jsonDecode(response.body);

      List<dynamic> dataArray = dataBody['data'];

      // Map<String, dynamic> data = dataBody['data'][0] ?? {};

      Map<String, dynamic> userData = dataArray[0];

      String token = dataBody['token'];
      String expiresAt = dataBody['expires_at'];

      print("Original user data: $userData");
      print("Token: $token");
      print("Expires At: $expiresAt");

      userData['token'] = token;
      userData['expires_at'] = expiresAt;

      print(
        'Complete user data with token (Add token and expires_at into userData object), result: $userData',
      );

      return UserModel.fromJson(userData);
    } else if (response.statusCode == 404 || response.statusCode == 401) {
      Map<String, dynamic> data = jsonDecode(response.body);
      print(data);

      throw EmptyException(message: data['message']);
    } else {
      print("error");

      throw GeneralException(message: "Cannot get data");
    }
  }

  Future<ForgotPasswordModel> forgotPassword(
    bool isWithEmail,
    String? phoneNumber,
    String? email,
  ) async {
    final response = await client.post(
      Uri.parse("${Constant.api}/user/send-code"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "isWithEmail": isWithEmail,
        if (isWithEmail) "email": email else "phone_number": phoneNumber,
      }),
    );

    print("request: em: $email, ph: $phoneNumber, isWE: $isWithEmail");

    print(response);

    if (response.statusCode == 200) {
      Map<String, dynamic> dataBody = jsonDecode(response.body);

      print("result: $dataBody");

      return ForgotPasswordModel.fromJson(dataBody);
    } else if (response.statusCode == 404 || response.statusCode == 400) {
      Map<String, dynamic> dataBody = jsonDecode(response.body);

      throw EmptyException(message: dataBody['message']);
    } else {
      throw GeneralException(message: 'Cannot get data');
    }
  }

  Future<VerifyCodeModel> verifyCode(
    bool isWithEmail,
    String? phoneNumber,
    String? email,
    String otp,
  ) async {
    final response = await client.post(
      Uri.parse("${Constant.api}/user/verify-code"),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> dataBody = jsonDecode(response.body);

      return VerifyCodeModel(message: dataBody['message']);
    } else if (response.statusCode == 400) {
      throw EmptyException(message: "Failed to send code");
    } else {
      throw GeneralException(message: "Cannot get data");
    }
  }

  void logout(String token) async {
    try {
      await client.post(
        Uri.parse("${Constant.api}/user/logout"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
    } catch (e) {
      throw GeneralException(message: "Cannot get data");
    }
  }
}
