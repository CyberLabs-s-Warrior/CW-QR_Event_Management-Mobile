import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/provider/network_status_provider.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../Authentication/presentation/pages/login_page.dart';
import '../../../Authentication/presentation/provider/authentication_provider.dart';
import '../../../Landing/presentation/func/logout.dart';
import '../../../Landing/presentation/func/refresh_token.dart';
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

    final token = authProvider.authorization?.token;

    if (token == null) {
      logoutEasy(context);

      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => LoginPage()));
    } else {
      refreshToken(context);

      final isOnline = context.select<NetworkStatusProvider, bool>(
        (p) => p.isOnline,
      );

      if (isOnline) {
        await authProvider.getUserFromApi(
          token: authProvider.authorization!.token,
        );
      }

      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => LandingPage()));
    }
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
