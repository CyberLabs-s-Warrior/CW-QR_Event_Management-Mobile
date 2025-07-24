import 'package:flutter/material.dart';

class AuthenticationCustomTextField extends StatelessWidget {
  final bool obscureText;
  final String hintText;
  final IconData prefixIcon;
  final IconData? suffixIcon;
  final TextEditingController? controller;
  final VoidCallback? onSuffixIconTap;

  const AuthenticationCustomTextField({
    super.key,
    this.obscureText = false,
    required this.hintText,
    required this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.onSuffixIconTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,

      decoration: InputDecoration(
        hintText: hintText,

        prefixIcon: Icon(prefixIcon),

        suffixIcon:
            suffixIcon != null
                ? (onSuffixIconTap != null
                    ? GestureDetector(
                      onTap: onSuffixIconTap,
                      child: Icon(suffixIcon),
                    )
                    : Icon(suffixIcon))
                : null,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
    );
  }
}
