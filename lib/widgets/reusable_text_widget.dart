import 'package:core_widgets_pattern/core/core_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Configuration class for text-specific styling and behavior
class TextWidgetConfig {
  final TextStyle? textStyle;
  final TextAlign textAlign;
  final int? maxLines;
  final TextOverflow overflow;
  final bool showTimestamp;
  final String? prefix;
  final String? suffix;
  final String? placeholder;
  final bool enableEdit;
  final bool enableCopy;
  final bool enableSelection;
  final String? validationPattern;
  final int? minLength;
  final int? maxLength;

  const TextWidgetConfig({
    this.textStyle,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow = TextOverflow.ellipsis,
    this.showTimestamp = false,
    this.prefix,
    this.suffix,
    this.placeholder,
    this.enableEdit = false,
    this.enableCopy = false,
    this.enableSelection = false,
    this.validationPattern,
    this.minLength,
    this.maxLength,
  });

  /// Create a copy with updated values
  TextWidgetConfig copyWith({
    TextStyle? textStyle,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    bool? showTimestamp,
    String? prefix,
    String? suffix,
    String? placeholder,
    bool? enableEdit,
    bool? enableCopy,
    bool? enableSelection,
    String? validationPattern,
    int? minLength,
    int? maxLength,
  }) {
    return TextWidgetConfig(
      textStyle: textStyle ?? this.textStyle,
      textAlign: textAlign ?? this.textAlign,
      maxLines: maxLines ?? this.maxLines,
      overflow: overflow ?? this.overflow,
      showTimestamp: showTimestamp ?? this.showTimestamp,
      prefix: prefix ?? this.prefix,
      suffix: suffix ?? this.suffix,
      placeholder: placeholder ?? this.placeholder,
      enableEdit: enableEdit ?? this.enableEdit,
      enableCopy: enableCopy ?? this.enableCopy,
      enableSelection: enableSelection ?? this.enableSelection,
      validationPattern: validationPattern ?? this.validationPattern,
      minLength: minLength ?? this.minLength,
      maxLength: maxLength ?? this.maxLength,
    );
  }
}

/// Configuration for icon styling and positioning
class IconWidgetConfig {
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final Color? iconColor;
  final double? iconSize;
  final EdgeInsets? iconPadding;
  final VoidCallback? onLeadingIconTap;
  final VoidCallback? onTrailingIconTap;

  const IconWidgetConfig({
    this.leadingIcon,
    this.trailingIcon,
    this.iconColor,
    this.iconSize,
    this.iconPadding,
    this.onLeadingIconTap,
    this.onTrailingIconTap,
  });

  /// Check if any icon is configured
  bool get hasIcons => leadingIcon != null || trailingIcon != null;

  /// Create a copy with updated values
  IconWidgetConfig copyWith({
    IconData? leadingIcon,
    IconData? trailingIcon,
    Color? iconColor,
    double? iconSize,
    EdgeInsets? iconPadding,
    VoidCallback? onLeadingIconTap,
    VoidCallback? onTrailingIconTap,
  }) {
    return IconWidgetConfig(
      leadingIcon: leadingIcon ?? this.leadingIcon,
      trailingIcon: trailingIcon ?? this.trailingIcon,
      iconColor: iconColor ?? this.iconColor,
      iconSize: iconSize ?? this.iconSize,
      iconPadding: iconPadding ?? this.iconPadding,
      onLeadingIconTap: onLeadingIconTap ?? this.onLeadingIconTap,
      onTrailingIconTap: onTrailingIconTap ?? this.onTrailingIconTap,
    );
  }
}

/// Mixin for text validation and formatting
mixin TextValidationMixin {
  /// Validate text input based on configuration
  static String? validateText(String text, TextWidgetConfig config) {
    CoreWidgetLogger.debug('Validating text input', {'text': text, 'length': text.length});

    // Length validation
    if (config.minLength != null && text.length < config.minLength!) {
      return 'Text must be at least ${config.minLength} characters';
    }

    if (config.maxLength != null && text.length > config.maxLength!) {
      return 'Text must not exceed ${config.maxLength} characters';
    }

    // Pattern validation
    if (config.validationPattern != null) {
      final regex = RegExp(config.validationPattern!);
      if (!regex.hasMatch(text)) {
        return 'Text does not match required pattern';
      }
    }

    return null;
  }

  /// Format text for display
  static String formatDisplayText(String data, TextWidgetConfig config) {
    final prefix = config.prefix ?? '';
    final suffix = config.suffix ?? '';
    return '$prefix$data$suffix';
  }

  /// Format timestamp for display
  static String formatTimestamp(DateTime timestamp) {
    return '${timestamp.hour.toString().padLeft(2, '0')}:'
        '${timestamp.minute.toString().padLeft(2, '0')}:'
        '${timestamp.second.toString().padLeft(2, '0')}';
  }
}

/// Enhanced ReusableTextWidget with improved architecture
class ReusableTextWidget extends CoreWidget with TextValidationMixin {
  /// Text-specific configuration
  final TextWidgetConfig textConfig;

  /// Icon configuration
  final IconWidgetConfig iconConfig;

  /// Enhanced constructor using configuration classes
  const ReusableTextWidget({
    Key? key,
    required CoreWidgetConfig config,
    CoreWidgetGestureConfig gestureConfig = const CoreWidgetGestureConfig(),
    String? widgetId,
    this.textConfig = const TextWidgetConfig(),
    this.iconConfig = const IconWidgetConfig(),
  }) : super(
         key: key,
         config: config,
         gestureConfig: gestureConfig,
         widgetId: widgetId,
       );

  /// Legacy constructor for backward compatibility
  ReusableTextWidget.legacy({
    Key? key,
    String? initialData,
    EdgeInsets? padding,
    Color? backgroundColor,
    BorderRadius? borderRadius,
    BoxShadow? shadow,
    VoidCallback? onTap,
    VoidCallback? onLongPress,
    TextStyle? textStyle,
    TextAlign textAlign = TextAlign.start,
    int? maxLines,
    TextOverflow overflow = TextOverflow.ellipsis,
    bool showTimestamp = false,
    String? prefix,
    String? suffix,
    IconData? leadingIcon,
    IconData? trailingIcon,
    Color? iconColor,
    double? iconSize,
    bool enableEdit = false,
    String? placeholder,
  }) : textConfig = TextWidgetConfig(
         textStyle: textStyle,
         textAlign: textAlign,
         maxLines: maxLines,
         overflow: overflow,
         showTimestamp: showTimestamp,
         prefix: prefix,
         suffix: suffix,
         placeholder: placeholder,
         enableEdit: enableEdit,
       ),
       iconConfig = IconWidgetConfig(
         leadingIcon: leadingIcon,
         trailingIcon: trailingIcon,
         iconColor: iconColor,
         iconSize: iconSize,
       ),
       super(
         key: key,
         config: CoreWidgetConfig(
           initialData: initialData,
           padding: padding,
           backgroundColor: backgroundColor,
           borderRadius: borderRadius,
           shadow: shadow,
           debugLabel: 'ReusableTextWidget',
         ),
         gestureConfig: CoreWidgetGestureConfig(
           onTap: onTap,
           onLongPress: onLongPress,
         ),
         widgetId: 'ReusableTextWidget',
       );

  @override
  Widget buildContent(BuildContext context, CoreWidgetState state) {
    CoreWidgetLogger.lifecycle('ReusableTextWidget', 'buildContent', {
      'state': state.runtimeType.toString(),
      'hasTimestamp': textConfig.showTimestamp,
      'enableEdit': textConfig.enableEdit,
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildMainContent(context, state),
        if (textConfig.showTimestamp && state is CoreWidgetLoaded && state.timestamp != null)
          _buildTimestamp(context, state.timestamp!),
      ],
    );
  }

  /// Build the main content with icons and text
  Widget _buildMainContent(BuildContext context, CoreWidgetState state) {
    final children = <Widget>[];

    // Leading icon
    if (iconConfig.leadingIcon != null) {
      children.addAll([
        _buildIcon(
          context,
          iconConfig.leadingIcon!,
          iconConfig.onLeadingIconTap,
          'leading',
        ),
        SizedBox(width: iconConfig.iconPadding?.left ?? 8),
      ]);
    }

    // Main text content
    children.add(Expanded(child: _buildTextContent(context, state)));

    // Trailing icon
    if (iconConfig.trailingIcon != null) {
      children.addAll([
        SizedBox(width: iconConfig.iconPadding?.right ?? 8),
        _buildIcon(
          context,
          iconConfig.trailingIcon!,
          iconConfig.onTrailingIconTap,
          'trailing',
        ),
      ]);
    }

    // Edit button
    if (textConfig.enableEdit) {
      children.addAll([
        const SizedBox(width: 8),
        _buildEditButton(context, state),
      ]);
    }

    // Copy button
    if (textConfig.enableCopy) {
      children.addAll([
        const SizedBox(width: 8),
        _buildCopyButton(context, state),
      ]);
    }

    return Row(children: children);
  }

  /// Build icon with tap handling
  Widget _buildIcon(BuildContext context, IconData iconData, VoidCallback? onTap, String position) {
    final icon = Icon(
      iconData,
      color: iconConfig.iconColor ?? Theme.of(context).iconTheme.color,
      size: iconConfig.iconSize ?? 20,
    );

    if (onTap != null) {
      return GestureDetector(
        onTap: () {
          CoreWidgetLogger.debug('$position icon tapped');
          onTap();
        },
        child: icon,
      );
    }

    return icon;
  }

  /// Build text content based on state
  Widget _buildTextContent(BuildContext context, CoreWidgetState state) {
    CoreWidgetLogger.debug('Building text content for state: ${state.runtimeType}');

    try {
      switch (state.runtimeType) {
        case CoreWidgetLoading:
          return _buildLoadingIndicator();
        case CoreWidgetLoaded:
          final loadedState = state as CoreWidgetLoaded;
          return _buildLoadedText(context, loadedState.data);
        case CoreWidgetError:
          final errorState = state as CoreWidgetError;
          return _buildErrorText(context, errorState.message);
        default:
          return _buildPlaceholderText(context);
      }
    } catch (error, stackTrace) {
      CoreWidgetLogger.debug('Error building text content', error, stackTrace);
      return _buildErrorText(context, 'Failed to build content');
    }
  }

  /// Build loaded text with proper formatting
  Widget _buildLoadedText(BuildContext context, String data) {
    final displayText = TextValidationMixin.formatDisplayText(data, textConfig);

    Widget textWidget = Text(
      displayText,
      style: textConfig.textStyle ?? Theme.of(context).textTheme.bodyMedium,
      textAlign: textConfig.textAlign,
      maxLines: textConfig.maxLines,
      overflow: textConfig.overflow,
    );

    // Add selection capability if enabled
    if (textConfig.enableSelection) {
      textWidget = SelectableText(
        displayText,
        style: textConfig.textStyle ?? Theme.of(context).textTheme.bodyMedium,
        textAlign: textConfig.textAlign,
        maxLines: textConfig.maxLines,
      );
    }

    return textWidget;
  }

  /// Build loading indicator with consistent styling
  Widget _buildLoadingIndicator() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 16,
          height: 16,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(
              iconConfig.iconColor ?? Colors.blue,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          'Loading...',
          style: textConfig.textStyle?.copyWith(fontStyle: FontStyle.italic) ??
              TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.grey[600],
              ),
        ),
      ],
    );
  }

  /// Build error text with consistent styling
  Widget _buildErrorText(BuildContext context, String message) {
    return Text(
      'Error: $message',
      style: textConfig.textStyle?.copyWith(color: Colors.red) ??
          TextStyle(
            color: Colors.red,
            fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize,
          ),
      textAlign: textConfig.textAlign,
      maxLines: textConfig.maxLines,
      overflow: textConfig.overflow,
    );
  }

  /// Build placeholder text
  Widget _buildPlaceholderText(BuildContext context) {
    return Text(
      textConfig.placeholder ?? 'No data available',
      style: textConfig.textStyle?.copyWith(
            fontStyle: FontStyle.italic,
            color: Colors.grey[600],
          ) ??
          TextStyle(
            fontStyle: FontStyle.italic,
            color: Colors.grey[600],
            fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize,
          ),
      textAlign: textConfig.textAlign,
      maxLines: textConfig.maxLines,
      overflow: textConfig.overflow,
    );
  }

  /// Build timestamp display
  Widget _buildTimestamp(BuildContext context, DateTime timestamp) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Text(
        'Updated: ${TextValidationMixin.formatTimestamp(timestamp)}',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.grey[600],
            ),
      ),
    );
  }

  /// Build edit button with enhanced functionality
  Widget _buildEditButton(BuildContext context, CoreWidgetState state) {
    return IconButton(
      onPressed: () => _showEditDialog(context, state),
      icon: Icon(
        Icons.edit,
        size: iconConfig.iconSize ?? 16,
        color: iconConfig.iconColor ?? Theme.of(context).iconTheme.color,
      ),
      constraints: const BoxConstraints(
        minWidth: 24,
        minHeight: 24,
      ),
      padding: EdgeInsets.zero,
      tooltip: 'Edit text',
    );
  }

  /// Build copy button
  Widget _buildCopyButton(BuildContext context, CoreWidgetState state) {
    return IconButton(
      onPressed: () => _copyToClipboard(context, state),
      icon: Icon(
        Icons.copy,
        size: iconConfig.iconSize ?? 16,
        color: iconConfig.iconColor ?? Theme.of(context).iconTheme.color,
      ),
      constraints: const BoxConstraints(
        minWidth: 24,
        minHeight: 24,
      ),
      padding: EdgeInsets.zero,
      tooltip: 'Copy text',
    );
  }

  /// Enhanced edit dialog with validation
  void _showEditDialog(BuildContext context, CoreWidgetState state) {
    final currentData = state is CoreWidgetLoaded ? state.data : '';
    final controller = TextEditingController(text: currentData);
    String? errorMessage;

    CoreWidgetLogger.debug('Opening edit dialog', {'currentData': currentData});

    showDialog(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Edit Text'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  labelText: 'Enter new text',
                  border: const OutlineInputBorder(),
                  errorText: errorMessage,
                  counterText: textConfig.maxLength != null
                      ? '${controller.text.length}/${textConfig.maxLength}'
                      : null,
                ),
                maxLines: textConfig.maxLines ?? 1,
                maxLength: textConfig.maxLength,
                onChanged: (value) {
                  final validation = TextValidationMixin.validateText(value, textConfig);
                  setState(() {
                    errorMessage = validation;
                  });
                },
              ),
              if (textConfig.validationPattern != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    'Pattern: ${textConfig.validationPattern}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                CoreWidgetLogger.debug('Edit dialog cancelled');
                Navigator.of(dialogContext).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: errorMessage == null
                  ? () {
                      CoreWidgetLogger.debug('Saving edited text', {'newText': controller.text});
                      CoreWidget.updateData(context, controller.text, widgetId: widgetId);
                      Navigator.of(dialogContext).pop();
                    }
                  : null,
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  /// Copy text to clipboard
  void _copyToClipboard(BuildContext context, CoreWidgetState state) {
    if (state is CoreWidgetLoaded) {
      final textToCopy = TextValidationMixin.formatDisplayText(state.data, textConfig);
      Clipboard.setData(ClipboardData(text: textToCopy));

      CoreWidgetLogger.debug('Text copied to clipboard', {'text': textToCopy});

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Text copied to clipboard'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}

/// Extension for fluent API
extension ReusableTextWidgetExtensions on ReusableTextWidget {
  /// Create a copy with updated text configuration
  ReusableTextWidget withTextConfig(TextWidgetConfig newTextConfig) {
    return ReusableTextWidget(
      key: key,
      config: config,
      gestureConfig: gestureConfig,
      widgetId: widgetId,
      textConfig: newTextConfig,
      iconConfig: iconConfig,
    );
  }

  /// Create a copy with updated icon configuration
  ReusableTextWidget withIconConfig(IconWidgetConfig newIconConfig) {
    return ReusableTextWidget(
      key: key,
      config: config,
      gestureConfig: gestureConfig,
      widgetId: widgetId,
      textConfig: textConfig,
      iconConfig: newIconConfig,
    );
  }
}