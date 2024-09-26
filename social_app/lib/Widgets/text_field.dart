import 'package:flutter/material.dart';
import 'package:social_app/Constants/AppColors.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final bool isEnabled;

  const MyTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText,
      required this.isEnabled});

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          fillColor: AppColors.lightPrimary,
          filled: true,
          hintStyle: const TextStyle(color: AppColors.greyColor),
        ),
        obscureText: obscureText,
        enabled: isEnabled);
  }
}
