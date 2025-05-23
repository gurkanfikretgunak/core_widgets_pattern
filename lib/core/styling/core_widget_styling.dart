import 'package:flutter/material.dart';

/// 🎨 Mixin for common styling configurations to implement DRY principle
/// 
/// Provides consistent styling across all CoreWidget implementations.
/// Includes default values and resolution methods for common styling properties.
/// 
/// **Usage Example:**
/// ```dart
/// class MyCustomWidget extends CoreWidget with CoreWidgetStyling {
///   @override
///   Widget buildContent(BuildContext context, CoreWidgetState state) {
///     return Container(
///       padding: getResolvedPadding(widget.config.padding),
///       decoration: BoxDecoration(
///         borderRadius: getResolvedBorderRadius(widget.config.borderRadius),
///         boxShadow: getResolvedShadow(widget.config.shadow),
///       ),
///       child: Text('Styled content'),
///     );
///   }
/// }
/// ```
mixin CoreWidgetStyling {
  /// 📏 Default padding configuration (16.0 on all sides)
  static const EdgeInsets defaultPadding = EdgeInsets.all(16.0);
  
  /// 🔲 Default border radius (8.0 circular radius)
  static const BorderRadius defaultBorderRadius = BorderRadius.all(Radius.circular(8.0));
  
  /// 🌫️ Default shadow configuration with subtle elevation
  /// 
  /// Creates a subtle shadow with 10% black opacity and 4px blur radius
  static BoxShadow defaultShadow() => BoxShadow(
    color: Colors.black.withOpacity(0.1),
    blurRadius: 4,
    offset: const Offset(0, 2),
  );
  
  /// 📐 Get resolved padding with fallback to default
  /// 
  /// Returns provided padding or falls back to [defaultPadding]
  EdgeInsets getResolvedPadding(EdgeInsets? padding) {
    return padding ?? defaultPadding;
  }
  
  /// 🔳 Get resolved border radius with fallback to default
  /// 
  /// Returns provided border radius or falls back to [defaultBorderRadius]
  BorderRadius getResolvedBorderRadius(BorderRadius? borderRadius) {
    return borderRadius ?? defaultBorderRadius;
  }
  
  /// 🌤️ Get resolved shadow with fallback to default
  /// 
  /// Returns provided shadow in a list or falls back to [defaultShadow]
  List<BoxShadow> getResolvedShadow(BoxShadow? shadow) {
    return shadow != null ? [shadow] : [defaultShadow()];
  }
}
