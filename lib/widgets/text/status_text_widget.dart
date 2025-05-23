import 'package:flutter/material.dart';
import '../../core/core_widget.dart';
import '../reusable_text_widget.dart';

/// 📊 Enum for predefined status types
/// 
/// Provides standardized status indicators with consistent color coding:
/// - ✅ success: Green for completed/successful operations
/// - ⚠️ warning: Orange for cautions and warnings
/// - ❌ error: Red for errors and failures
/// - ℹ️ info: Blue for informational messages
/// - ⏳ pending: Grey for pending/in-progress states
enum StatusType { success, warning, error, info, pending }

/// 🎯 **StatusTextWidget** - Specialized widget for displaying status text with color coding
/// 
/// 📝 **Purpose:**
/// This widget provides a standardized way to display status information with consistent
/// visual indicators including colors, icons, and optional background styling.
/// 
/// 🎨 **Features:**
/// - 🌈 Pre-defined color schemes for different status types
/// - 🔤 Consistent typography and sizing
/// - 🎭 Optional icons and background styling
/// - 📱 Responsive design with proper text overflow handling
/// 
/// 💡 **Usage Examples:**
/// ```dart
/// // Basic success status
/// StatusTextWidget.create(
///   initialData: 'Operation completed successfully',
///   statusType: StatusType.success,
/// )
/// 
/// // Error status with background
/// StatusTextWidget.create(
///   initialData: 'Connection failed',
///   statusType: StatusType.error,
///   showBackground: true,
///   showIcon: true,
/// )
/// 
/// // Custom styled pending status
/// StatusTextWidget.create(
///   initialData: 'Processing payment...',
///   statusType: StatusType.pending,
///   showIcon: false,
///   padding: EdgeInsets.all(16),
/// )
/// ```
/// 
/// ⚡ **Performance Notes:**
/// - Uses efficient static color configurations
/// - Minimal widget rebuilds with proper state management
/// - Optimized for list views and repeated usage
class StatusTextWidget extends ReusableTextWidget {
  const StatusTextWidget({
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

  /// 🏭 **Factory constructor with status-specific defaults**
  /// 
  /// Creates a StatusTextWidget with pre-configured styling based on status type.
  /// 
  /// **Parameters:**
  /// - `statusType`: The type of status to display (affects colors and icons)
  /// - `showIcon`: Whether to display the status icon (default: true)
  /// - `showBackground`: Whether to add colored background (default: false)
  /// - `initialData`: The text content to display
  /// - `padding`: Custom padding (default: 8px horizontal, 4px vertical)
  /// 
  /// **Returns:** Configured StatusTextWidget instance
  factory StatusTextWidget.create({
    Key? key,
    String? initialData,
    StatusType statusType = StatusType.info,
    bool showIcon = true,
    bool showBackground = false,
    String? widgetId,
    EdgeInsets? padding,
  }) {
    final statusConfig = _getStatusConfig(statusType);
    
    return StatusTextWidget(
      key: key,
      config: CoreWidgetConfig(
        initialData: initialData,
        backgroundColor: showBackground ? statusConfig.backgroundColor : null,
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        borderRadius: showBackground ? BorderRadius.circular(4) : null,
        debugLabel: 'StatusTextWidget',
      ),
      textConfig: TextWidgetConfig(
        textStyle: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: statusConfig.textColor,
        ),
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      iconConfig: showIcon
          ? IconWidgetConfig(
              leadingIcon: statusConfig.icon,
              iconColor: statusConfig.iconColor,
              iconSize: 16,
            )
          : const IconWidgetConfig(),
      widgetId: widgetId ?? 'StatusTextWidget',
    );
  }

  /// 🎨 **Get configuration for status type**
  /// 
  /// Returns pre-defined styling configuration based on the status type.
  /// Each status type has carefully chosen colors for accessibility and UX.
  /// 
  /// **Color Guidelines:**
  /// - Success: Green tones for positive feedback
  /// - Warning: Orange tones for caution
  /// - Error: Red tones for urgent attention
  /// - Info: Blue tones for neutral information
  /// - Pending: Grey tones for in-progress states
  static _StatusConfig _getStatusConfig(StatusType type) {
    switch (type) {
      case StatusType.success:
        return _StatusConfig(
          textColor: Colors.green[700]!,
          iconColor: Colors.green[700]!,
          backgroundColor: Colors.green[50]!,
          icon: Icons.check_circle,
        );
      case StatusType.warning:
        return _StatusConfig(
          textColor: Colors.orange[700]!,
          iconColor: Colors.orange[700]!,
          backgroundColor: Colors.orange[50]!,
          icon: Icons.warning,
        );
      case StatusType.error:
        return _StatusConfig(
          textColor: Colors.red[700]!,
          iconColor: Colors.red[700]!,
          backgroundColor: Colors.red[50]!,
          icon: Icons.error,
        );
      case StatusType.info:
        return _StatusConfig(
          textColor: Colors.blue[700]!,
          iconColor: Colors.blue[700]!,
          backgroundColor: Colors.blue[50]!,
          icon: Icons.info,
        );
      case StatusType.pending:
        return _StatusConfig(
          textColor: Colors.grey[700]!,
          iconColor: Colors.grey[700]!,
          backgroundColor: Colors.grey[50]!,
          icon: Icons.schedule,
        );
    }
  }
}

/// 🔧 **Internal configuration class for status styling**
/// 
/// Contains all visual properties for a specific status type.
/// This class ensures consistent styling across all status instances.
class _StatusConfig {
  /// 🎨 Text color for the status message
  final Color textColor;
  
  /// 🎭 Icon color matching the status theme
  final Color iconColor;
  
  /// 🌈 Background color for highlighted display
  final Color backgroundColor;
  
  /// 📍 Icon representing the status type
  final IconData icon;

  const _StatusConfig({
    required this.textColor,
    required this.iconColor,
    required this.backgroundColor,
    required this.icon,
  });
}

/// 📋 **IMPORTANT USAGE REQUIREMENTS & BEST PRACTICES**
/// 
/// ⚠️ **Critical Guidelines:**
/// 
/// 1. **📱 Responsive Design:**
///    - Always test status widgets in different screen sizes
///    - Use `maxLines: 1` with `TextOverflow.ellipsis` for consistent layout
///    - Consider text length when choosing between background styles
/// 
/// 2. **🎨 Color Accessibility:**
///    - Pre-defined colors meet WCAG contrast requirements
///    - Avoid overriding status colors unless absolutely necessary
///    - Test with accessibility tools and high contrast modes
/// 
/// 3. **📊 Status Type Selection:**
///    - Use `success` for completed operations and positive outcomes
///    - Use `warning` for non-critical issues that need attention
///    - Use `error` for failures and critical problems
///    - Use `info` for neutral information and help text
///    - Use `pending` for in-progress operations and loading states
/// 
/// 4. **🎭 Icon Usage:**
///    - Icons are automatically selected based on status type
///    - Disable icons (`showIcon: false`) only when space is extremely limited
///    - Icons improve quick visual recognition and accessibility
/// 
/// 5. **🎪 Background Styling:**
///    - Use `showBackground: true` for emphasis and standalone status indicators
///    - Avoid backgrounds in dense lists to prevent visual clutter
///    - Background adds prominence but requires more space
/// 
/// 6. **⚡ Performance Considerations:**
///    - StatusTextWidget is optimized for list views and repeated usage
///    - Use consistent `widgetId` for proper state management
///    - Avoid frequent status type changes to prevent unnecessary rebuilds
/// 
/// 7. **🔄 State Management:**
///    - Status text content can be updated using CoreWidget.updateData()
///    - Status type changes require widget recreation
///    - Consider using BLoC pattern for complex status flows
/// 
/// 8. **📝 Content Guidelines:**
///    - Keep status messages concise and actionable
///    - Use consistent terminology across the application
///    - Provide clear next steps for error and warning states
///    - Consider internationalization for multi-language support
/// 
/// 💡 **Pro Tips:**
/// - Combine with loading indicators for pending states
/// - Use in conjunction with SnackBars for temporary status updates
/// - Consider adding haptic feedback for error states
/// - Group related status widgets with consistent spacing
