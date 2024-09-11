import 'package:intl/intl.dart';

/// Formats [num] into currency in various ways.
extension NumX on num {
  /// Converts an int or a double to a formated naira String.
  String get toNaira => NumberFormat.currency(
        locale: 'en_US',
        symbol: nairaSymbol,
        decimalDigits: 0,
      ).format(this);

  /// Truncates a [num] after decimal to a specified length.
  num truncateNum(int length) {
    return num.parse(toStringAsFixed(length));
  }

  /// Calculates a given percentage of a specified [num]
  double calculatePercentage(double percentage) {
    return (percentage / 100) * this;
  }

  /// Converts a percentage to a fractional value.
  double get convertPercentToFractionalValue => this / 100;

  /// Converts fractional value to percentage.
  ///
  /// Note: The value must range from 0.00 - 1.00
  double get convertFractionalValueToPercentage => this * 100;
}

/// Naira symbol.
const String nairaSymbol = '₦';

/// THis extension add functionalities on nullable [num] objects.
/// Formats [num?] into currency in various ways.
extension NumNullablex on num? {
  /// Adds funtionality "+" operator to nullable num values to handle null
  /// values correctly.
  /// If both values are null, returns null.
  /// If one value is null and the other is not, returns the non-null value.
  /// If both values are not null, adds them together using the "+" operator.

  num? operator +(num? other) {
    if (this == null && other == null) {
      return null;
    }
    if (this == null) {
      return other;
    }
    if (other == null) {
      return this;
    }
    return this + other;
  }
}
