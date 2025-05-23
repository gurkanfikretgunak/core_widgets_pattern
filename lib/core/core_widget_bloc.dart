// 🧠 Core Widget BLoC System - Main Export File
// 
// This BLoC provides a centralized state management solution for core widgets
// with comprehensive logging, error handling, and debugging capabilities.
// 
// Features:
// - Async data loading with configurable delays
// - Real-time data updates with timestamps
// - Comprehensive error handling and logging
// - State reset functionality
// - Debug mode for development

// 📬 Event management
export 'events/core_widget_events.dart';

// 🔄 State management
export 'states/core_widget_states.dart';

// 🧠 BLoC implementation
export 'bloc/core_widget_bloc.dart';

// 📝 Logging utilities
export 'utils/core_logger.dart';

// ✅ Data validation
export 'utils/data_validator.dart';