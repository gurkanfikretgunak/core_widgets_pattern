import 'package:flutter/material.dart';
import '../../core/core_widget.dart';
import '../reusable_text_widget.dart';

/// 📸 **CaptionTextWidget** - Specialized widget for displaying caption text
///
/// 📝 **Purpose:**
/// Perfect for image captions, photo descriptions, footnotes, and supplementary
/// information that provides context without overwhelming the main content.
///
/// 🎨 **Features:**
/// - 🔤 Small, muted typography for subtle information
/// - 📅 Optional timestamp display for temporal context
/// - 🎯 Italic styling for visual distinction
/// - 📱 Optimized text overflow handling
/// - 🎪 Flexible alignment options
///
/// 💡 **Usage Examples:**
/// ```dart
/// // Photo caption with timestamp
/// CaptionTextWidget.create(
///   initialData: 'Sunset over the mountains',
///   showTimestamp: true,
///   textAlign: TextAlign.center,
/// )
///
/// // Figure caption for documentation
/// CaptionTextWidget.create(
///   initialData: 'Figure 1: User flow diagram showing the registration process',
///   maxLines: 2,
///   textAlign: TextAlign.left,
/// )
///
/// // Social media style caption
/// CaptionTextWidget.create(
///   initialData: 'Amazing day at the beach! #vacation #summer',
///   textColor: Colors.grey[600],
///   padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
/// )
/// ```
///
/// 🎭 **Visual Characteristics:**
/// - Smaller font size (12px) for subtle appearance
/// - Italic styling for clear differentiation
/// - Muted colors to avoid competing with main content
/// - Proper line spacing for readability
class CaptionTextWidget extends ReusableTextWidget {
  const CaptionTextWidget({
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

  /// 🏭 **Factory constructor with caption-specific defaults**
  ///
  /// Creates a CaptionTextWidget with appropriate styling for supplementary
  /// content that enhances but doesn't dominate the main interface.
  ///
  /// **Parameters:**
  /// - `initialData`: The caption text content
  /// - `textColor`: Custom text color (default: muted grey)
  /// - `textAlign`: Text alignment within the widget
  /// - `maxLines`: Maximum lines before truncation (default: 2)
  /// - `showTimestamp`: Whether to display timestamp information
  /// - `padding`: Custom padding around the caption
  ///
  /// **Returns:** Configured CaptionTextWidget instance
  factory CaptionTextWidget.create({
    Key? key,
    String? initialData,
    Color? textColor,
    TextAlign textAlign = TextAlign.start,
    int? maxLines,
    bool showTimestamp = false,
    String? widgetId,
    EdgeInsets? padding,
  }) {
    return CaptionTextWidget(
      key: key,
      config: CoreWidgetConfig(
        initialData: initialData,
        padding: padding ?? const EdgeInsets.symmetric(vertical: 2),
        debugLabel: 'CaptionTextWidget',
      ),
      textConfig: TextWidgetConfig(
        textStyle: TextStyle(
          fontSize: 12,
          color: textColor ?? Colors.grey[600],
          fontStyle: FontStyle.italic,
        ),
        textAlign: textAlign,
        maxLines: maxLines ?? 2,
        overflow: TextOverflow.ellipsis,
        showTimestamp: showTimestamp,
      ),
      widgetId: widgetId ?? 'CaptionTextWidget',
    );
  }
}

/// 📋 **IMPORTANT USAGE REQUIREMENTS & BEST PRACTICES**
///
/// ⚠️ **Critical Guidelines:**
///
/// 1. **🎨 Visual Hierarchy:**
///    - Keep captions visually subordinate to main content
///    - Use consistent muted colors (grey tones recommended)
///    - Maintain smaller font sizes relative to body text
///    - Apply italic styling to clearly distinguish from main text
///
/// 2. **📝 Content Guidelines:**
///    - Write concise, descriptive captions
///    - Provide context without repeating obvious information
///    - Include relevant metadata (time, location, source)
///    - Keep captions under 2 lines when possible
///
/// 3. **📱 Responsive Design:**
///    - Test caption readability on small screens
///    - Ensure proper text wrapping and truncation
///    - Consider different screen orientations
///    - Maintain legibility at various font scale settings
///
/// 4. **♿ Accessibility Considerations:**
///    - Provide sufficient contrast even with muted colors
///    - Ensure captions are readable by screen readers
///    - Consider alternative text for image captions
///    - Support system font sizing preferences
///
/// 5. **🎯 Placement & Spacing:**
///    - Position captions close to related content
///    - Use consistent spacing between captions and main content
///    - Align captions appropriately with their context
///    - Avoid overcrowding with multiple captions
///
/// 6. **📅 Timestamp Usage:**
///    - Use timestamps for time-sensitive content
///    - Choose appropriate timestamp formats (relative vs absolute)
///    - Consider timezone handling for global applications
///    - Update timestamps appropriately for real-time content
///
/// 7. **🔄 Dynamic Content:**
///    - Handle caption updates gracefully
///    - Consider loading states for dynamic captions
///    - Implement proper error handling for missing captions
///    - Support multi-language caption content
///
/// 8. **📐 Layout Integration:**
///    - Work well within card layouts and lists
///    - Integrate smoothly with image galleries
///    - Support various container widths
///    - Maintain consistent baseline alignment
///
/// 💡 **Pro Tips:**
/// - Use captions to provide context that enhances user understanding
/// - Consider adding edit functionality for user-generated captions
/// - Implement caption search functionality for media galleries
/// - Add caption translation support for international apps
/// - Use captions to improve content accessibility and SEO
