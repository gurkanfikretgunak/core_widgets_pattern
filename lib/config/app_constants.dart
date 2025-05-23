import 'package:flutter/material.dart';

/// 🎨 Application constants and configuration values
class AppConstants {
  // 🎨 Color Constants
  static const Color primarySeedColor = Color(0xFF6750A4);
  
  // 🌍 Localization
  static const List<Locale> supportedLocales = [
    Locale('tr', 'TR'),
    Locale('en', 'US'),
  ];
  
  static const Locale defaultLocale = Locale('en', 'US');
  
  // 📱 App Information
  static const String appTitle = 'Core Widgets Pattern';
  
  // 🔢 Spacing and Sizing
  static const double defaultElevation = 2;
  static const double defaultBorderRadius = 12;
  static const double buttonBorderRadius = 8;
  static const EdgeInsets defaultCardMargin = EdgeInsets.all(8);
  static const EdgeInsets buttonPadding = EdgeInsets.symmetric(horizontal: 24, vertical: 12);
}
