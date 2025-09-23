import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/provider/network_status_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../Authentication/presentation/pages/login_page.dart';
import '../../../Authentication/presentation/provider/authentication_provider.dart';
import '../../../Landing/presentation/pages/landing_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void checkToken() async {
    final authProvider = context.read<AuthenticationProvider>();

    await authProvider.getUser();
    await authProvider.getAuthorization();

    final token = authProvider.authorization?.token;

    if (token == null) {
      navigateToLogin();
    } else {
      final isOnline = context.read<NetworkStatusProvider>().isOnline;

      if (isOnline) {
        await authProvider.refreshToken(authProvider.authorization!.token);
      }

      navigateToLanding();
    }
  }

  void navigateToLogin() {
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => LoginPage()));
  }

  void navigateToLanding() {
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => LandingPage()));
  }

  @override
  void initState() {
    super.initState();
    checkToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
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
