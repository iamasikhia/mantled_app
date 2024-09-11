import 'package:flutter/material.dart';

/// Mini extension to get the device's current screen dimensions
/// via media query.
extension ScreenSizeExtension on BuildContext {
  /// Current screen width.
  double get screenWidth => MediaQuery.of(this).size.width;

  /// Current screen height.
  double get screenHeight => MediaQuery.of(this).size.height;
}
