import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../config/core_widget_config.dart';
import '../gestures/core_widget_gestures.dart';
import '../logging/core_widget_logger.dart';
import '../styling/core_widget_styling.dart';
import '../core_widget_bloc.dart';

/// 🏗️ Enhanced abstract CoreWidget with improved architecture and debugging
/// 
/// Base class for all core widgets providing:
/// - 🔄 State management with BLoC pattern
/// - 🎨 Consistent styling and theming
/// - 👆 Comprehensive gesture support
/// - 📊 Performance monitoring
/// - 🔧 Debug logging and diagnostics
/// - 🔄 Animation support
/// 
/// **Basic Usage Example:**
/// ```dart
/// class MyWidget extends CoreWidget {
///   const MyWidget({
///     Key? key,
///     required CoreWidgetConfig config,
///   }) : super(key: key, config: config);
/// 
///   @override
///   Widget buildContent(BuildContext context, CoreWidgetState state) {
///     if (state is CoreWidgetLoaded) {
///       return Text(state.data);
///     }
///     return Text('No data');
///   }
/// }
/// ```
abstract class CoreWidget extends StatelessWidget 
    with CoreWidgetStyling, CoreWidgetGestures {
  
  /// ⚙️ Widget configuration containing styling and behavior settings
  final CoreWidgetConfig config;
  
  /// 👆 Gesture configuration for touch interactions
  final CoreWidgetGestureConfig gestureConfig;
  
  /// 🆔 Widget identifier for debugging and monitoring
  final String? widgetId;
  
  /// ⏱️ Performance monitoring stopwatch collection
  static final Map<String, Stopwatch> _performanceTimers = {};
  
  const CoreWidget({
    Key? key,
    required this.config,
    this.gestureConfig = const CoreWidgetGestureConfig(),
    this.widgetId,
    
    // 🔄 Backward compatibility - deprecated parameters
    @Deprecated('Use config.initialData instead') String? initialData,
    @Deprecated('Use config.padding instead') EdgeInsets? padding,
    @Deprecated('Use config.backgroundColor instead') Color? backgroundColor,
    @Deprecated('Use config.borderRadius instead') BorderRadius? borderRadius,
    @Deprecated('Use config.shadow instead') BoxShadow? shadow,
    @Deprecated('Use gestureConfig.onTap instead') VoidCallback? onTap,
    @Deprecated('Use gestureConfig.onLongPress instead') VoidCallback? onLongPress,
  }) : super(key: key);
  
  /// 🔄 Convenience constructor for backward compatibility
  const CoreWidget.legacy({
    Key? key,
    String? initialData,
    EdgeInsets? padding,
    Color? backgroundColor,
    BorderRadius? borderRadius,
    BoxShadow? shadow,
    VoidCallback? onTap,
    VoidCallback? onLongPress,
    String? debugLabel,
  }) : config = const CoreWidgetConfig(),
       gestureConfig = const CoreWidgetGestureConfig(),
       widgetId = debugLabel,
       super(key: key);
  
  /// 🏗️ Abstract method that child widgets must implement
  Widget buildContent(BuildContext context, CoreWidgetState state);
  
  /// ❌ Optional method for custom error widget
  Widget buildError(BuildContext context, String error) {
    return Container(
      padding: getResolvedPadding(config.padding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error, color: Theme.of(context).colorScheme.error),
          const SizedBox(height: 8),
          Text(
            'Error: $error',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.error,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
  
  /// ⏳ Optional method for custom loading widget
  Widget buildLoading(BuildContext context) {
    return Container(
      padding: getResolvedPadding(config.padding),
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
  
  /// 📦 Enhanced container builder with animation support
  Widget buildContainer(BuildContext context, Widget child) {
    final stopwatch = _startPerformanceTimer('buildContainer');
    
    try {
      final resolvedBackgroundColor = config.backgroundColor ?? 
          Theme.of(context).cardColor;
      
      CoreWidgetLogger.debug(
        'Building container for ${_getWidgetName()}',
        {
          'backgroundColor': resolvedBackgroundColor.toString(),
          'padding': getResolvedPadding(config.padding).toString(),
          'borderRadius': getResolvedBorderRadius(config.borderRadius).toString(),
        },
      );
      
      final container = Container(
        padding: getResolvedPadding(config.padding),
        decoration: BoxDecoration(
          color: resolvedBackgroundColor,
          borderRadius: getResolvedBorderRadius(config.borderRadius),
          boxShadow: getResolvedShadow(config.shadow),
        ),
        child: child,
      );
      
      // 🎬 Add animation if duration is specified
      if (config.animationDuration != null) {
        return AnimatedContainer(
          duration: config.animationDuration!,
          curve: config.animationCurve ?? Curves.easeInOut,
          padding: getResolvedPadding(config.padding),
          decoration: BoxDecoration(
            color: resolvedBackgroundColor,
            borderRadius: getResolvedBorderRadius(config.borderRadius),
            boxShadow: getResolvedShadow(config.shadow),
          ),
          child: child,
        );
      }
      
      return container;
    } finally {
      _stopPerformanceTimer('buildContainer', stopwatch);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final stopwatch = _startPerformanceTimer('build');
    
    CoreWidgetLogger.lifecycle(_getWidgetName(), 'build', {
      'hasInitialData': config.initialData != null,
      'hasGestures': gestureConfig.hasGestures,
      'widgetId': widgetId,
    });
    
    try {
      return BlocProvider(
        create: (context) {
          CoreWidgetLogger.debug('Creating BLoC for ${_getWidgetName()}');
          return CoreWidgetBloc()..add(LoadData(data: config.initialData));
        },
        child: BlocBuilder<CoreWidgetBloc, CoreWidgetState>(
          builder: (context, state) {
            CoreWidgetLogger.debug(
              'Building ${_getWidgetName()} with state: ${state.runtimeType}',
            );
            
            Widget content;
            
            // 🛡️ Handle different states with proper error handling
            try {
              if (state is CoreWidgetLoading) {
                content = buildLoading(context);
              } else if (state is CoreWidgetError) {
                content = buildError(context, state.message);
              } else {
                content = buildContent(context, state);
              }
            } catch (error, stackTrace) {
              CoreWidgetLogger.debug(
                'Error building content for ${_getWidgetName()}',
                error,
                stackTrace,
              );
              content = buildError(context, error.toString());
            }
            
            final container = buildContainer(context, content);
            
            return buildGestureWrapper(
              child: container,
              onTap: gestureConfig.onTap,
              onLongPress: gestureConfig.onLongPress,
              onDoubleTap: gestureConfig.onDoubleTap,
              onTapDown: gestureConfig.onTapDown,
              onTapUp: gestureConfig.onTapUp,
              debugLabel: _getWidgetName(),
            );
          },
        ),
      );
    } finally {
      _stopPerformanceTimer('build', stopwatch);
    }
  }
  
  // ...existing utility methods...
  
  /// 📝 Update widget data with optional validation
  static void updateData(
    BuildContext context, 
    String data, {
    bool validate = true,
    String? widgetId,
  }) {
    try {
      CoreWidgetLogger.debug(
        'Updating data${widgetId != null ? ' for $widgetId' : ''}',
        {'data': data, 'validate': validate},
      );
      
      if (validate && data.isEmpty) {
        CoreWidgetLogger.debug('Validation failed: empty data');
        return;
      }
      
      context.read<CoreWidgetBloc>().add(UpdateData(data));
    } catch (error, stackTrace) {
      CoreWidgetLogger.debug('Error updating data', error, stackTrace);
    }
  }
  
  /// 🔄 Reset widget data to initial state
  static void resetData(BuildContext context, {String? widgetId}) {
    try {
      CoreWidgetLogger.debug(
        'Resetting data${widgetId != null ? ' for $widgetId' : ''}',
      );
      context.read<CoreWidgetBloc>().add(ResetData());
    } catch (error, stackTrace) {
      CoreWidgetLogger.debug('Error resetting data', error, stackTrace);
    }
  }
  
  /// 🔃 Reload widget data with new data
  static void reloadData(
    BuildContext context, {
    String? newData,
    String? widgetId,
    bool forceReload = false,
  }) {
    try {
      CoreWidgetLogger.debug(
        'Reloading data${widgetId != null ? ' for $widgetId' : ''}',
        {'newData': newData, 'forceReload': forceReload},
      );
      context.read<CoreWidgetBloc>().add(LoadData(data: newData));
    } catch (error, stackTrace) {
      CoreWidgetLogger.debug('Error reloading data', error, stackTrace);
    }
  }
  
  /// 📊 Get current widget state
  static CoreWidgetState? getCurrentState(BuildContext context) {
    try {
      return context.read<CoreWidgetBloc>().state;
    } catch (error) {
      CoreWidgetLogger.debug('Error getting current state', error);
      return null;
    }
  }
  
  /// ✅ Check if widget has data
  static bool hasData(BuildContext context) {
    final state = getCurrentState(context);
    return state is CoreWidgetLoaded && state.data.isNotEmpty;
  }
  
  // ...existing performance monitoring methods...
  
  /// ⏱️ Start performance timer for operation tracking
  static Stopwatch _startPerformanceTimer(String operation) {
    final stopwatch = Stopwatch()..start();
    _performanceTimers[operation] = stopwatch;
    return stopwatch;
  }
  
  /// ⏹️ Stop performance timer and log results
  static void _stopPerformanceTimer(String operation, Stopwatch stopwatch) {
    stopwatch.stop();
    CoreWidgetLogger.performance(operation, stopwatch.elapsed);
    _performanceTimers.remove(operation);
  }
  
  /// 🏷️ Get widget name for debugging purposes
  String _getWidgetName() {
    return widgetId ?? config.debugLabel ?? runtimeType.toString();
  }
  
  /// 🧹 Static method to clear all performance timers
  static void clearPerformanceTimers() {
    _performanceTimers.clear();
  }
  
  /// 📈 Get performance statistics
  static Map<String, Duration> getPerformanceStats() {
    final stats = <String, Duration>{};
    for (final entry in _performanceTimers.entries) {
      stats[entry.key] = entry.value.elapsed;
    }
    return stats;
  }
}
