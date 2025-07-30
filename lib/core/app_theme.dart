import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'color_scheme.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: AppColorScheme.primaryLight,
        secondary: AppColorScheme.secondaryLight,
        tertiary: AppColorScheme.tertiaryLight,
        surface: AppColorScheme.surfaceLight,
        background: AppColorScheme.backgroundLight,
        error: AppColorScheme.errorLight,
      ),
      textTheme: _buildTextTheme(Brightness.light),
      appBarTheme: _buildAppBarTheme(Brightness.light),
      elevatedButtonTheme: _buildElevatedButtonTheme(Brightness.light),
      filledButtonTheme: _buildFilledButtonTheme(Brightness.light),
      cardTheme: _buildCardTheme(Brightness.light),
      bottomSheetTheme: _buildBottomSheetTheme(Brightness.light),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: AppColorScheme.primaryDark,
        secondary: AppColorScheme.secondaryDark,
        tertiary: AppColorScheme.tertiaryDark,
        surface: AppColorScheme.surfaceDark,
        background: AppColorScheme.backgroundDark,
        error: AppColorScheme.errorDark,
      ),
      textTheme: _buildTextTheme(Brightness.dark),
      appBarTheme: _buildAppBarTheme(Brightness.dark),
      elevatedButtonTheme: _buildElevatedButtonTheme(Brightness.dark),
      filledButtonTheme: _buildFilledButtonTheme(Brightness.dark),
      cardTheme: _buildCardTheme(Brightness.dark),
      bottomSheetTheme: _buildBottomSheetTheme(Brightness.dark),
    );
  }

  static TextTheme _buildTextTheme(Brightness brightness) {
    final baseTextTheme = GoogleFonts.interTextTheme();
    final color = brightness == Brightness.light 
        ? AppColorScheme.primaryLight 
        : AppColorScheme.primaryDark;
    
    return baseTextTheme.copyWith(
      headlineLarge: GoogleFonts.rubikWetPaint(
        fontSize: 32,
        fontWeight: FontWeight.w400,
        color: color,
      ),
      headlineMedium: GoogleFonts.rubikWetPaint(
        fontSize: 28,
        fontWeight: FontWeight.w400,
        color: color,
      ),
      titleLarge: GoogleFonts.dancingScript(
        fontSize: 22,
        fontWeight: FontWeight.w400,
        color: color,
      ),
      bodyLarge: baseTextTheme.bodyLarge?.copyWith(
        color: color,
        fontSize: 16,
      ),
      bodyMedium: baseTextTheme.bodyMedium?.copyWith(
        color: color,
        fontSize: 14,
      ),
    );
  }

  static AppBarTheme _buildAppBarTheme(Brightness brightness) {
    return AppBarTheme(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      foregroundColor: brightness == Brightness.light 
          ? AppColorScheme.primaryLight 
          : AppColorScheme.primaryDark,
      titleTextStyle: GoogleFonts.rubikWetPaint(
        fontSize: 28,
        fontWeight: FontWeight.w400,
        color: brightness == Brightness.light 
            ? AppColorScheme.primaryLight 
            : AppColorScheme.primaryDark,
      ),
    );
  }

  static ElevatedButtonThemeData _buildElevatedButtonTheme(Brightness brightness) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 2,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  static FilledButtonThemeData _buildFilledButtonTheme(Brightness brightness) {
    return FilledButtonThemeData(
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  static CardTheme _buildCardTheme(Brightness brightness) {
    return CardTheme(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.all(8),
    );
  }

  static BottomSheetThemeData _buildBottomSheetTheme(Brightness brightness) {
    return const BottomSheetThemeData(
      backgroundColor: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
    );
  }
}