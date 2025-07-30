import 'package:custom_numeric_pad/custom_numpad_package.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:pinput/pinput.dart';

import '../widgets/back_button.dart';
import 'recovery_password_page.dart';

class VerifyCodePage extends StatefulWidget {
  final bool isEmail;
  final String emailOrPhoneNumber;

  const VerifyCodePage({
    super.key,
    required this.isEmail,
    required this.emailOrPhoneNumber,
  });

  @override
  State<VerifyCodePage> createState() => _VerifyCodePageState();
}

class _VerifyCodePageState extends State<VerifyCodePage> {
  String verificationCode = '';
  final int codeLength = 4;
  final TextEditingController _pinController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    print("passing data dari page sebelumnya: ${widget.emailOrPhoneNumber}");

    _focusNode.canRequestFocus = false;

    // validasi, listener memastikan biar ga lebih dari 4
    _pinController.addListener(() {
      // Remove invalid characters: ./'][] and others you want to restrict
      final invalidChars = RegExp(r"[./'\]\[]");
      String filtered = _pinController.text.replaceAll(invalidChars, '');

      // Limit to codeLength
      if (filtered.length > codeLength) {
        filtered = filtered.substring(0, codeLength);
      }

      if (_pinController.text != filtered) {
        _pinController.text = filtered;
        _pinController.selection = TextSelection.fromPosition(
          TextPosition(offset: _pinController.text.length),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Define pinput theme
    final defaultPinTheme = PinTheme(
      width: 75,
      height: 85,
      textStyle: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300, width: 2),
        color: Colors.grey.shade50,
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color(0xFF3F7CFF), width: 2),
      // ignore: deprecated_member_use
      color: const Color(0xFF3F7CFF).withOpacity(0.1),
    );

    final submittedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color(0xFF3F7CFF), width: 2),
      // ignore: deprecated_member_use
      color: const Color(0xFF3F7CFF).withOpacity(0.1),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: AuthenticationCustomBackButton(
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 50),

                  // Header
                  const Text(
                    'Verify Code',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),

                  Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Please enter the verification code\nsent to ',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        TextSpan(
                          text:
                              widget.isEmail
                                  ? widget.emailOrPhoneNumber
                                  : '+62 ${widget.emailOrPhoneNumber.substring(3, 6)}-${widget.emailOrPhoneNumber.substring(6, 10)}-${widget.emailOrPhoneNumber.substring(10)}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(
                              255,
                              146,
                              181,
                              255,
                            ), // Blue color
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),

                  // Code Display
                  Center(
                    child: Pinput(
                      controller: _pinController,
                      focusNode: _focusNode,
                      length: codeLength,
                      defaultPinTheme: defaultPinTheme,
                      focusedPinTheme: focusedPinTheme,
                      submittedPinTheme: submittedPinTheme,
                      showCursor: false,
                      readOnly: true,
                      // validator: (value) {
                      //   print('Validator called with value: $value');
                      // },
                      onChanged: (value) {
                        setState(() {
                          verificationCode = value;
                        });
                      },
                      onCompleted: (pin) {
                        // Auto verify when completed
                        print('Completed: $pin');
                        _verifyCode();
                      },
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Resend Code
                  Text.rich(
                    TextSpan(
                      text: "If you didn't receive a code? ",
                      style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                      children: [
                        TextSpan(
                          text: 'Resend',
                          style: const TextStyle(
                            color: Color(0xFF3F7CFF),
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                          recognizer:
                              TapGestureRecognizer()..onTap = _resendCode,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),

                  // Custom Numeric Pad dengan styling yang lebih baik
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.45,

              decoration: BoxDecoration(color: const Color(0xFF3F7CFF)),
              child: CustomNumPad(
                controller: _pinController,
                buttonHeight: 80,
                buttonWidth: 80,
                rowSpacing: 15,
                columnSpacing: 50,
                cornerRadius: 10,
                bgColor: Colors.transparent,

                buttonColor: Colors.transparent,
                buttonBorderColor: Colors.transparent,
                buttonTextStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _verifyCode() {
    if (verificationCode.length == codeLength) {
      // Show loading dialog
      showDialog(
        context: context,
        barrierDismissible: false, // Prevents dismissing by tapping outside
        builder:
            (context) => Dialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Color(0xFF3F7CFF),
                      ),
                    ),
                    SizedBox(width: 20),
                    Text(
                      'Verifying...',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
      );

      // Simulate verification delay
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.of(context, rootNavigator: true).pop(); // Close the dialog

        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text('Verification code: $verificationCode'),
        //     backgroundColor: const Color(0xFF3F7CFF),
        //     behavior: SnackBarBehavior.floating,
        //     shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(10),
        //     ),
        //   ),
        // );

        if (verificationCode != '2666') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              dismissDirection: DismissDirection.up,
              content: Row(
                children: [
                  Iconify(Ic.round_warning, color: Colors.white),
                  SizedBox(width: 10),

                  Text("Wrong Verification Code", textAlign: TextAlign.start),
                ],
              ),
              backgroundColor: Colors.red,
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height - 100,
                left: 10,
                right: 10,
              ),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
          return;
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            dismissDirection: DismissDirection.up,
            content: const Text('Verified!'),
            backgroundColor: Color(0xFF3F7CFF),
            margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height - 100,
              left: 10,
              right: 10,
            ),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => RecoveryPasswordPage()),
        );

        // TODO: Navigate to success page or call verification API
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
      });
    }
  }

  void _resendCode() {
    print('Resend!');
  }

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }
}
