import 'package:flutter/material.dart';
import '../../core/core_widget.dart';
import '../reusable_text_widget.dart';

/// 📖 **DescriptionTextWidget** - Specialized widget for displaying descriptive text
/// 
/// 📝 **Purpose:**
/// Ideal for detailed explanations, product descriptions, article content, and any
/// multi-line text that provides comprehensive information to users.
/// 
/// 🎨 **Features:**
/// - 📚 Optimized for longer text content with proper line spacing
/// - 🔍 Text selection support for easy copying and reference
/// - 📱 Responsive text flow with intelligent wrapping
/// - 🎯 Balanced typography for enhanced readability
/// - 🌊 Smooth text overflow handling for various content lengths
/// 
/// 💡 **Usage Examples:**
/// ```dart
/// // Product description
/// DescriptionTextWidget.create(
///   initialData: '''
/// This premium wireless headphone delivers exceptional sound quality 
/// with active noise cancellation. Features include 30-hour battery life, 
/// quick charge capability, and premium comfort padding.
///   ''',
///   enableSelection: true,
/// )
/// 
/// // Help text with custom styling
/// DescriptionTextWidget.create(
///   initialData: 'To get started, simply tap the plus button and follow the guided setup process...',
///   textColor: Colors.grey[700],
///   textAlign: TextAlign.justify,
///   maxLines: 5,
/// )
/// 
/// // Article excerpt
/// DescriptionTextWidget.create(
///   initialData: 'In this comprehensive guide, we explore the latest trends in mobile app development...',
///   padding: EdgeInsets.all(16),
///   enableSelection: true,
/// )
/// ```
/// 
/// 📖 **Reading Experience:**
/// - Optimal line height (1.4) for comfortable reading
/// - Balanced font size for various screen sizes
/// - Proper paragraph spacing and text flow
/// - Support for longer content with graceful overflow
class DescriptionTextWidget extends ReusableTextWidget {
  const DescriptionTextWidget({
    Key? key,
    required CoreWidgetConfig config,
    CoreWidgetGestureConfig gestureConfig = const CoreWidgetGestureConfig(),
    String? widgetId,
    TextWidgetConfig textConfig = const TextWidgetConfig(),
    IconWidgetConfig iconConfig = const IconWidgetConfig(),
  }) : super(
         key: key,
         config: config,
         gestureConfig: gestureConfig,
         widgetId: widgetId,
         textConfig: textConfig,
         iconConfig: iconConfig,
       );

  /// 🏭 **Factory constructor with description-specific defaults**
  /// 
  /// Creates a DescriptionTextWidget optimized for longer text content
  /// with enhanced readability and user interaction features.
  /// 
  /// **Parameters:**
  /// - `initialData`: The descriptive text content to display
  /// - `textColor`: Custom text color (default: black87 for readability)
  /// - `textAlign`: Text alignment (default: start for natural reading)
  /// - `maxLines`: Maximum lines before truncation (null for unlimited)
  /// - `enableSelection`: Allow text selection for copying (default: true)
  /// - `padding`: Custom padding around the text content
  /// 
  /// **Returns:** Configured DescriptionTextWidget instance
  factory DescriptionTextWidget.create({
    Key? key,
    String? initialData,
    Color? textColor,
    TextAlign textAlign = TextAlign.start,
    int? maxLines,
    bool enableSelection = true,
    String? widgetId,
    EdgeInsets? padding,
  }) {
    return DescriptionTextWidget(
      key: key,
      config: CoreWidgetConfig(
        initialData: initialData,
        padding: padding ?? const EdgeInsets.symmetric(vertical: 4),
        debugLabel: 'DescriptionTextWidget',
      ),
      textConfig: TextWidgetConfig(
        textStyle: TextStyle(
          fontSize: 14,
          color: textColor ?? Colors.black87,
          height: 1.4,
        ),
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: TextOverflow.fade,
        enableSelection: enableSelection,
      ),
      widgetId: widgetId ?? 'DescriptionTextWidget',
    );
  }
}

/// 📋 **IMPORTANT USAGE REQUIREMENTS & BEST PRACTICES**
/// 
/// ⚠️ **Critical Guidelines:**
/// 
/// 1. **📖 Readability Optimization:**
///    - Use line height of 1.4 for optimal reading comfort
///    - Maintain consistent font size (14px recommended)
///    - Ensure sufficient contrast ratio (4.5:1 minimum)
///    - Test readability across different screen sizes
/// 
/// 2. **📝 Content Structure:**
///    - Break long descriptions into digestible paragraphs
///    - Use clear, concise language appropriate for your audience
///    - Include relevant details without overwhelming users
///    - Consider content hierarchy with headers when needed
/// 
/// 3. **📱 Mobile Optimization:**
///    - Test text flow on various screen widths
///    - Ensure comfortable reading on small screens
///    - Consider portrait vs landscape orientations
///    - Support system font scaling preferences
/// 
/// 4. **🔍 Text Selection Features:**
///    - Enable selection for reference and sharing purposes
///    - Consider copy functionality for important information
///    - Test selection behavior across different platforms
///    - Ensure selection doesn't interfere with scrolling
/// 
/// 5. **🌊 Content Overflow Handling:**
///    - Use `TextOverflow.fade` for natural content cutoff
///    - Implement "Read more" functionality for long content
///    - Consider pagination for extremely long descriptions
///    - Provide clear indicators when content is truncated
/// 
/// 6. **♿ Accessibility Standards:**
///    - Support screen readers with proper semantic markup
///    - Ensure keyboard navigation works correctly
///    - Provide alternative text when descriptions reference images
///    - Support high contrast and large text modes
/// 
/// 7. **🎨 Visual Integration:**
///    - Maintain consistent spacing with surrounding content
///    - Use appropriate text alignment for content type
///    - Consider background colors for emphasis when needed
///    - Ensure descriptions complement overall design
/// 
/// 8. **⚡ Performance Considerations:**
///    - Optimize for large amounts of text content
///    - Consider lazy loading for long descriptions
///    - Implement efficient text rendering for scrollable content
///    - Monitor memory usage with extensive text content
/// 
/// 9. **🌍 Internationalization:**
///    - Support right-to-left languages appropriately
///    - Handle different text lengths in various languages
///    - Consider cultural reading patterns and preferences
///    - Test with translated content for layout stability
/// 
/// 10. **🔄 Dynamic Content:**
///     - Handle content updates smoothly
///     - Implement loading states for dynamic descriptions
///     - Support real-time content editing when applicable
///     - Maintain scroll position during content updates
/// 
/// 💡 **Pro Tips:**
/// - Use rich text formatting for enhanced descriptions
/// - Implement search functionality within long descriptions
/// - Add bookmarking for important descriptive content
/// - Consider voice reading integration for accessibility
/// - Use analytics to optimize description length and content
