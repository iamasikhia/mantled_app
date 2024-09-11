import 'package:intl/intl.dart';

/// Date formatter extensions.
extension DateFormatterExtension on DateTime {
  /// Formats a [DateTime] to an abbrevated month and the date.
  ///
  /// see example.
  ///
  /// ```
  ///final formattedDate =  DateTime.now().formatAsMonthAndDate
  ///
  ///print(formattedDate) // Apr 26
  /// ```
  String get formatAsMonthAndDate => DateFormat.MMMd().format(this);

  /// Formats a [DateTime] to an to a formatted 24 hour clock.
  ///
  /// see example.
  ///
  /// ```
  ///final formattedTime =  DateTime.now().formatAs24HourClock
  ///
  ///print(formattedTime) // '13:42 PM'
  /// ```
  String get formatAs24HourClock {
    final hour12Format = DateFormat('hh:mm a').parse(formatAs12HourClock);
    return DateFormat('HH:mm a').format(hour12Format);
  }

  /// Formats a [DateTime] to an to a formatted 12 hour clock.
  ///
  /// see example.
  ///
  /// ```
  ///final formattedTime =  DateTime.now().formatAs12HourClock
  ///
  ///print(formattedTime) // '01:42 PM'
  /// ```
  String get formatAs12HourClock => DateFormat('hh:mm a').format(this);

  /// Formats a [DateTime] to an to a MM/DD/YY format.
  ///
  /// see example.
  ///
  /// ```
  ///final formattedDate =  DateTime.now().formatAsMonthDayYear
  ///
  ///print(formattedDate) // '4/26/2023'
  ///
  /// ```
  String get formatAsMonthDayYear => DateFormat.yMd().format(this);
}
