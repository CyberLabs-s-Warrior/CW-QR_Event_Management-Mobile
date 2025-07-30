import 'dart:convert';

import '../../../../core/constant/constant.dart';
import '../../../../core/error/exceptions.dart';
import '../models/forgot_password_model.dart';
import '../models/verify_code_model.dart';
import '../../domain/usecases/forgot_password.dart';

import '../models/user_model.dart';
import 'package:http/http.dart' as http;

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

class AuthenticationRemoteDataSourceImplementation {
  final http.Client client;

  AuthenticationRemoteDataSourceImplementation({required this.client});

  Future<UserModel> signIn(email, password) async {
    final response = await client.post(
      Uri.parse("${Constant.api}/user/signin"),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> dataBody = jsonDecode(response.body);
      Map<String, dynamic> data = dataBody['data'] ?? [];

      return UserModel.fromJson(data);
    } else if (response.statusCode == 404) {
      Map<String, dynamic> data = jsonDecode(response.body);

      throw EmptyException(message: data['message']);
    } else {
      throw GeneralException(message: "Cannot get data");
    }
  }

  Future<ForgotPasswordModel> forgotPassword(
    bool isWithEmail,
    String? phoneNumber,
    String? email,
  ) async {
    final response = await client.post(
      Uri.parse("${Constant.api}/send-code"),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> dataBody = jsonDecode(response.body);

      return ForgotPasswordModel.fromJson(dataBody);
    } else if (response.statusCode == 404) {
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
      Uri.parse("${Constant.api}/verify-code"),
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
