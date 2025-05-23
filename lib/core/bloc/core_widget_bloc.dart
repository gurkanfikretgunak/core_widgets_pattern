import 'package:flutter_bloc/flutter_bloc.dart';
import '../events/core_widget_events.dart';
import '../states/core_widget_states.dart';
import '../utils/core_logger.dart';
import '../utils/data_validator.dart';

/// Core Widget BLoC for managing widget state
/// 
/// Provides centralized state management with:
/// - Comprehensive logging and debugging
/// - Error handling and recovery
/// - Performance monitoring
/// - Cache management
class CoreWidgetBloc extends Bloc<CoreWidgetEvent, CoreWidgetState> {
  /// Debug mode flag - enables detailed logging
  final bool debugMode;
  
  /// Logger instance
  late final CoreLogger _logger;
  
  /// Cache for storing previous successful data
  String? _cachedData;
  
  /// Performance metrics
  final Map<String, int> _operationCounts = {
    'load': 0,
    'update': 0,
    'reset': 0,
    'errors': 0,
  };

  CoreWidgetBloc({
    this.debugMode = false,
  }) : super(const CoreWidgetInitial()) {
    _logger = CoreLogger(debugMode: debugMode);
    _logger.logDebug('Initializing CoreWidgetBloc');
    
    // Register event handlers
    on<LoadData>(_onLoadData);
    on<UpdateData>(_onUpdateData);
    on<ResetData>(_onResetData);
    
    _logger.logDebug('CoreWidgetBloc initialized successfully');
  }

  // ==========================================================================
  // EVENT HANDLERS
  // ==========================================================================

  /// Handles data loading events
  /// 
  /// Implements comprehensive error handling, caching, and performance monitoring
  Future<void> _onLoadData(
    LoadData event,
    Emitter<CoreWidgetState> emit,
  ) async {
    final stopwatch = Stopwatch()..start();
    _logger.logInfo('Loading data: ${event.data ?? "default"}');
    
    try {
      // Check if we should use cached data
      if (!event.forceReload && _cachedData != null && event.data == null) {
        _logger.logDebug('Using cached data');
        emit(CoreWidgetLoaded(
          data: _cachedData!,
          metadata: {'source': 'cache', 'cached_at': DateTime.now().toIso8601String()},
          timestamp: DateTime.now(),
        ));
        return;
      }

      // Emit loading state
      emit(CoreWidgetLoading(
        operation: 'Loading data...',
        timestamp: DateTime.now(),
      ));

      // Simulate async operation with realistic delay
      await _simulateAsyncOperation(500);

      // Prepare data
      final data = DataValidator.prepareData(event.data);
      _logger.logDebug('Prepared data: ${data.substring(0, data.length.clamp(0, 50))}...');
      
      // Validate data
      DataValidator.validateData(data);
      _logger.logDebug('Data validation passed');
      
      // Cache the data
      _cachedData = data;
      
      // Emit success state
      emit(CoreWidgetLoaded(
        data: data,
        metadata: _buildMetadata('load', stopwatch),
        timestamp: DateTime.now(),
      ));
      
      _incrementOperationCount('load');
      _logger.logInfo('Data loaded successfully in ${stopwatch.elapsedMilliseconds}ms');
      
    } catch (e, stackTrace) {
      _handleError('Failed to load data', e, stackTrace, emit);
    } finally {
      stopwatch.stop();
    }
  }

  /// Handles data update events
  /// 
  /// Includes data validation and optimistic updates
  Future<void> _onUpdateData(
    UpdateData event,
    Emitter<CoreWidgetState> emit,
  ) async {
    final stopwatch = Stopwatch()..start();
    _logger.logInfo('Updating data: ${event.data.substring(0, 20)}...');
    
    try {
      // Validate data if requested
      if (event.validateData) {
        DataValidator.validateData(event.data);
      }

      // Emit loading state
      emit(CoreWidgetLoading(
        operation: 'Updating data...',
        progress: 0.0,
        timestamp: DateTime.now(),
      ));

      // Simulate async operation with progress updates
      await _simulateAsyncOperationWithProgress(emit, 300);

      // Update cached data
      _cachedData = event.data;
      
      // Emit success state
      emit(CoreWidgetLoaded(
        data: event.data,
        metadata: _buildMetadata('update', stopwatch),
        timestamp: DateTime.now(),
      ));
      
      _incrementOperationCount('update');
      _logger.logInfo('Data updated successfully in ${stopwatch.elapsedMilliseconds}ms');
      
    } catch (e, stackTrace) {
      _handleError('Failed to update data', e, stackTrace, emit);
    } finally {
      stopwatch.stop();
    }
  }

  /// Handles reset events
  /// 
  /// Clears state and optionally clears cache
  void _onResetData(
    ResetData event,
    Emitter<CoreWidgetState> emit,
  ) {
    _logger.logInfo('Resetting data (clearCache: ${event.clearCache})');
    
    try {
      // Clear cache if requested
      if (event.clearCache) {
        _cachedData = null;
        _logger.logDebug('Cache cleared');
      }
      
      // Reset to initial state
      emit(const CoreWidgetInitial());
      
      _incrementOperationCount('reset');
      _logger.logInfo('Data reset successfully');
      
    } catch (e, stackTrace) {
      _handleError('Failed to reset data', e, stackTrace, emit);
    }
  }

  // ==========================================================================
  // HELPER METHODS - Implementing DRY principles
  // ==========================================================================

  /// Simulates async operation with delay
  Future<void> _simulateAsyncOperation(int milliseconds) async {
    _logger.logDebug('Simulating async operation for ${milliseconds}ms');
    await Future.delayed(Duration(milliseconds: milliseconds));
  }

  /// Simulates async operation with progress updates
  Future<void> _simulateAsyncOperationWithProgress(
    Emitter<CoreWidgetState> emit,
    int totalMilliseconds,
  ) async {
    const steps = 5;
    final stepDuration = totalMilliseconds ~/ steps;
    
    for (int i = 1; i <= steps; i++) {
      await Future.delayed(Duration(milliseconds: stepDuration));
      final progress = i / steps;
      
      emit(CoreWidgetLoading(
        operation: 'Updating data...',
        progress: progress,
        timestamp: DateTime.now(),
      ));
      
      _logger.logDebug('Progress: ${(progress * 100).toInt()}%');
    }
  }

  /// Builds metadata for successful operations
  Map<String, dynamic> _buildMetadata(String operation, Stopwatch stopwatch) {
    return {
      'operation': operation,
      'duration_ms': stopwatch.elapsedMilliseconds,
      'operation_count': _operationCounts[operation] ?? 0,
      'timestamp': DateTime.now().toIso8601String(),
      'cache_available': _cachedData != null,
    };
  }

  /// Handles errors consistently with proper logging
  void _handleError(
    String message,
    dynamic error,
    StackTrace stackTrace,
    Emitter<CoreWidgetState> emit,
  ) {
    _incrementOperationCount('errors');
    
    final errorMessage = '$message: ${error.toString()}';
    _logger.logError(errorMessage, error, stackTrace);
    
    emit(CoreWidgetError(
      errorMessage,
      errorCode: error.runtimeType.toString(),
      stackTrace: debugMode ? stackTrace : null,
      timestamp: DateTime.now(),
    ));
  }

  /// Increments operation counters for metrics
  void _incrementOperationCount(String operation) {
    _operationCounts[operation] = (_operationCounts[operation] ?? 0) + 1;
    _logger.logDebug('Operation count for $operation: ${_operationCounts[operation]}');
  }

  // ==========================================================================
  // PUBLIC API - Additional utility methods
  // ==========================================================================

  /// Gets current operation metrics
  Map<String, int> get operationMetrics => Map.unmodifiable(_operationCounts);

  /// Gets cache status
  bool get hasCachedData => _cachedData != null;

  /// Gets cached data (read-only)
  String? get cachedData => _cachedData;

  /// Clears all metrics
  void clearMetrics() {
    _operationCounts.clear();
    _logger.logInfo('Metrics cleared');
  }

  @override
  Future<void> close() {
    _logger.logInfo('Closing CoreWidgetBloc');
    _logger.logDebug('Final metrics: $_operationCounts');
    return super.close();
  }
}
