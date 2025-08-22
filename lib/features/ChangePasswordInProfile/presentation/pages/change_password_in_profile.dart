import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:qr_event_management/core/theme/app_colors.dart';
import 'package:qr_event_management/features/Authentication/presentation/widgets/back_button.dart';
import 'package:qr_event_management/features/Authentication/presentation/widgets/text_field.dart';
import 'package:qr_event_management/features/Authentication/presentation/widgets/text_field_label.dart';

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
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Gap(20),
              Center(
                child: Column(
                  children: [
                    Text(
                      'Change Password',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Gap(5),
                    Text(
                      'Confirm your password & New \nPassword',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              Gap(15),
              AuthenticationCustomTextFieldLabel(text: "Current Password"),
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
              AuthenticationCustomTextFieldLabel(text: "New Password Confirmation"),
              SizedBox(height: 8),
              AuthenticationCustomTextField(
                hintText: "Enter your New Password Confirmation",
                prefixIcon: Icons.lock_outline,
              ),


              
              Spacer(),
              SizedBox(
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
            ],
          ),
        ),
      ),
    );
  }
}
