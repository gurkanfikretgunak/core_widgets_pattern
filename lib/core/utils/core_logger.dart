/// Centralized logging utility for Core Widget
class CoreLogger {
  static const String _logTag = '[CoreWidgetBloc]';
  
  final bool debugMode;
  
  const CoreLogger({required this.debugMode});

  /// Gets current timestamp for logging
  String get _timestamp => DateTime.now().toIso8601String();

  /// Gets caller information from stack trace
  String _getCallerInfo() {
    try {
      final stack = StackTrace.current;
      final frames = stack.toString().split('\n');
      if (frames.length > 2) {
        final callerFrame = frames[2];
        final match = RegExp(r'#\d+\s+(.+)\s+\((.+):(\d+):\d+\)').firstMatch(callerFrame);
        if (match != null) {
          final method = match.group(1)?.split('.').last ?? 'unknown';
          final file = match.group(2)?.split('/').last ?? 'unknown';
          final line = match.group(3) ?? '0';
          return '[$file:$line:$method]';
        }
      }
    } catch (e) {
      // Fallback if stack trace parsing fails
    }
    return '[unknown]';
  }

  /// Logs debug messages (only in debug mode)
  void logDebug(String message) {
    if (debugMode) {
      final caller = _getCallerInfo();
      print('$_logTag [DEBUG] $_timestamp $caller $message');
    }
  }

  /// Logs info messages
  void logInfo(String message) {
    final caller = _getCallerInfo();
    print('$_logTag [INFO] $_timestamp $caller $message');
  }

  /// Logs warning messages with enhanced context
  void logWarning(String message, {String? context, Map<String, dynamic>? additionalInfo}) {
    final caller = _getCallerInfo();
    final contextInfo = context != null ? ' [Context: $context]' : '';
    print('$_logTag [WARNING] $_timestamp $caller$contextInfo $message');
    
    if (additionalInfo != null && additionalInfo.isNotEmpty && debugMode) {
      print('$_logTag [WARNING] Additional Info: $additionalInfo');
    }
  }

  /// Logs error messages with stack trace
  void logError(String message, dynamic error, StackTrace stackTrace) {
    final caller = _getCallerInfo();
    print('$_logTag [ERROR] $_timestamp $caller $message');
    print('$_logTag [ERROR] Error Type: ${error.runtimeType}');
    print('$_logTag [ERROR] Error Details: $error');
    
    if (debugMode) {
      print('$_logTag [ERROR] Full Stack Trace:');
      final stackLines = stackTrace.toString().split('\n');
      for (int i = 0; i < stackLines.length && i < 10; i++) {
        if (stackLines[i].trim().isNotEmpty) {
          print('$_logTag [ERROR]   ${stackLines[i]}');
        }
      }
    }
  }

  /// Logs performance warnings for slow operations
  void logPerformanceWarning(String operation, Duration duration, {Duration? threshold}) {
    final defaultThreshold = threshold ?? const Duration(milliseconds: 500);
    if (duration > defaultThreshold) {
      final caller = _getCallerInfo();
      print('$_logTag [PERFORMANCE] $_timestamp $caller SLOW OPERATION: $operation took ${duration.inMilliseconds}ms (threshold: ${defaultThreshold.inMilliseconds}ms)');
    }
  }

  /// Logs state change warnings
  void logStateWarning(String component, String fromState, String toState, {String? reason}) {
    final caller = _getCallerInfo();
    final reasonInfo = reason != null ? ' Reason: $reason' : '';
    print('$_logTag [STATE_WARNING] $_timestamp $caller $component: $fromState -> $toState.$reasonInfo');
  }
}
