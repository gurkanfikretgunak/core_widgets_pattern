/// Data validation utilities for Core Widget
class DataValidator {
  /// Validates data integrity
  static void validateData(String data) {
    if (data.isEmpty) {
      throw ArgumentError('Data cannot be empty');
    }
    if (data.length > 10000) {
      throw ArgumentError('Data too long (max 10000 characters)');
    }
  }

  /// Prepares data with default fallback
  static String prepareData(String? inputData) {
    const defaultData = 'Default Core Widget Data';
    return inputData?.trim().isEmpty == true ? defaultData : (inputData ?? defaultData);
  }
}
