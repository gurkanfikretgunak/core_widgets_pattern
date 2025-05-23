import 'package:flutter/material.dart';
import '../logging/core_widget_logger.dart';

/// 👆 Mixin for gesture handling to implement DRY principle
/// 
/// Provides comprehensive gesture support with logging and debugging capabilities.
/// Supports tap, long press, double tap, tap down, and tap up gestures.
/// 
/// **Usage Example:**
/// ```dart
/// // In your widget's build method:
/// return buildGestureWrapper(
///   child: myChild,
///   onTap: () => print('Tapped!'),
///   onLongPress: () => showContextMenu(),
///   onDoubleTap: () => performQuickAction(),
///   debugLabel: 'MyActionButton',
/// );
/// ```
mixin CoreWidgetGestures {
  /// 🎯 Build gesture detector with comprehensive gesture support
  /// 
  /// Creates a GestureDetector wrapper with logging capabilities.
  /// Only creates the detector if at least one gesture is provided.
  /// 
  /// **Parameters:**
  /// - [child]: Widget to wrap with gesture detection
  /// - [onTap]: Single tap callback
  /// - [onLongPress]: Long press callback  
  /// - [onDoubleTap]: Double tap callback
  /// - [onTapDown]: Tap down callback (for press feedback)
  /// - [onTapUp]: Tap up callback (for release feedback)
  /// - [debugLabel]: Label for debugging purposes
  Widget buildGestureWrapper({
    required Widget child,
    VoidCallback? onTap,
    VoidCallback? onLongPress,
    VoidCallback? onDoubleTap,
    GestureTapDownCallback? onTapDown,
    GestureTapUpCallback? onTapUp,
    String? debugLabel,
  }) {
    // 🔍 Log gesture configuration in debug mode
    CoreWidgetLogger.debug(
      'Building gesture wrapper for ${debugLabel ?? 'widget'}',
      {
        'hasOnTap': onTap != null,
        'hasOnLongPress': onLongPress != null,
        'hasOnDoubleTap': onDoubleTap != null,
      },
    );
    
    // 🚫 Return child without gesture detector if no gestures are defined
    if (onTap == null && onLongPress == null && onDoubleTap == null && 
        onTapDown == null && onTapUp == null) {
      return child;
    }
    
    return GestureDetector(
      onTap: onTap != null ? () {
        CoreWidgetLogger.debug('Tap gesture executed for ${debugLabel ?? 'widget'}');
        onTap();
      } : null,
      onLongPress: onLongPress != null ? () {
        CoreWidgetLogger.debug('Long press gesture executed for ${debugLabel ?? 'widget'}');
        onLongPress();
      } : null,
      onDoubleTap: onDoubleTap != null ? () {
        CoreWidgetLogger.debug('Double tap gesture executed for ${debugLabel ?? 'widget'}');
        onDoubleTap();
      } : null,
      onTapDown: onTapDown,
      onTapUp: onTapUp,
      child: child,
    );
  }
}

/// 👆 Enhanced gesture configuration for better organization
/// 
/// Centralized gesture configuration with comprehensive touch support.
/// 
/// **Usage Example:**
/// ```dart
/// final gestureConfig = CoreWidgetGestureConfig(
///   onTap: () => navigateToDetail(),
///   onLongPress: () => showContextMenu(),
///   onDoubleTap: () => toggleFavorite(),
/// );
/// 
/// // Use in widget
/// CoreWidget(
///   config: myConfig,
///   gestureConfig: gestureConfig,
/// );
/// ```
class CoreWidgetGestureConfig {
  /// 👆 Single tap gesture callback
  final VoidCallback? onTap;
  
  /// 👆⏱️ Long press gesture callback
  final VoidCallback? onLongPress;
  
  /// 👆👆 Double tap gesture callback
  final VoidCallback? onDoubleTap;
  
  /// 👇 Tap down gesture callback (finger touches screen)
  final GestureTapDownCallback? onTapDown;
  
  /// 👆 Tap up gesture callback (finger releases screen)
  final GestureTapUpCallback? onTapUp;
  
  const CoreWidgetGestureConfig({
    this.onTap,
    this.onLongPress,
    this.onDoubleTap,
    this.onTapDown,
    this.onTapUp,
  });
  
  /// ✅ Check if any gesture is configured
  /// 
  /// Returns true if at least one gesture callback is provided
  bool get hasGestures => onTap != null || onLongPress != null || 
      onDoubleTap != null || onTapDown != null || onTapUp != null;
}
