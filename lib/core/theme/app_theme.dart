import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:coco/core/constants/app_colors.dart';

/// App Theme Configuration
/// Creates warm and magical theme inspired by Coco
class AppTheme {
  AppTheme._();

  // Light Theme
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.backgroundLight,
    colorScheme: const ColorScheme.light(
      primary: AppColors.deepPurple,
      secondary: AppColors.warmOrange,
      tertiary: AppColors.softPink,
      surface: AppColors.cardLight,
      background: AppColors.backgroundLight,
      error: AppColors.error,
      onPrimary: AppColors.textWhite,
      onSecondary: AppColors.textWhite,
      onSurface: AppColors.textPrimary,
      onBackground: AppColors.textPrimary,
      onError: AppColors.textWhite,
    ),

    // Text Theme
    textTheme: TextTheme(
      // Display styles (large text)
      displayLarge: GoogleFonts.poppins(
        fontSize: 57,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      displayMedium: GoogleFonts.poppins(
        fontSize: 45,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      displaySmall: GoogleFonts.poppins(
        fontSize: 36,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),

      // Headline styles (titles)
      headlineLarge: GoogleFonts.poppins(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      headlineMedium: GoogleFonts.poppins(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      headlineSmall: GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),

      // Title styles
      titleLarge: GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      titleMedium: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      titleSmall: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),

      // Body styles (regular text)
      bodyLarge: GoogleFonts.nunito(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
      ),
      bodyMedium: GoogleFonts.nunito(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
      ),
      bodySmall: GoogleFonts.nunito(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
      ),

      // Label styles (buttons, tabs)
      labelLarge: GoogleFonts.nunito(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      labelMedium: GoogleFonts.nunito(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      labelSmall: GoogleFonts.nunito(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
    ),

    // Card Theme
    cardTheme: CardThemeData(
      color: AppColors.cardLight,
      elevation: 4,
      shadowColor: AppColors.shadow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),

    // AppBar Theme
    appBarTheme: AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      foregroundColor: AppColors.textPrimary,
      titleTextStyle: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      iconTheme: const IconThemeData(color: AppColors.textPrimary, size: 24),
    ),

    // Floating Action Button Theme
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.warmOrange,
      foregroundColor: AppColors.textWhite,
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      extendedTextStyle: GoogleFonts.nunito(
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    ),

    // Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.deepPurple,
        foregroundColor: AppColors.textWhite,
        elevation: 4,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        textStyle: GoogleFonts.nunito(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    // Outlined Button Theme
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.deepPurple,
        side: const BorderSide(color: AppColors.deepPurple, width: 2),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        textStyle: GoogleFonts.nunito(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    // Text Button Theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.deepPurple,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        textStyle: GoogleFonts.nunito(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.cardLight,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.divider),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.divider),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.deepPurple, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.error, width: 2),
      ),
      labelStyle: GoogleFonts.nunito(
        fontSize: 14,
        color: AppColors.textSecondary,
      ),
      hintStyle: GoogleFonts.nunito(
        fontSize: 14,
        color: AppColors.textTertiary,
      ),
      errorStyle: GoogleFonts.nunito(fontSize: 12, color: AppColors.error),
    ),

    // Chip Theme
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.pastelTurquoise.withOpacity(0.2),
      deleteIconColor: AppColors.textPrimary,
      disabledColor: AppColors.textTertiary,
      selectedColor: AppColors.deepPurple,
      secondarySelectedColor: AppColors.warmOrange,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      labelStyle: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w600),
      secondaryLabelStyle: GoogleFonts.nunito(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: AppColors.textWhite,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),

    // Bottom Navigation Bar Theme
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.cardLight,
      selectedItemColor: AppColors.deepPurple,
      unselectedItemColor: AppColors.textTertiary,
      selectedLabelStyle: GoogleFonts.nunito(
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: GoogleFonts.nunito(
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),

    // Tab Bar Theme
    tabBarTheme: TabBarThemeData(
      labelColor: AppColors.deepPurple,
      unselectedLabelColor: AppColors.textTertiary,
      labelStyle: GoogleFonts.nunito(fontSize: 14, fontWeight: FontWeight.w600),
      unselectedLabelStyle: GoogleFonts.nunito(
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      indicator: const UnderlineTabIndicator(
        borderSide: BorderSide(color: AppColors.deepPurple, width: 3),
        insets: EdgeInsets.symmetric(horizontal: 16),
      ),
    ),

    // Divider Theme
    dividerTheme: const DividerThemeData(
      color: AppColors.divider,
      thickness: 1,
      space: 1,
    ),

    // Dialog Theme
    dialogTheme: DialogThemeData(
      backgroundColor: AppColors.cardLight,
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      titleTextStyle: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      contentTextStyle: GoogleFonts.nunito(
        fontSize: 14,
        color: AppColors.textSecondary,
      ),
    ),

    // Snackbar Theme
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.textPrimary,
      contentTextStyle: GoogleFonts.nunito(
        fontSize: 14,
        color: AppColors.textWhite,
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),

    // Progress Indicator Theme
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.deepPurple,
      linearTrackColor: AppColors.divider,
      circularTrackColor: AppColors.divider,
    ),
  );

  // Dark Theme
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.backgroundDark,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.deepPurple,
      secondary: AppColors.warmOrange,
      tertiary: AppColors.softPink,
      surface: AppColors.cardDark,
      background: AppColors.backgroundDark,
      error: AppColors.error,
      onPrimary: AppColors.textWhite,
      onSecondary: AppColors.textWhite,
      onSurface: AppColors.textWhite,
      onBackground: AppColors.textWhite,
      onError: AppColors.textWhite,
    ),

    // Text Theme (Dark)
    textTheme: TextTheme(
      displayLarge: GoogleFonts.poppins(
        fontSize: 57,
        fontWeight: FontWeight.w600,
        color: AppColors.textWhite,
      ),
      displayMedium: GoogleFonts.poppins(
        fontSize: 45,
        fontWeight: FontWeight.w600,
        color: AppColors.textWhite,
      ),
      displaySmall: GoogleFonts.poppins(
        fontSize: 36,
        fontWeight: FontWeight.w600,
        color: AppColors.textWhite,
      ),
      headlineLarge: GoogleFonts.poppins(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        color: AppColors.textWhite,
      ),
      headlineMedium: GoogleFonts.poppins(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: AppColors.textWhite,
      ),
      headlineSmall: GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: AppColors.textWhite,
      ),
      titleLarge: GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: AppColors.textWhite,
      ),
      titleMedium: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.textWhite,
      ),
      titleSmall: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.textWhite,
      ),
      bodyLarge: GoogleFonts.nunito(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.textWhite,
      ),
      bodyMedium: GoogleFonts.nunito(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.textWhite,
      ),
      bodySmall: GoogleFonts.nunito(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.textTertiary,
      ),
      labelLarge: GoogleFonts.nunito(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.textWhite,
      ),
      labelMedium: GoogleFonts.nunito(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: AppColors.textWhite,
      ),
      labelSmall: GoogleFonts.nunito(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: AppColors.textWhite,
      ),
    ),

    // Card Theme (Dark)
    cardTheme: CardThemeData(
      color: AppColors.cardDark,
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),

    // AppBar Theme (Dark)
    appBarTheme: AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      foregroundColor: AppColors.textWhite,
      titleTextStyle: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.textWhite,
      ),
      iconTheme: const IconThemeData(color: AppColors.textWhite, size: 24),
    ),

    // FAB Theme (Dark)
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.warmOrange,
      foregroundColor: AppColors.textWhite,
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),

    // Input Decoration Theme (Dark)
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.cardDark,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: AppColors.divider.withOpacity(0.3)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: AppColors.divider.withOpacity(0.3)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.deepPurple, width: 2),
      ),
      labelStyle: GoogleFonts.nunito(
        fontSize: 14,
        color: AppColors.textTertiary,
      ),
      hintStyle: GoogleFonts.nunito(
        fontSize: 14,
        color: AppColors.textTertiary.withOpacity(0.5),
      ),
    ),

    // Dialog Theme (Dark)
    dialogTheme: DialogThemeData(
      backgroundColor: AppColors.cardDark,
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      titleTextStyle: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.textWhite,
      ),
      contentTextStyle: GoogleFonts.nunito(
        fontSize: 14,
        color: AppColors.textWhite,
      ),
    ),
  );
}
