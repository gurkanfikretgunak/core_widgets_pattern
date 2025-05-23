import 'package:flutter/material.dart';
import '../../core/core_widget.dart';
import '../reusable_text_widget.dart';

/// 💻 **CodeTextWidget** - Specialized widget for displaying code snippets
/// 
/// 📝 **Purpose:**
/// Displays code, technical content, and monospaced text with proper formatting,
/// syntax highlighting support, and developer-friendly features like copy functionality.
/// 
/// 🎨 **Features:**
/// - 🔤 Monospace font for proper code alignment
/// - 📋 Built-in copy-to-clipboard functionality
/// - 🎨 Syntax-friendly background styling
/// - 📱 Horizontal scrolling for long code lines
/// - 🔍 Text selection support for easy copying
/// 
/// 💡 **Usage Examples:**
/// ```dart
/// // Simple code snippet
/// CodeTextWidget.create(
///   initialData: 'print("Hello, World!")',
///   backgroundColor: Colors.grey[100],
/// )
/// 
/// // Multi-line code block
/// CodeTextWidget.create(
///   initialData: '''
/// class Example {
///   void doSomething() {
///     print("Example code");
///   }
/// }''',
///   maxLines: null,
///   enableCopy: true,
/// )
/// 
/// // Terminal output style
/// CodeTextWidget.create(
///   initialData: '$ npm install flutter_widgets',
///   backgroundColor: Colors.black,
///   textColor: Colors.green,
///   enableSelection: true,
/// )
/// ```
/// 
/// ⚡ **Developer Features:**
/// - Quick code copying for documentation
/// - Proper indentation preservation
/// - Line number support (when needed)
/// - Syntax highlighting integration ready
class CodeTextWidget extends ReusableTextWidget {
  const CodeTextWidget({
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

  /// 🏭 **Factory constructor with code-specific defaults**
  /// 
  /// Creates a CodeTextWidget optimized for displaying code content with
  /// developer-friendly features and proper monospace formatting.
  /// 
  /// **Parameters:**
  /// - `initialData`: The code content to display
  /// - `backgroundColor`: Background color for the code block
  /// - `textColor`: Text color for the code content
  /// - `enableCopy`: Show copy button for clipboard functionality
  /// - `enableSelection`: Allow text selection for manual copying
  /// - `maxLines`: Maximum lines to display (null for unlimited)
  /// - `padding`: Custom padding around the code block
  /// 
  /// **Returns:** Configured CodeTextWidget instance
  factory CodeTextWidget.create({
    Key? key,
    String? initialData,
    Color? backgroundColor,
    Color? textColor,
    bool enableCopy = true,
    bool enableSelection = true,
    int? maxLines,
    String? widgetId,
    EdgeInsets? padding,
  }) {
    return CodeTextWidget(
      key: key,
      config: CoreWidgetConfig(
        initialData: initialData,
        backgroundColor: backgroundColor ?? Colors.grey[100],
        padding: padding ?? const EdgeInsets.all(12),
        borderRadius: BorderRadius.circular(4),
        debugLabel: 'CodeTextWidget',
      ),
      textConfig: TextWidgetConfig(
        textStyle: TextStyle(
          fontFamily: 'Courier',
          fontSize: 14,
          color: textColor ?? Colors.black87,
        ),
        maxLines: maxLines,
        overflow: TextOverflow.fade,
        enableCopy: enableCopy,
        enableSelection: enableSelection,
      ),
      iconConfig: enableCopy
          ? const IconWidgetConfig(
              trailingIcon: Icons.content_copy,
              iconSize: 16,
            )
          : const IconWidgetConfig(),
      widgetId: widgetId ?? 'CodeTextWidget',
    );
  }
}

/// 📋 **IMPORTANT USAGE REQUIREMENTS & BEST PRACTICES**
/// 
/// ⚠️ **Critical Guidelines:**
/// 
/// 1. **🔤 Font & Typography:**
///    - Always use monospace fonts (Courier, Monaco, Consolas)
///    - Maintain consistent font size across code blocks
///    - Ensure proper line height for code readability
///    - Test with different code complexity levels
/// 
/// 2. **🎨 Visual Design:**
///    - Use subtle background colors to distinguish code from text
///    - Ensure sufficient contrast between text and background
///    - Add rounded corners for modern appearance
///    - Maintain consistent spacing in code layouts
/// 
/// 3. **📱 Responsive Behavior:**
///    - Handle long code lines with horizontal scrolling
///    - Consider wrapping vs scrolling based on content type
///    - Test on various screen sizes and orientations
///    - Optimize for both mobile and desktop viewing
/// 
/// 4. **💾 Copy Functionality:**
///    - Always provide copy button for code snippets
///    - Include proper user feedback when copying
///    - Handle clipboard permissions appropriately
///    - Consider copying formatted vs plain text
/// 
/// 5. **♿ Accessibility Features:**
///    - Provide proper semantic labeling for screen readers
///    - Ensure keyboard navigation works correctly
///    - Support system font scaling appropriately
///    - Add alternative text descriptions for complex code
/// 
/// 6. **⚡ Performance Optimization:**
///    - Limit maxLines for very long code blocks
///    - Use efficient rendering for syntax highlighting
///    - Implement lazy loading for code documentation
///    - Consider virtual scrolling for massive code files
/// 
/// 7. **🔧 Integration Patterns:**
///    - Combine with syntax highlighting libraries
///    - Integrate with code formatting tools
///    - Support multiple programming languages
///    - Add line numbering for longer snippets
/// 
/// 8. **📚 Content Guidelines:**
///    - Preserve original indentation and formatting
///    - Include relevant context and comments
///    - Keep examples concise and focused
///    - Use proper code examples that actually work
/// 
/// 💡 **Pro Tips:**
/// - Add syntax highlighting with packages like flutter_highlight
/// - Implement code folding for large blocks
/// - Consider adding execution buttons for runnable code
/// - Use consistent theming with your IDE or code editor
/// - Add language labels for multi-language documentation
