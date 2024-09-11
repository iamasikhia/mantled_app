import 'package:flutter/services.dart';

/// Removes the first 0 from a phone number textfield.
class RemoveLeadingZeroFormatterInterceptor extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.startsWith('0')) {
      return TextEditingValue(
        text: newValue.text.substring(1),
        selection: newValue.selection.copyWith(
          baseOffset: newValue.selection.baseOffset - 1,
          extentOffset: newValue.selection.extentOffset - 1,
        ),
      );
    }
    return newValue;
  }
}

/// Intercepts and removes a text if it start with a pattern.
class RemovePatternTextInputFormatter extends TextInputFormatter {
  /// Allows to provide list of patterns to remove.
  RemovePatternTextInputFormatter({required this.patterns});

  /// The text pattern to look for.
  final List<String> patterns;
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    for (final pattern in patterns) {
      if (newValue.text.startsWith(pattern)) {
        return TextEditingValue(
          text: newValue.text.substring(pattern.length),
          selection: TextSelection.collapsed(
            offset: newValue.selection.end - pattern.length,
          ),
        );
      }
    }
    return newValue;
  }
}
