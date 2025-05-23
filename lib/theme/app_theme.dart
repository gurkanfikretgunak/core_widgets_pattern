import 'package:flutter/material.dart';
import '../config/app_constants.dart';
import 'app_text_theme.dart';

/// 🎨 Application theme management
class AppTheme {
  /// 🌞 Light theme configuration - Material 3 Design System
  static ThemeData buildLightTheme() {
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: AppConstants.primarySeedColor,
      brightness: Brightness.light,
    );

    return ThemeData(
      // 🎨 Basic Theme Settings
      useMaterial3: true,
      colorScheme: colorScheme,
      
      // 🔤 Typography - Material 3 Text Styles
      textTheme: AppTextTheme.buildTextTheme(colorScheme),
      
      // 📱 AppBar Theme
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 1,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        titleTextStyle: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w500,
          color: colorScheme.onSurface,
        ),
      ),
      
      // 🎯 Card Theme
      cardTheme: CardTheme(
        elevation: AppConstants.defaultElevation,
        margin: AppConstants.defaultCardMargin,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
        ),
      ),
      
      // 🔘 Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: AppConstants.defaultElevation,
          padding: AppConstants.buttonPadding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.buttonBorderRadius),
          ),
        ),
      ),
    );
  }

  /// 🌙 Dark theme configuration
  static ThemeData buildDarkTheme() {
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: AppConstants.primarySeedColor,
      brightness: Brightness.dark,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: AppTextTheme.buildTextTheme(colorScheme),
      
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 1,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
      ),
    );
  }
}
