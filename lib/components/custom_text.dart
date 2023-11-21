import 'package:book_shelf/theme.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final controller;
  final String hindText;
  final bool obscureText;

  const CustomText({super.key, this.controller, required this.hindText, required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: CustomTheme.color5),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: CustomTheme.color2),
          ),
          fillColor: CustomTheme.color6,
          filled: true,
          hintText: hindText,
        ),
      ),
    );
  }
}
