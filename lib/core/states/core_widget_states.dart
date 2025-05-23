import 'package:equatable/equatable.dart';

/// Base state class for all CoreWidget states
/// 
/// Provides common functionality for state management including
/// timestamps and debugging information
abstract class CoreWidgetState extends Equatable {
  /// Timestamp when this state was created
  final DateTime? timestamp;
  
  const CoreWidgetState({
    this.timestamp,
  });

  @override
  List<Object?> get props => [timestamp];
  
  /// Returns state name for logging purposes
  String get stateName => runtimeType.toString();
  
  /// Returns debug information about the state
  Map<String, dynamic> get debugInfo => {
    'state': stateName,
    'timestamp': timestamp?.toIso8601String() ?? 'null',
    'props': props,
  };
}

/// Initial state when widget is first created
class CoreWidgetInitial extends CoreWidgetState {
  const CoreWidgetInitial();
  
  @override
  List<Object?> get props => [];
}

/// Loading state during async operations
/// 
/// [operation] - Description of current operation
/// [progress] - Optional progress indicator (0.0 - 1.0)
class CoreWidgetLoading extends CoreWidgetState {
  final String operation;
  final double? progress;
  
  CoreWidgetLoading({
    this.operation = 'Loading...',
    this.progress,
    DateTime? timestamp,
  }) : super(timestamp: timestamp ?? DateTime.now());
  
  @override
  List<Object?> get props => [operation, progress, ...super.props];
  
  @override
  Map<String, dynamic> get debugInfo => {
    ...super.debugInfo,
    'operation': operation,
    'progress': progress,
  };
}

/// Success state with loaded data
/// 
/// [data] - The loaded data
/// [metadata] - Additional metadata about the data
class CoreWidgetLoaded extends CoreWidgetState {
  final String data;
  final Map<String, dynamic>? metadata;
  
  CoreWidgetLoaded({
    required this.data,
    this.metadata,
    DateTime? timestamp,
  }) : super(timestamp: timestamp ?? DateTime.now());
  
  @override
  List<Object?> get props => [data, metadata, ...super.props];
  
  @override
  Map<String, dynamic> get debugInfo => {
    ...super.debugInfo,
    'dataLength': data.length,
    'metadata': metadata,
  };
}

/// Error state when operations fail
/// 
/// [message] - User-friendly error message
/// [errorCode] - Machine-readable error code
/// [stackTrace] - Debug stack trace (only in debug mode)
class CoreWidgetError extends CoreWidgetState {
  final String message;
  final String? errorCode;
  final StackTrace? stackTrace;
  
  CoreWidgetError(
    this.message, {
    this.errorCode,
    this.stackTrace,
    DateTime? timestamp,
  }) : super(timestamp: timestamp ?? DateTime.now());
  
  @override
  List<Object?> get props => [message, errorCode, ...super.props];
  
  @override
  Map<String, dynamic> get debugInfo => {
    ...super.debugInfo,
    'message': message,
    'errorCode': errorCode,
    'hasStackTrace': stackTrace != null,
  };
}
