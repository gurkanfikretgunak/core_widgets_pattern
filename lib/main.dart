import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app.dart';

/// 🚀 Application entry point
/// 
/// This file handles the application's initial configurations:
/// - System UI settings
/// - Error handling
/// - Launch main application widget
void main() async {
  // 🔧 Wait for Flutter framework initialization
  WidgetsFlutterBinding.ensureInitialized();
  
  // 📱 System UI configuration
  await _configureSystemUI();
  
  // 🚫 Global error handling
  _setupErrorHandling();
  
  // 🎯 Launch application
  runApp(const CoreWidgetsApp());
}

/// 📱 Configure system UI settings
/// 
/// Status bar, navigation bar and orientation settings
Future<void> _configureSystemUI() async {
  // 🎨 Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      // Status Bar Settings
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
      
      // Navigation Bar Settings
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarDividerColor: Colors.transparent,
    ),
  );
  
  // 📐 Supported orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  
  // 🖼️ Edge-to-edge content
  await SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
  );
}

/// 🚫 Global error handling system
/// 
/// To prevent app crashes and log errors
void _setupErrorHandling() {
  // Flutter framework errors
  FlutterError.onError = (FlutterErrorDetails details) {
    // 📝 Error logging (sent to crash analytics in production)
    debugPrint('🚫 Flutter Error: ${details.exception}');
    debugPrint('📍 Stack Trace: ${details.stack}');
    
    // 🔧 Show error details in development mode
    if (kDebugMode) {
      FlutterError.presentError(details);
    }
  };
  
  // Platform errors (native crashes, async errors)
  PlatformDispatcher.instance.onError = (error, stack) {
    debugPrint('🚫 Platform Error: $error');
    debugPrint('📍 Stack Trace: $stack');
    return true;
  };
}

/// 🛠️ Check debug mode
bool get kDebugMode {
  bool inDebugMode = false;
  assert(inDebugMode = true);
  return inDebugMode;
}
