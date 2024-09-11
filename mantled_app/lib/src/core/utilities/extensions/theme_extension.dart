import 'package:flutter/material.dart';
import 'package:mantled_app/src/core/config/global_keys.dart';

/// Extension to provide handy tools to improve code reusability and
/// reduce boiler plate code when designing an app with the [ThemeData]
extension ThemeExtension on Widget {
  static final _context = navigatorKey.currentState!.context;

  /// Method to get the current color scheme.
  ColorScheme get colorScheme => Theme.of(_context).colorScheme;

  /// Method to get the current text theme.

  TextTheme get textTheme => Theme.of(_context).textTheme;

  /// Method to get the current theme data

  ThemeData get themeData => Theme.of(_context);
}
