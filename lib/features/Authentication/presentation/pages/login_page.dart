import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:qr_event_management/features/Authentication/presentation/pages/recovery_password_page.dart';
import 'package:qr_event_management/features/Authentication/presentation/pages/verify_code_page.dart';

import '../widgets/text_field.dart';
import '../widgets/text_field_label.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  bool _isPasswordVisible = true;
  bool _isForgotPasswordWithEmail = true;
  late TabController _tabController;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _forgotPasswordWithPhoneNumberController =
      TextEditingController();
  final TextEditingController _forgotPasswordWithEmailController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    
  }

  @override
  void dispose() {
    _tabController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _forgotPasswordWithPhoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.50,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [Color(0xFF3F7CFF), Color.fromARGB(255, 180, 206, 255)],
              ),
            ),
          ),

          // title
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 75, horizontal: 40),
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                child: Text(
                  _tabController.index == 0
                      ? 'Kindly Sign in to\ncontinue.'
                      : "Recover Your\nAccount.",
                  key: ValueKey(_tabController.index),
                  style: const TextStyle(
                    fontSize: 35,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,

            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.55,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28),
                  topRight: Radius.circular(28),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildTabBar(),

                    SizedBox(height: 20),

                    Expanded(
                      child:
                          _tabController.index == 0
                              ? _buildSignInTab()
                              : _buildForgotPasswordTab(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignInTab() {
    return Column(
      children: [
        AuthenticationCustomTextFieldLabel(text: "Email"),
        SizedBox(height: 8),
        AuthenticationCustomTextField(
          controller: _emailController,
          hintText: "Enter your Email",
          prefixIcon: Icons.email_outlined,
        ),

        SizedBox(height: 10),

        AuthenticationCustomTextFieldLabel(text: "Password"),
        SizedBox(height: 8),
        AuthenticationCustomTextField(
          hintText: "Enter your Password",
          prefixIcon: Icons.lock_outline,
          obscureText: _isPasswordVisible,
          onSuffixIconTap: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
          suffixIcon:
              _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
        ),

        SizedBox(height: 15),
        SizedBox(
          width: double.infinity,

          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF3F7CFF),
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            onPressed: () {},
            child: const Text(
              "Login",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),

        SizedBox(height: 15),

        Text.rich(
          TextSpan(
            text: 'By Using Gamma you agree to our\n',
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),

            children: [
              TextSpan(
                text: 'Terms and Data Policy.',
                style: TextStyle(color: Colors.blue),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildForgotPasswordTab() {
    return Column(
      children: [
        _isForgotPasswordWithEmail
            ? AuthenticationCustomTextFieldLabel(text: "Email")
            : AuthenticationCustomTextFieldLabel(text: "Phone Number"),
        SizedBox(height: 8),
        _isForgotPasswordWithEmail
            ? AuthenticationCustomTextField(
              controller: _forgotPasswordWithEmailController,
              hintText: "Enter your Email",
              prefixIcon: Icons.email_outlined,
            )
            : AuthenticationCustomTextField(
              controller: _forgotPasswordWithPhoneNumberController,
              hintText: "Enter your Phone Number",
              prefixIcon: Icons.phone_outlined,
            ),

        SizedBox(height: 15),
        SizedBox(
          width: double.infinity,

          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF3F7CFF),
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (_) => VerifyCodePage(
                        isEmail: _isForgotPasswordWithEmail,
                        emailOrPhoneNumber:
                            _isForgotPasswordWithEmail
                                ? _forgotPasswordWithEmailController.text
                                : _forgotPasswordWithPhoneNumberController.text,
                      ),
                ),
              );
            },
            child: const Text(
              "Send Reset Link",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),

        SizedBox(height: 15),

        Text.rich(
          TextSpan(
            text:
                'Not receiving ${_isForgotPasswordWithEmail ? "emails" : "sms verification"}?\n',
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
            children: [
              TextSpan(
                text:
                    'Try using your ${_isForgotPasswordWithEmail ? "Phone Number" : "Email"}',
                style: TextStyle(color: Colors.blue),
                recognizer:
                    TapGestureRecognizer()
                      ..onTap = () async {
                        _isForgotPasswordWithEmail
                            ? print(
                              'Forgot Password Method Changed!, Currently with Email  : $_isForgotPasswordWithEmail',
                            )
                            : print(
                              'Forgot Password Method Changed!, Currently with Phone Number : $_isForgotPasswordWithEmail',
                            );

                        await Future.delayed(Duration(milliseconds: 300));
                        setState(() {
                          _isForgotPasswordWithEmail =
                              !_isForgotPasswordWithEmail;
                        });
                      },
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildTabBar() {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFDDE9FF),
        borderRadius: BorderRadius.circular(25),
      ),
      child: TabBar(
        controller: _tabController,
        padding: EdgeInsets.all(4),
        indicator: BoxDecoration(
          color: Color(0xFF3F7CFF),
          borderRadius: BorderRadius.circular(25),
        ),
        labelStyle: TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        unselectedLabelColor: Color(0xFF3F7CFF),
        labelColor: Colors.white,
        onTap: (value) {
          setState(() {});
        },
        tabs: [
          Tab(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Text('Sign In'),
            ),
          ),
          Tab(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Text('Forgot Password'),
            ),
          ),
        ],
      ),
    );
  }
}
