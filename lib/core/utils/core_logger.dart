/// Centralized logging utility for Core Widget
class CoreLogger {
  static const String _logTag = '[CoreWidgetBloc]';
  
  final bool debugMode;
  
  const CoreLogger({required this.debugMode});

  /// Logs debug messages (only in debug mode)
  void logDebug(String message) {
    if (debugMode) {
      print('$_logTag [DEBUG] $message');
    }
  }

  /// Logs info messages
  void logInfo(String message) {
    print('$_logTag [INFO] $message');
  }

  /// Logs error messages with stack trace
  void logError(String message, dynamic error, StackTrace stackTrace) {
    print('$_logTag [ERROR] $message');
    print('$_logTag [ERROR] Error: $error');
    if (debugMode) {
      print('$_logTag [ERROR] Stack trace: $stackTrace');
    }
  }
}
