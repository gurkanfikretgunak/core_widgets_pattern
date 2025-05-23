import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// ⚙️ Enhanced configuration class for better organization and type safety
/// 
/// Centralized configuration for CoreWidget styling, behavior, and debugging.
/// Provides immutable configuration with copyWith functionality.
/// 
/// **Usage Example:**
/// ```dart
/// final config = CoreWidgetConfig(
///   initialData: 'Hello World',
///   padding: EdgeInsets.all(20.0),
///   backgroundColor: Colors.blue.shade50,
///   borderRadius: BorderRadius.circular(12.0),
///   animationDuration: Duration(milliseconds: 300),
///   enableDebugLogging: true,
///   debugLabel: 'WelcomeCard',
/// );
/// 
/// // Create updated configuration
/// final updatedConfig = config.copyWith(
///   backgroundColor: Colors.green.shade50,
///   animationDuration: Duration(milliseconds: 500),
/// );
/// ```
class CoreWidgetConfig {
  /// 📄 Initial data to load in the widget
  final String? initialData;
  
  /// 📏 Padding around the widget content
  final EdgeInsets? padding;
  
  /// 🎨 Background color of the widget
  final Color? backgroundColor;
  
  /// 🔲 Border radius for rounded corners
  final BorderRadius? borderRadius;
  
  /// 🌫️ Shadow configuration for elevation effect
  final BoxShadow? shadow;
  
  /// ⏱️ Animation duration for state transitions
  final Duration? animationDuration;
  
  /// 📈 Animation curve for smooth transitions
  final Curve? animationCurve;
  
  /// 🔧 Enable debug logging for this widget
  final bool enableDebugLogging;
  
  /// 🏷️ Debug label for identification in logs
  final String? debugLabel;
  
  const CoreWidgetConfig({
    this.initialData,
    this.padding,
    this.backgroundColor,
    this.borderRadius,
    this.shadow,
    this.animationDuration,
    this.animationCurve,
    this.enableDebugLogging = kDebugMode,
    this.debugLabel,
  });
  
  /// 🔄 Create a copy with updated values
  /// 
  /// Returns a new instance with specified properties updated.
  /// Useful for creating variations of existing configurations.
  CoreWidgetConfig copyWith({
    String? initialData,
    EdgeInsets? padding,
    Color? backgroundColor,
    BorderRadius? borderRadius,
    BoxShadow? shadow,
    Duration? animationDuration,
    Curve? animationCurve,
    bool? enableDebugLogging,
    String? debugLabel,
  }) {
    return CoreWidgetConfig(
      initialData: initialData ?? this.initialData,
      padding: padding ?? this.padding,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderRadius: borderRadius ?? this.borderRadius,
      shadow: shadow ?? this.shadow,
      animationDuration: animationDuration ?? this.animationDuration,
      animationCurve: animationCurve ?? this.animationCurve,
      enableDebugLogging: enableDebugLogging ?? this.enableDebugLogging,
      debugLabel: debugLabel ?? this.debugLabel,
    );
  }
}
