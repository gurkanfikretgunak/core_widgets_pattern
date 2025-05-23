import 'package:flutter/material.dart';
import '../../core/core_widget.dart';
import '../reusable_text_widget.dart';

/// 🔗 **LinkTextWidget** - Specialized widget for displaying clickable link text
/// 
/// 📝 **Purpose:**
/// Creates interactive text links with proper visual indicators and accessibility support.
/// Perfect for navigation links, external URLs, and interactive text elements.
/// 
/// 🎨 **Features:**
/// - 🌐 Automatic underline styling for link recognition
/// - 🎯 Customizable tap handling and navigation
/// - 🔤 Consistent link typography and coloring
/// - 📱 Touch-friendly interactive areas
/// - 🎭 Optional trailing icons for external links
/// 
/// 💡 **Usage Examples:**
/// ```dart
/// // Basic navigation link
/// LinkTextWidget.create(
///   initialData: 'Go to Settings',
///   onTap: () => Navigator.pushNamed(context, '/settings'),
/// )
/// 
/// // External URL with icon
/// LinkTextWidget.create(
///   initialData: 'Visit our website',
///   linkColor: Colors.blue,
///   linkIcon: Icons.open_in_new,
///   onTap: () => launchUrl('https://example.com'),
/// )
/// 
/// // Custom styled internal link
/// LinkTextWidget.create(
///   initialData: 'Learn more about this feature',
///   underline: false,
///   linkColor: Theme.of(context).primaryColor,
///   padding: EdgeInsets.symmetric(vertical: 8),
///   onTap: () => showHelpDialog(context),
/// )
/// ```
/// 
/// ⚡ **Accessibility Features:**
/// - Proper semantic labeling for screen readers
/// - Keyboard navigation support
/// - High contrast color support
/// - Touch target size optimization
class LinkTextWidget extends ReusableTextWidget {
  const LinkTextWidget({
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

  /// 🏭 **Factory constructor with link-specific defaults**
  /// 
  /// Creates a LinkTextWidget with proper link styling and interaction handling.
  /// 
  /// **Parameters:**
  /// - `initialData`: The link text to display
  /// - `onTap`: Callback function when link is tapped
  /// - `linkColor`: Custom color for the link (default: blue)
  /// - `underline`: Whether to show underline decoration (default: true)
  /// - `linkIcon`: Optional icon to show after the link text
  /// - `padding`: Custom padding around the link
  /// 
  /// **Returns:** Configured LinkTextWidget instance
  factory LinkTextWidget.create({
    Key? key,
    String? initialData,
    VoidCallback? onTap,
    Color? linkColor,
    bool underline = true,
    IconData? linkIcon,
    String? widgetId,
    EdgeInsets? padding,
  }) {
    return LinkTextWidget(
      key: key,
      config: CoreWidgetConfig(
        initialData: initialData,
        padding: padding ?? const EdgeInsets.symmetric(vertical: 4),
        debugLabel: 'LinkTextWidget',
      ),
      gestureConfig: CoreWidgetGestureConfig(
        onTap: onTap,
      ),
      textConfig: TextWidgetConfig(
        textStyle: TextStyle(
          color: linkColor ?? Colors.blue,
          decoration: underline ? TextDecoration.underline : TextDecoration.none,
          decorationColor: linkColor ?? Colors.blue,
        ),
        enableSelection: true,
      ),
      iconConfig: IconWidgetConfig(
        trailingIcon: linkIcon ?? Icons.launch,
        iconColor: linkColor ?? Colors.blue,
        iconSize: 16,
      ),
      widgetId: widgetId ?? 'LinkTextWidget',
    );
  }
}

/// 📋 **IMPORTANT USAGE REQUIREMENTS & BEST PRACTICES**
/// 
/// ⚠️ **Critical Guidelines:**
/// 
/// 1. **🎯 Tap Target Requirements:**
///    - Minimum touch target size should be 44x44 pixels
///    - Add adequate padding for comfortable tapping
///    - Consider thumb-friendly placement on mobile devices
/// 
/// 2. **🌐 Link Styling Standards:**
///    - Use underlines for primary links to ensure recognition
///    - Maintain consistent link colors throughout the app
///    - Distinguish visited vs unvisited links when applicable
/// 
/// 3. **♿ Accessibility Compliance:**
///    - Provide clear, descriptive link text
///    - Avoid "click here" or generic phrases
///    - Ensure sufficient color contrast (4.5:1 minimum)
///    - Support keyboard navigation and screen readers
/// 
/// 4. **🔄 Navigation Patterns:**
///    - Use internal navigation for app screens
///    - Show external link indicators for URLs leaving the app
///    - Implement proper back button behavior
/// 
/// 5. **📱 Mobile Considerations:**
///    - Test links on various device sizes
///    - Consider landscape vs portrait orientations
///    - Ensure links work well with system font scaling
/// 
/// 6. **⚡ Performance Guidelines:**
///    - Avoid heavy operations in onTap callbacks
///    - Use proper async handling for network requests
///    - Implement loading states for slow operations
/// 
/// 7. **🎨 Visual Consistency:**
///    - Match link colors with app theme
///    - Use consistent icon styles across the app
///    - Maintain proper spacing between links in lists
/// 
/// 💡 **Pro Tips:**
/// - Combine with loading indicators for navigation
/// - Add haptic feedback for better user experience
/// - Consider deep linking for shareable content
/// - Use analytics to track link interaction rates
