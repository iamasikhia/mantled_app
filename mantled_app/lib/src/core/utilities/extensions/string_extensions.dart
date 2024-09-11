/// Extension Operations on the [String] object
/// to enhance code reuse.
extension StringFormatExtension on String {
  /// Adds a plus(+) in front of a string.
  String get toCountryCode => '+$this';

  /// This method will return the file extension of the string.
  String? get getFileExtension {
    try {
      return split('.').last;
    } catch (e) {
      return null;
    }
  }

  /// This method will return the name from a File Object.
  String? get getFileName {
    try {
      return split('/').last;
    } catch (e) {
      return null;
    }
  }

  /// The method will remove the file extension from the file name.
  String? get removeFileExtension {
    try {
      return substring(0, lastIndexOf('.'));
    } catch (e) {
      return null;
    }
  }

  /// Captializes the first letter of a string.
  String get capitalizeFirstLetter => this[0].toUpperCase() + substring(1);
}
