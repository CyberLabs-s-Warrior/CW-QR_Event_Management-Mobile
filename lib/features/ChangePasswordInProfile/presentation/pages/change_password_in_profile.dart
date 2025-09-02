import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../Authentication/presentation/widgets/back_button.dart';
import '../../../Authentication/presentation/widgets/text_field.dart';
import '../../../Authentication/presentation/widgets/text_field_label.dart';

class ChangePasswordInProfilePage extends StatefulWidget {
  const ChangePasswordInProfilePage({super.key});

  @override
  State<ChangePasswordInProfilePage> createState() =>
      _ChangePasswordInProfilePageState();
}

class _ChangePasswordInProfilePageState
    extends State<ChangePasswordInProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPage,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: AuthenticationCustomBackButton(
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Change Password',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Gap(20),
                    Lottie.asset(
                      'assets/lottie/change_password_nabildzr.json',
                      width: 200,
                    ),
                    Gap(20),
                    AuthenticationCustomTextFieldLabel(
                      text: "Current Password",
                    ),
                    SizedBox(height: 8),
                    AuthenticationCustomTextField(
                      hintText: "Enter your Current Password",
                      prefixIcon: Icons.lock_outline,
                    ),
                    Gap(15),
                    AuthenticationCustomTextFieldLabel(text: "New Password"),
                    SizedBox(height: 8),
                    AuthenticationCustomTextField(
                      hintText: "Enter your New Password",
                      prefixIcon: Icons.lock_outline,
                    ),
                    Gap(15),
                    AuthenticationCustomTextFieldLabel(
                      text: "New Password Confirmation",
                    ),
                    SizedBox(height: 8),
                    AuthenticationCustomTextField(
                      hintText: "Enter your New Password Confirmation",
                      prefixIcon: Icons.lock_outline,
                    ),
                  ],
                ),
              ),
            ),
        
            Align(
              alignment: Alignment.bottomCenter,
              child: Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.only(
                    
                    left: 20.0,
                    right: 20.0,
                    bottom: 20.0
                    
                    ),
                  child: SizedBox(
                    width: double.infinity,
                        
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.white,
                        minimumSize: Size(100, 55),
                      ),
                      onPressed: () {
                        print('changing my passwordr...');
                      },
                      child: const Text(
                        'Change my password',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFCED4FF),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
