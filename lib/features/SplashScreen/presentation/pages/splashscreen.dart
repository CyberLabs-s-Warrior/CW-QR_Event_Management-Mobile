import 'dart:convert';

import 'package:flutter/material.dart';
import '../../../Authentication/presentation/pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Home/presentation/pages/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void checkToken() async {
    dynamic user;
    dynamic token;
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user');

    if (userJson != null && userJson.isNotEmpty) {
       user = jsonDecode(userJson);
       token = user['token'];
    } else {
       user = null;
       token = null;
    }

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
