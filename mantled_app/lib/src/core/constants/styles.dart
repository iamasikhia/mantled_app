import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mantled_app/src/core/constants/dimensions.dart';
import 'package:mantled_app/src/core/utilities/extensions/theme_extension.dart';

/// THis file will contain all constant properties that
/// would be used for styling.
///
/// Here are the naming conventions:
///
/// k- must be present to show that the object is constant.
///
/// the following must be followed to determin if its what kind
///
/// of constant it is.....
///
/// s --- Meaning Style. Note style is basically default numbers.
///
/// ws --- Meaning widget style. Note this is a styling that builds
/// a non primtive object e,g EdgeInsetsGeometry.
///

// ====================== Component value style ===============//

/// Constant border radius value used mostly in the app.
const double kSBorderRadius = Dimensions.medium;

// ====== Component widget style ==============//

/// Constant padding for most views in the app.
EdgeInsetsGeometry get kWSPadding => const EdgeInsets.symmetric(
      horizontal: Dimensions.large - 2,
      vertical: Dimensions.big,
    );

/// Constant border radius for most views in the app.
BorderRadius get kWSBorderRadius => BorderRadius.circular(kSBorderRadius.r);

/// Constant border radius for only the top bottomsheet view.
///
/// [value] provides a value to add to the border radius current specification.
BorderRadius kWSTopBorderRadius([double value = 0]) => BorderRadius.only(
      topLeft: Radius.circular(kSBorderRadius.r + value.r),
      topRight: Radius.circular(kSBorderRadius.r + value.r),
    );

/// Gradient BoxDecoration using theme colors
/// onPrimary,primary,primaryContainer.
BoxDecoration kWSGradientDecoration(
  BuildContext context, {
  BoxShape? shape,
  BoxBorder? border,
  BorderRadius? radius,
}) =>
    BoxDecoration(
      borderRadius: shape != BoxShape.circle ? radius ?? kWSBorderRadius : null,
      shape: shape ?? BoxShape.rectangle,
      border: border,
      gradient: LinearGradient(
        colors: [
          context.widget.colorScheme.onPrimary,
          context.widget.colorScheme.primary,
          context.widget.colorScheme.primaryContainer,
        ],
      ),
    );

/// Default color of app divider color.
Color kSWDividerColor(BuildContext context, {Color? color}) {
  return color?.withOpacity(0.3) ??
      context.widget.colorScheme.onSecondary.withOpacity(0.3);
}
