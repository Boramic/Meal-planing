import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF4CAF50); // fresh green
  static const Color secondary = Color(0xFF2E7D32); // deep green
  static const Color accent = Color(0xFFFFC107); // warm accent

  static const LinearGradient splashGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFF43CEA2),
        Color(0xFF185A9D),
      ],
  );
}