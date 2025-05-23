import 'package:flutter/material.dart';
import 'config/app_router.dart';
import 'config/app_constants.dart';
import 'theme/app_theme.dart';

/// 🎨 Main application class - Material 3 theme and routing configurations
class CoreWidgetsApp extends StatelessWidget {
  const CoreWidgetsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      // 📱 Application Basic Information
      title: AppConstants.appTitle,
      debugShowCheckedModeBanner: false,
      
      // 🎨 Material 3 Theme Configuration
      theme: AppTheme.buildLightTheme(),
      darkTheme: AppTheme.buildDarkTheme(),
      themeMode: ThemeMode.system,
      
      // 🛣️ Router Configuration
      routerConfig: AppRouter.router,
      
      // 🌍 Localization Settings
      locale: AppConstants.defaultLocale,
      supportedLocales: AppConstants.supportedLocales,
    );
  }
}
