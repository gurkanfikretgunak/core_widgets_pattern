import 'package:flutter/material.dart';
import '../../core/core_widget.dart';
import '../reusable_text_widget.dart';

/// 🏷️ **LabelTextWidget** - Specialized widget for displaying label text
///
/// 📝 **Purpose:**
/// Essential for form labels, field descriptions, and UI element identifiers.
/// Provides clear, accessible labeling with support for required field indicators
/// and contextual help information.
///
/// 🎨 **Features:**
/// - 🔤 Semi-bold typography for clear identification
/// - ⭐ Required field indicator with asterisk notation
/// - ❓ Optional help icon with contextual assistance
/// - 📱 Consistent spacing and alignment with form elements
/// - ♿ Enhanced accessibility support for screen readers
///
/// 💡 **Usage Examples:**
/// ```dart
/// // Basic form field label
/// LabelTextWidget.create(
///   initialData: 'Email Address',
///   isRequired: true,
/// )
///
/// // Label with help information
/// LabelTextWidget.create(
///   initialData: 'Password Strength',
///   helpIcon: Icons.help_outline,
///   onHelpTap: () => showPasswordHelp(context),
/// )
///
/// // Custom styled section label
/// LabelTextWidget.create(
///   initialData: 'Personal Information',
///   textColor: Theme.of(context).primaryColor,
///   padding: EdgeInsets.only(top: 16, bottom: 8),
/// )
/// ```
///
/// 🎯 **Form Integration:**
/// - Perfect for TextField and form widget labeling
/// - Consistent spacing with Material Design guidelines
/// - Proper semantic association with form controls
/// - Support for validation error styling
class LabelTextWidget extends ReusableTextWidget {
  const LabelTextWidget({
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

  /// 🏭 **Factory constructor with label-specific defaults**
  ///
  /// Creates a LabelTextWidget optimized for form and UI element labeling
  /// with proper typography, spacing, and accessibility features.
  ///
  /// **Parameters:**
  /// - `initialData`: The label text content
  /// - `textColor`: Custom text color (default: black87)
  /// - `isRequired`: Whether to show required field indicator (*)
  /// - `helpIcon`: Optional help icon for additional context
  /// - `onHelpTap`: Callback when help icon is tapped
  /// - `padding`: Custom padding around the label
  ///
  /// **Returns:** Configured LabelTextWidget instance
  factory LabelTextWidget.create({
    Key? key,
    String? initialData,
    Color? textColor,
    bool isRequired = false,
    IconData? helpIcon,
    VoidCallback? onHelpTap,
    String? widgetId,
    EdgeInsets? padding,
  }) {
    return LabelTextWidget(
      key: key,
      config: CoreWidgetConfig(
        initialData: initialData,
        padding: padding ?? const EdgeInsets.only(bottom: 4),
        debugLabel: 'LabelTextWidget',
      ),
      textConfig: TextWidgetConfig(
        textStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: textColor ?? Colors.black87,
        ),
        suffix: isRequired ? ' *' : null,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      iconConfig: helpIcon != null
          ? IconWidgetConfig(
              trailingIcon: helpIcon,
              iconColor: Colors.grey[600],
              iconSize: 16,
              onTrailingIconTap: onHelpTap,
            )
          : const IconWidgetConfig(),
      widgetId: widgetId ?? 'LabelTextWidget',
    );
  }
}

/// 📋 **IMPORTANT USAGE REQUIREMENTS & BEST PRACTICES**
///
/// ⚠️ **Critical Guidelines:**
///
/// 1. **🏷️ Label Association:**
///    - Always associate labels with their corresponding form controls
///    - Use consistent labeling patterns throughout the application
///    - Ensure labels clearly describe the expected input or content
///    - Position labels appropriately relative to their controls
///
/// 2. **⭐ Required Field Indicators:**
///    - Use asterisk (*) consistently for required fields
///    - Place required indicators after the label text
///    - Consider color coding (red) for required field asterisks
///    - Provide legend or explanation for required field notation
///
/// 3. **♿ Accessibility Compliance:**
///    - Ensure labels are readable by screen readers
///    - Maintain sufficient color contrast for all text
///    - Support keyboard navigation for help interactions
///    - Provide alternative text for icon-based help elements
///
/// 4. **🎨 Visual Consistency:**
///    - Maintain consistent font weight (medium/500) across labels
///    - Use consistent color scheme for different label types
///    - Align labels properly with form controls and content
///    - Apply consistent spacing between labels and inputs
///
/// 5. **❓ Help Integration:**
///    - Provide contextual help for complex or unclear fields
///    - Use consistent help icon styles throughout the app
///    - Implement accessible help dialogs or tooltips
///    - Consider inline help text for critical information
///
/// 6. **📱 Responsive Design:**
///    - Ensure labels remain readable on small screens
///    - Test label wrapping behavior with long text
///    - Maintain proper touch targets for help icons
///    - Consider label placement in different orientations
///
/// 7. **🔤 Typography Guidelines:**
///    - Keep labels concise but descriptive
///    - Use sentence case for better readability
///    - Avoid technical jargon in user-facing labels
///    - Consider localization requirements for label length
///
/// 8. **🌍 Internationalization:**
///    - Plan for varying text lengths in different languages
///    - Support right-to-left reading directions
///    - Consider cultural differences in form labeling
///    - Test label layout with translated content
///
/// 9. **🔄 Dynamic Labeling:**
///    - Support dynamic label updates when needed
///    - Handle label changes during form state updates
///    - Maintain label association during dynamic updates
///    - Consider animation for label state changes
///
/// 10. **⚡ Performance Optimization:**
///     - Optimize for forms with many labels
///     - Use efficient rendering for repeated label patterns
///     - Consider label caching for dynamic content
///     - Monitor performance with complex form layouts
///
/// 💡 **Pro Tips:**
/// - Use consistent label styles to create visual hierarchy
/// - Implement smart defaults for common form patterns
/// - Add micro-animations for better user feedback
/// - Consider voice input integration for accessibility
/// - Use analytics to identify problematic or confusing labels
