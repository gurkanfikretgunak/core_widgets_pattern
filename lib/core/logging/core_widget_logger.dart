import 'package:flutter/foundation.dart';

/// 🔧 Enhanced logging utility for debugging and monitoring
/// 
/// This utility provides comprehensive logging capabilities for CoreWidget
/// ecosystem with performance monitoring and debug information.
/// 
/// **Usage Example:**
/// ```dart
/// // Enable debug logging
/// CoreWidgetLogger.setDebugMode(true);
/// 
/// // Log debug information
/// CoreWidgetLogger.debug('Widget initialized', data);
/// 
/// // Log lifecycle events
/// CoreWidgetLogger.lifecycle('MyWidget', 'build', {'state': 'loading'});
/// 
/// // Log performance metrics
/// CoreWidgetLogger.performance('database_query', Duration(milliseconds: 150));
/// ```
class CoreWidgetLogger {
  static const String _tag = '[CoreWidget]';
  static bool _debugMode = kDebugMode;
  
  /// 🟢 Enable or disable debug logging
  /// 
  /// Set to `true` to enable detailed logging, `false` to disable.
  /// Automatically disabled in release builds for performance.
  static void setDebugMode(bool enabled) => _debugMode = enabled;
  
  /// 📝 Log debug information with optional error and stack trace
  /// 
  /// **Parameters:**
  /// - [message]: Debug message to log
  /// - [error]: Optional error object to include
  /// - [stackTrace]: Optional stack trace for debugging
  static void debug(String message, [Object? error, StackTrace? stackTrace]) {
    if (_debugMode) {
      debugPrint('$_tag DEBUG: $message');
      if (error != null) debugPrint('$_tag ERROR: $error');
      if (stackTrace != null) debugPrint('$_tag STACK: $stackTrace');
    }
  }
  
  /// 🔄 Log widget lifecycle events with optional data
  /// 
  /// Tracks important widget lifecycle events like build, dispose, etc.
  /// 
  /// **Example:**
  /// ```dart
  /// CoreWidgetLogger.lifecycle('LoginWidget', 'initState', {
  ///   'userId': user.id,
  ///   'timestamp': DateTime.now().toIso8601String()
  /// });
  /// ```
  static void lifecycle(String widgetName, String event, [Map<String, dynamic>? data]) {
    if (_debugMode) {
      final dataStr = data != null ? ' | Data: $data' : '';
      debugPrint('$_tag LIFECYCLE: $widgetName.$event$dataStr');
    }
  }
  
  /// ⚡ Log performance metrics for operations
  /// 
  /// Monitor and log performance of critical operations.
  /// 
  /// **Example:**
  /// ```dart
  /// final stopwatch = Stopwatch()..start();
  /// await heavyOperation();
  /// stopwatch.stop();
  /// CoreWidgetLogger.performance('heavy_operation', stopwatch.elapsed, 'with 1000 items');
  /// ```
  static void performance(String operation, Duration duration, [String? details]) {
    if (_debugMode) {
      final detailsStr = details != null ? ' | $details' : '';
      debugPrint('$_tag PERFORMANCE: $operation took ${duration.inMilliseconds}ms$detailsStr');
    }
  }
}
