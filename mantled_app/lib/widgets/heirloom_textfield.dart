// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mantled_app/src/core/constants/styles.dart';
import 'package:mantled_app/src/core/utilities/extensions/theme_extension.dart';

///
class HeirLoomTextField extends StatelessWidget {
  ///
  const HeirLoomTextField({
    super.key,
    this.focusColor,
    this.borderColor,
    this.focusBorderWidth,
    this.textAlignPosition,
    this.borderWidth,
    this.textInputAction,
    this.focusNode,
    this.controller,
    this.onSubmitted,
    this.hintText,
    this.backgroundColor,
    this.validator,
    this.obscureText = false,
    this.suffixIcon,
    this.prefixIcon,
    this.suffixIconColor,
    this.prefixIconColor,
    this.hasBorder = false,
    this.keyboardType,
    this.hintTextStyle,
    this.borderRadius,
    this.tappedColor,
    this.minLines,
    this.maxLines,
    this.maxLength,
    this.autofocus = false,
    this.enabled,
    this.padding,
    this.inputFormatters,
    this.onChanged,
    this.onEditingComplete,
    this.prefix,
  });
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final EdgeInsetsGeometry? padding;
  final TextEditingController? controller;
  final ValueChanged<String>? onSubmitted;
  final String? hintText;
  final Color? backgroundColor;
  final String? Function(String?)? validator;
  final bool obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color? suffixIconColor;
  final Color? prefixIconColor;
  final bool hasBorder;
  final TextInputType? keyboardType;
  final TextStyle? hintTextStyle;
  final BorderRadius? borderRadius;
  final Color? tappedColor;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;
  final bool autofocus;
  final bool? enabled;
  final double? focusBorderWidth;
  final Color? focusColor;
  final double? borderWidth;
  final Color? borderColor;
  final TextAlign? textAlignPosition;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final Widget? prefix;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: inputFormatters,
      enabled: enabled,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      autofocus: autofocus,
      controller: controller,
      validator: validator,
      focusNode: focusNode,
      minLines: minLines,
      maxLines: maxLines,
      onEditingComplete: onEditingComplete,
      maxLength: maxLength,
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
      onSaved: (value) => onSubmitted!(value!),
      obscureText: obscureText,
      cursorColor: colorScheme.surface,
      keyboardType: keyboardType,
      textInputAction: textInputAction ?? TextInputAction.done,
      style: textTheme.bodyMedium!.copyWith(
        color: colorScheme.surface,
      ),
      textAlign: textAlignPosition ?? TextAlign.left,
      decoration: InputDecoration(
        prefix: prefix,
        filled: true,
        contentPadding:
            padding ?? EdgeInsets.symmetric(horizontal: 12.w, vertical: 25.h),
        fillColor: backgroundColor ?? colorScheme.background,
        suffixIcon: suffixIcon,
        suffixIconColor: suffixIconColor ?? colorScheme.surface,
        prefixIcon: prefixIcon,
        prefixIconColor: prefixIconColor ?? colorScheme.primary,
        labelText: hintText,
        labelStyle: textTheme.bodyLarge?.copyWith(
          color: colorScheme.onSecondary,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(kSBorderRadius.r),
          borderSide: BorderSide(
            width: hasBorder ? focusBorderWidth ?? 2 : 0.00,
            color: focusColor ?? colorScheme.onSurfaceVariant,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(kSBorderRadius.r),
          borderSide: BorderSide(
            width: hasBorder ? focusBorderWidth ?? 1 : 0.00,
            color: colorScheme.surface,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(kSBorderRadius.r),
          borderSide: BorderSide(
            width: hasBorder ? focusBorderWidth ?? 1 : 0.00,
            color: colorScheme.error,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(kSBorderRadius.r),
          borderSide: BorderSide(
            width: hasBorder ? focusBorderWidth ?? 1 : 0.00,
            color: colorScheme.error,
          ),
        ),
        errorStyle: textTheme.bodyLarge?.copyWith(
          color: Colors.red,
        ),
        border: OutlineInputBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(kSBorderRadius.r),
          borderSide: BorderSide(
            width: hasBorder ? borderWidth ?? 2 : 0.0,
            color: borderColor ?? colorScheme.surface,
          ),
        ),
      ),
    );
  }
}
