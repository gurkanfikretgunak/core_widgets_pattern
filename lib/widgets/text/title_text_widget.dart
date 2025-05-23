import 'package:flutter/material.dart';
import '../../core/core_widget.dart';
import '../reusable_text_widget.dart';

/// 👑 **TitleTextWidget** - Specialized widget for displaying title text
///
/// 📝 **Purpose:**
/// The primary heading widget for screens, sections, and major content areas.
/// Establishes clear visual hierarchy and provides strong focal points for
/// user attention and navigation.
///
//🎨 **Features:**
/// - 🔤 Bold typography for maximum visual impact
/// - 📏 Large font size for hierarchy establishment
/// - 🎭 Optional leading icons for content categorization
/// - 🖱️ Interactive capabilities for navigation and actions
/// - 📱 Responsive design with smart text handling
///
/// 💡 **Usage Examples:**
/// ```dart
/// // Main screen title
/// TitleTextWidget.create(
///   initialData: 'Dashboard',
///   leadingIcon: Icons.dashboard,
/// )
///
/// // Interactive section title
/// TitleTextWidget.create(
///   initialData: 'My Projects',
///   onTap: () => navigateToProjects(),
///   textColor: Theme.of(context).primaryColor,
/// )
///
/// // Centered page title
/// TitleTextWidget.create(
///   initialData: 'Welcome to FlutterApp',
///   textAlign: TextAlign.center,
///   padding: EdgeInsets.symmetric(vertical: 24),
/// )
/// ```
///
/// 👑 **Hierarchy Leadership:**
/// - Top-level heading in content hierarchy
/// - Primary navigation and orientation element
/// - Key component for user mental model building
/// - Essential for accessibility and screen reader navigation
class TitleTextWidget extends ReusableTextWidget {
  const TitleTextWidget({
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

  /// 🏭 **Factory constructor with title-specific defaults**
  ///
  /// Creates a TitleTextWidget with prominent typography and layout
  /// optimized for maximum visual impact and clear hierarchy.
  ///
  /// **Parameters:**
  /// - `initialData`: The title text content
  /// - `textColor`: Custom text color (default: black87)
  /// - `textAlign`: Text alignment within the widget
  /// - `maxLines`: Maximum lines before truncation (default: 2)
  /// - `leadingIcon`: Optional icon for visual enhancement
  /// - `onTap`: Callback for interactive title behavior
  /// - `padding`: Custom padding around the title
  ///
  /// **Returns:** Configured TitleTextWidget instance
  factory TitleTextWidget.create({
    Key? key,
    String? initialData,
    Color? textColor,
    TextAlign textAlign = TextAlign.start,
    int? maxLines,
    IconData? leadingIcon,
    VoidCallback? onTap,
    String? widgetId,
    EdgeInsets? padding,
  }) {
    return TitleTextWidget(
      key: key,
      config: CoreWidgetConfig(
        initialData: initialData,
        padding: padding ?? const EdgeInsets.symmetric(vertical: 8),
        debugLabel: 'TitleTextWidget',
      ),
      gestureConfig: CoreWidgetGestureConfig(
        onTap: onTap,
      ),
      textConfig: TextWidgetConfig(
        textStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
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
              iconSize: 24,
            )
          : const IconWidgetConfig(),
      widgetId: widgetId ?? 'TitleTextWidget',
    );
  }
}

/// 📋 **IMPORTANT USAGE REQUIREMENTS & BEST PRACTICES**
///
/// ⚠️ **Critical Guidelines:**
///
/// 1. **👑 Hierarchy Leadership:**
///    - Use as the primary heading element on screens/sections
///    - Maintain largest font size in the content hierarchy
///    - Apply bold font weight for maximum visual impact
///    - Ensure clear distinction from subtitles and body text
///
/// 2. **🎯 Content Strategy:**
///    - Keep titles concise but descriptive (ideally 1-2 lines)
///    - Use action-oriented language when titles are interactive
///    - Maintain consistency in title formatting across the app
///    - Consider user mental models when crafting title text
///
/// 3. **📱 Responsive Design:**
///    - Test title rendering across all device sizes
///    - Ensure titles remain impactful on small screens
///    - Consider abbreviated versions for space-constrained layouts
///    - Maintain readability with system font scaling
///
/// 4. **♿ Accessibility Excellence:**
///    - Use proper heading semantics (H1, H2, etc.) for screen readers
///    - Ensure exceptional color contrast (7:1 for titles)
///    - Support keyboard navigation for interactive titles
///    - Provide alternative text for icon-enhanced titles
///
/// 5. **🎨 Visual Impact:**
///    - Use consistent color schemes that align with brand identity
///    - Maintain adequate white space around titles
///    - Consider typography that reflects app personality
///    - Ensure titles create strong focal points
///
/// 6. **🖱️ Interactive Behavior:**
///    - Make interactive titles obviously clickable
///    - Provide clear visual feedback for tap interactions
///    - Use appropriate cursor styles on web platforms
///    - Implement proper touch target sizes (44x44px minimum)
///
/// 7. **🎭 Icon Integration:**
///    - Use icons sparingly and only when they add meaningful context
///    - Maintain consistent icon styles and proportions
///    - Ensure icons are culturally appropriate and universally understood
///    - Test icon visibility across different themes and backgrounds
///
/// 8. **🌍 Internationalization:**
///    - Plan for significant text length variations (up to 300%)
///    - Support right-to-left languages with proper alignment
///    - Consider cultural differences in title prominence
///    - Test layout stability with longest possible translations
///
/// 9. **⚡ Performance Optimization:**
///    - Use efficient rendering for screens with multiple titles
///    - Optimize font loading for custom typography
///    - Consider caching for dynamic title content
///    - Monitor layout performance with complex title structures
///
/// 10. **🔄 Dynamic Content:**
///     - Handle title updates smoothly without jarring layout changes
///     - Implement appropriate loading states for dynamic titles
///     - Maintain user context during title transitions
///     - Support real-time title updates when necessary
///
/// 11. **📊 Analytics & UX:**
///     - Track interaction rates with clickable titles
///     - Monitor title truncation frequency across devices
///     - Analyze user comprehension of title content
///     - A/B test title variations for optimal engagement
///
/// 💡 **Pro Tips:**
/// - Use titles to establish clear information architecture
/// - Implement breadcrumb navigation for nested title hierarchies
/// - Add subtle animations for title state changes
/// - Consider voice input integration for accessibility
/// - Use consistent title patterns to build user familiarity
/// - Implement smart truncation that preserves meaning
/// - Add sharing functionality for content titles
/// - Consider SEO implications for web-based applications
