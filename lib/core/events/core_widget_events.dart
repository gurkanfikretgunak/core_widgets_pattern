import 'package:equatable/equatable.dart';

/// Base event class for all CoreWidget events
/// 
/// All events extend this class to maintain consistency and enable
/// common functionality like logging and debugging
abstract class CoreWidgetEvent extends Equatable {
  const CoreWidgetEvent();

  @override
  List<Object?> get props => [];
  
  /// Returns event name for logging purposes
  String get eventName => runtimeType.toString();
}

/// Event to load initial or new data into the widget
/// 
/// [data] - Optional data to load. If null, default data will be used
/// [forceReload] - Whether to force reload even if data exists
class LoadData extends CoreWidgetEvent {
  final String? data;
  final bool forceReload;
  
  const LoadData({
    this.data,
    this.forceReload = false,
  });
  
  @override
  List<Object?> get props => [data, forceReload];
}

/// Event to update existing data
/// 
/// [data] - New data to update
/// [validateData] - Whether to validate data before updating
class UpdateData extends CoreWidgetEvent {
  final String data;
  final bool validateData;
  
  const UpdateData(
    this.data, {
    this.validateData = true,
  });
  
  @override
  List<Object?> get props => [data, validateData];
}

/// Event to reset widget to initial state
/// 
/// [clearCache] - Whether to clear cached data as well
class ResetData extends CoreWidgetEvent {
  final bool clearCache;
  
  const ResetData({this.clearCache = false});
  
  @override
  List<Object?> get props => [clearCache];
}
