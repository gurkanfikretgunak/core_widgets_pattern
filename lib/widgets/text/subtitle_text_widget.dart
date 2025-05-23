import 'package:flutter/material.dart';
import '../../core/core_widget.dart';
import '../reusable_text_widget.dart';

/// 📑 **SubtitleTextWidget** - Specialized widget for displaying subtitle text
///
/// 📝 **Purpose:**
/// Perfect for secondary headings, section dividers, and hierarchical content
/// organization. Provides clear visual hierarchy between main titles and body content.
/// 
/// 🎨 **Features:**
/// - 🔤 Medium-weight typography for balanced prominence
/// - 📏 Optimized sizing between titles and body text
/// - 🎭 Optional leading icons for enhanced categorization
/// - 📱 Responsive text handling with smart truncation
/// - 🎯 Flexible alignment options for various layouts
/// 
/// 💡 **Usage Examples:**
/// ```dart
/// // Section subtitle
/// SubtitleTextWidget.create(
///   initialData: 'Recent Activity',
///   leadingIcon: Icons.history,
/// )
/// 
/// // Card subtitle with custom styling
/// SubtitleTextWidget.create(
///   initialData: 'Premium Features',
///   textColor: Theme.of(context).primaryColor,
///   textAlign: TextAlign.center,
/// )
/// 
/// // Category subtitle in list
/// SubtitleTextWidget.create(
///   initialData: 'Entertainment & Media',
///   maxLines: 1,
///   padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
/// )
/// ```
/// 
/// 📐 **Hierarchy Position:**
/// - Positioned between main titles (H1/H2) and body text
/// - Provides clear content organization and navigation
/// - Supports nested content structures
/// - Enhances scanability of long-form content
class SubtitleTextWidget extends ReusableTextWidget {
  const SubtitleTextWidget({
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

  /// 🏭 **Factory constructor with subtitle-specific defaults**
  /// 
  /// Creates a SubtitleTextWidget with balanced typography that provides
  /// clear hierarchy while maintaining readability and visual appeal.
  /// 
  /// **Parameters:**
  /// - `initialData`: The subtitle text content
  /// - `textColor`: Custom text color (default: black87)
  /// - `textAlign`: Text alignment within the widget
  /// - `maxLines`: Maximum lines before truncation (default: 2)
  /// - `leadingIcon`: Optional icon for content categorization
  /// - `padding`: Custom padding around the subtitle
  /// 
  /// **Returns:** Configured SubtitleTextWidget instance
  factory SubtitleTextWidget.create({
    Key? key,
    String? initialData,
    Color? textColor,
    TextAlign textAlign = TextAlign.start,
    int? maxLines,
    IconData? leadingIcon,
    String? widgetId,
    EdgeInsets? padding,
  }) {
    return SubtitleTextWidget(
      key: key,
      config: CoreWidgetConfig(
        initialData: initialData,
        padding: padding ?? const EdgeInsets.symmetric(vertical: 6),
        debugLabel: 'SubtitleTextWidget',
      ),
      textConfig: TextWidgetConfig(
        textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: textColor ?? Colors.black87,
        ),
        textAlign: textAlign,
        maxLines: maxLines ?? 2,
        overflow: TextOverflow.ellipsis,
      ),
      iconConfig: leadingIcon != null
          ? IconWidgetConfig(
              leadingIcon: leadingIcon,
              iconColor: textColor ?? Colors.black87,
              iconSize: 20,
            )
          : const IconWidgetConfig(),
      widgetId: widgetId ?? 'SubtitleTextWidget',
    );
  }
}

/// 📋 **IMPORTANT USAGE REQUIREMENTS & BEST PRACTICES**
/// 
/// ⚠️ **Critical Guidelines:**
/// 
/// 1. **📐 Visual Hierarchy:**
///    - Maintain clear size distinction from main titles (smaller)
///    - Keep larger than body text for proper hierarchy
///    - Use consistent font weight (semi-bold/600) across subtitles
///    - Ensure adequate spacing between hierarchy levels
/// 
/// 2. **🎯 Content Organization:**
///    - Use subtitles to break up long content sections
///    - Group related content under descriptive subtitles
///    - Maintain logical content flow and structure
///    - Consider nested subtitle levels for complex content
/// 
/// 3. **📱 Responsive Behavior:**
///    - Test subtitle rendering on various screen sizes
///    - Ensure proper text wrapping for longer subtitles
///    - Consider abbreviated versions for mobile layouts
///    - Maintain readability at different zoom levels
/// 
/// 4. **🎨 Visual Consistency:**
///    - Use consistent color schemes for subtitle categories
///    - Maintain uniform spacing between subtitles and content
///    - Apply consistent icon styles when using leading icons
///    - Ensure subtitles align with overall design system
/// 
/// 5. **🎭 Icon Integration:**
///    - Use icons sparingly and meaningfully
///    - Maintain consistent icon styles and sizes
///    - Ensure icons enhance rather than clutter the design
///    - Consider accessibility implications of icon usage
/// 
/// 6. **♿ Accessibility Standards:**
///    - Provide proper heading structure for screen readers
///    - Ensure sufficient color contrast for all text
///    - Support keyboard navigation when interactive
///    - Use semantic HTML headings when appropriate
/// 
/// 7. **📝 Content Guidelines:**
///    - Keep subtitles concise and descriptive
///    - Use consistent terminology across sections
///    - Avoid overly technical language in user-facing subtitles
///    - Consider localization requirements for different markets
/// 
/// 8. **🔄 Dynamic Content:**
///    - Handle subtitle updates smoothly without layout jumps
///    - Support real-time content categorization
///    - Implement loading states for dynamic subtitles
///    - Maintain scroll position during content updates
/// 
/// 9. **🌍 Internationalization:**
///    - Plan for varying subtitle lengths in different languages
///    - Support right-to-left text directions appropriately
///    - Consider cultural differences in content hierarchy
///    - Test layout stability with translated content
/// 
/// 10. **⚡ Performance Optimization:**
///     - Optimize rendering for pages with many subtitles
///     - Use efficient layout algorithms for complex hierarchies
///     - Consider virtual scrolling for extensive content lists
///     - Monitor performance with nested subtitle structures
/// 
/// 💡 **Pro Tips:**
/// - Use subtitles to improve content scanability and navigation
/// - Implement smooth scrolling to subtitle anchors
/// - Add collapse/expand functionality for section management
/// - Consider auto-generating table of contents from subtitles
/// - Use subtle animations for dynamic subtitle updates
/// - Implement search functionality that highlights matching subtitles
