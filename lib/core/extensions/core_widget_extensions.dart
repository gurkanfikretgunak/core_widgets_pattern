import '../config/core_widget_config.dart';
import '../gestures/core_widget_gestures.dart';
import '../widgets/core_widget.dart';

/// 🚀 Extension for additional utility methods
/// 
/// Provides fluent API methods for CoreWidget configuration.
/// These methods need to be implemented by concrete widget classes.
extension CoreWidgetExtensions on CoreWidget {
  /// ⚙️ Create a configured CoreWidget with fluent API
  /// 
  /// **Note:** This must be implemented by concrete classes
  /// 
  /// **Example Implementation:**
  /// ```dart
  /// @override
  /// MyWidget withConfig(CoreWidgetConfig newConfig) {
  ///   return MyWidget(
  ///     key: key,
  ///     config: newConfig,
  ///     gestureConfig: gestureConfig,
  ///     widgetId: widgetId,
  ///   );
  /// }
  /// ```
  CoreWidget withConfig(CoreWidgetConfig newConfig) {
    throw UnimplementedError('withConfig must be implemented by concrete classes');
  }
  
  /// 👆 Create a CoreWidget with updated gestures
  /// 
  /// **Note:** This must be implemented by concrete classes
  /// 
  /// **Example Implementation:**
  /// ```dart
  /// @override
  /// MyWidget withGestures(CoreWidgetGestureConfig newGestureConfig) {
  ///   return MyWidget(
  ///     key: key,
  ///     config: config,
  ///     gestureConfig: newGestureConfig,
  ///     widgetId: widgetId,
  ///   );
  /// }
  /// ```
  CoreWidget withGestures(CoreWidgetGestureConfig newGestureConfig) {
    throw UnimplementedError('withGestures must be implemented by concrete classes');
  }
}
