import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_event_management/features/Home/presentation/provider/home_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../Authentication/presentation/provider/authentication_provider.dart';
import '../../../SplashScreen/presentation/pages/splashscreen.dart';

void logout(context) async {
  final authProvider = Provider.of<AuthenticationProvider>(
    context,
    listen: false,
  );

  final homeProvider = Provider.of<HomeProvider>(context, listen: false);

  final shouldLogout = await showDialog<bool>(
    context: context,
    builder:
        (context) => AlertDialog(
          title: Text('Logout', style: TextStyle(fontWeight: FontWeight.bold)),
          content: Text('Are you sure want to logout?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text('Cancel', style: TextStyle(color: AppColors.grey2)),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text("Logout", style: TextStyle(color: AppColors.primary)),
            ),
          ],
        ),
  );

  if (shouldLogout == true) {
    await authProvider.logout();

    authProvider.resetState();
    homeProvider.resetState();
    homeProvider.stopAutoRefresh();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => SplashScreen()),
      (route) => false,
    );

  }
}
