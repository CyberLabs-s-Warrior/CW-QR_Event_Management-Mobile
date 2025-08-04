import 'package:flutter/material.dart';

class AuthenticationCustomTextFieldLabel extends StatelessWidget {
  final String text;

  const AuthenticationCustomTextFieldLabel({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Align(alignment: Alignment.centerLeft, child: Text(text));
  }
}
