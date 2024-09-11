import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mantled_app/src/core/config/global_keys.dart';
import 'package:mantled_app/src/core/constants/styles.dart';

/// This extension has some default properties that are set
/// on most widgets through out the app.
extension WidgetExtensions on Widget {
  /// Default Horizontal Padding used through out the app.
  Padding get defaultAppHorizontalPadding => Padding(
        padding: EdgeInsets.symmetric(horizontal: kWSPadding.horizontal.w),
        child: this,
      );

  /// Default vertical Padding used through out the app.
  Padding get defaultAppVerticalPadding => Padding(
        padding: EdgeInsets.symmetric(horizontal: kWSPadding.vertical.w),
        child: this,
      );

  /// Default main view padding used through out the app.
  ///
  /// Mainly used for main views and subviews
  Padding get defaultMainViewPadding => Padding(
        padding: kWSPadding,
        child: this,
      );

  /// Default app circular border radius.
  Widget get defaultCircularBorderRadius => ClipRRect(
        borderRadius: BorderRadius.circular(kSBorderRadius),
        child: this,
      );

  /// Make the widget clickable.
  /// Provides a callback when the widget is clicked.
  /// And provides a tapColor when clicked.
  Widget touchable(
    VoidCallback onTap, {
    Color? splashColor,
    double? elevation,
  }) =>
      Material(
        color: Colors.transparent,
        elevation: elevation ?? 0,
        child: InkWell(
          splashColor: splashColor,
          onTap: onTap,
          child: this,
        ),
      );

  /// Pops the current view if there is a view beneath.
  Future<void> goBack<T>([T? popValue]) async {
    if (navigatorKey.currentState!.canPop()) {
      navigatorKey.currentState!.pop<T>(popValue);
      return;
    }
    return;
  }
}
