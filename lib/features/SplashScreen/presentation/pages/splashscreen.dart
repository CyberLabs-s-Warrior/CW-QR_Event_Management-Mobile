import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Authentication/domain/entities/user.dart';
import '../../../Authentication/presentation/pages/login_page.dart';
import '../../../Authentication/presentation/provider/authentication_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Home/presentation/pages/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void checkToken() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user');
    final user = userJson != null ? (jsonDecode(userJson)) : null;
    final token = user['token'];

    print("token: $token");
    print("user: $user");

    if (token == null || user == null) {
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => LoginPage()));
    } else {
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => HomePage()));
    }
  }

  // force clear untuk esting
  Future<void> deleteToken() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.clear();
    await prefs.remove('user');

    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => LoginPage()));
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      checkToken();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/logo/cyberlabs.png',
          width: 150,
          height: 150,
        ),
      ),
    );
  }
}
