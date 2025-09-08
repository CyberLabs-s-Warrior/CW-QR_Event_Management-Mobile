import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../../core/constant/enum_status.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../gen/alert/snack_bar.dart';
import '../../../../gen/loading/dialog_screen.dart';
import '../../../Authentication/presentation/provider/authentication_provider.dart';
import '../../../Authentication/presentation/widgets/back_button.dart';
import '../../../Authentication/presentation/widgets/text_field.dart';
import '../../../Authentication/presentation/widgets/text_field_label.dart';
import '../provider/change_password_provider.dart';

class ChangePasswordInProfilePage extends StatefulWidget {
  const ChangePasswordInProfilePage({super.key});

  @override
  State<ChangePasswordInProfilePage> createState() =>
      _ChangePasswordInProfilePageState();
}

class _ChangePasswordInProfilePageState
    extends State<ChangePasswordInProfilePage> {
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _newPasswordConfirmationController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void _changeMyPassword() async {
    final authProvider = context.read<AuthenticationProvider>();
    final changePasswordProvider = context.read<ChangePasswordProvider>();

    await changePasswordProvider.changePassword(
      token: authProvider.currentUser!.token,
      userId: authProvider.currentUser!.id,
      currentPassword: _currentPasswordController.text,
      newPassword: _newPasswordController.text,
      newPasswordConfirmation: _newPasswordConfirmationController.text,
    );
  }

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
      body: Consumer<ChangePasswordProvider>(
        builder: (context, changePasswordProvider, child) {
          if (changePasswordProvider.changePasswordStatus ==
              ResponseStatus.loading) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showLoadingDialog(context, text: "Changing your password...");
            });
          }

          if (changePasswordProvider.changePasswordStatus ==
              ResponseStatus.error) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showCustomSnackBar(
                context: context,
                message:
                    changePasswordProvider.cleanErrorMessage ??
                    'An error occured',
                color: AppColors.error,
              );
            });
          }

          return SafeArea(
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
                          controller: _currentPasswordController,
                        ),
                        Gap(15),
                        AuthenticationCustomTextFieldLabel(
                          text: "New Password",
                        ),
                        SizedBox(height: 8),
                        AuthenticationCustomTextField(
                          hintText: "Enter your New Password",
                          prefixIcon: Icons.lock_outline,
                          controller: _newPasswordController,
                        ),
                        Gap(15),
                        AuthenticationCustomTextFieldLabel(
                          text: "New Password Confirmation",
                        ),
                        SizedBox(height: 8),
                        AuthenticationCustomTextField(
                          hintText: "Enter your New Password Confirmation",
                          prefixIcon: Icons.lock_outline,
                          controller: _newPasswordConfirmationController,
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
                        bottom: 20.0,
                      ),
                      child: SizedBox(
                        width: double.infinity,

                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: AppColors.white,
                            minimumSize: Size(100, 55),
                          ),
                          onPressed: _changeMyPassword,
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
          );
        },
      ),
    );
  }
}
