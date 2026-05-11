import 'package:flutter/material.dart';

/// App Colors - Coco Theme Palette
/// Inspired by warm, magical, sunset vibes from Pixar's "Coco"
class AppColors {
  AppColors._();

  // Primary Colors
  static const Color deepPurple = Color(0xFF6C5CE7);
  static const Color warmOrange = Color(0xFFFF9F43);
  static const Color softPink = Color(0xFFFDA7DC);
  static const Color pastelTurquoise = Color(0xFF81ECEC);
  static const Color goldenGlow = Color(0xFFFDCB6E);

  // Gradient Colors
  static const List<Color> sunsetGradient = [
    Color(0xFFFF9F43), // Warm Orange
    Color(0xFFFDA7DC), // Soft Pink
    Color(0xFF6C5CE7), // Deep Purple
  ];

  static const List<Color> magicalGradient = [
    Color(0xFF6C5CE7), // Deep Purple
    Color(0xFF81ECEC), // Pastel Turquoise
  ];

  static const List<Color> goldenGradient = [
    Color(0xFFFDCB6E), // Golden Glow
    Color(0xFFFF9F43), // Warm Orange
  ];

  // Background Colors
  static const Color backgroundLight = Color(0xFFFFFBF5);
  static const Color backgroundDark = Color(0xFF1A1625);
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color cardDark = Color(0xFF2D2438);

  // Text Colors
  static const Color textPrimary = Color(0xFF2D3436);
  static const Color textSecondary = Color(0xFF636E72);
  static const Color textTertiary = Color(0xFFB2BEC3);
  static const Color textWhite = Color(0xFFFFFFFF);

  // Status Colors
  static const Color success = Color(0xFF00B894);
  static const Color warning = Color(0xFFFDCB6E);
  static const Color error = Color(0xFFD63031);
  static const Color info = Color(0xFF74B9FF);

  // Priority Colors
  static const Color priorityHigh = Color(0xFFD63031);
  static const Color priorityMedium = Color(0xFFFF9F43);
  static const Color priorityLow = Color(0xFF00B894);

  // Category Colors
  static const Color categoryWork = Color(0xFF6C5CE7);
  static const Color categoryPersonal = Color(0xFFFDA7DC);
  static const Color categoryHealth = Color(0xFF00B894);
  static const Color categoryStudy = Color(0xFF74B9FF);
  static const Color categoryOther = Color(0xFFB2BEC3);

  // UI Elements
  static const Color divider = Color(0xFFDFE6E9);
  static const Color shadow = Color(0x1A000000);
  static const Color overlay = Color(0x80000000);
  static const Color shimmer = Color(0xFFE0E0E0);

  // Opacity variations for glow effects
  static Color deepPurpleGlow = deepPurple.withOpacity(0.3);
  static Color warmOrangeGlow = warmOrange.withOpacity(0.3);
  static Color goldenGlowSoft = goldenGlow.withOpacity(0.2);
}
