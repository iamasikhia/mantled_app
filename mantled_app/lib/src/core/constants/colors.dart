import 'dart:collection';

import 'package:flutter/material.dart';

/// [AppColors] holds all the colors from the product design(FIGMA).
class AppColors {
  AppColors._();

  // ======================primary Colors ================//
  /// Single Primary Color Unit
  static const Color heirLoomPrimaryPurple = Color(0XFF820263);

  /// Single Primary Color Unit
  static const Color heirLoomPrimaryPurple2 = Color(0XFF700be9);

  /// Single Primary color unit
  static const Color heirLoomPrimaryBlue = Color(0XFF084887);

  /// Single Primary Color Unit
  static const Color heirLoomPrimaryViolet = Color(0XFFD90368);

  /// Single Primary Color Unit
  static const Color heirLoomPrimarySweetGreen = Color(0XFF006C67);

  /// Single Primary Color Unit
  static const Color heirLoomPrimarySafetyOrange = Color(0XFFF17105);

  /// Single Primary Color Unit
  static const Color heirLoomPrimaryWhite = Color(0XFFFFFFFF);

  //===================End ======================//

  //================= App Secondary color================================//

  /// Multiple Secondary Color Unit, it has shades from 50 - 400, where the
  ///  main color is the strongest shade
  static const MaterialColor heirLoomSecondary = MaterialColor(0XFF001233, {
    50: Color(0xffF5F5F5),
    100: Color(0XFFEEF2F8),
    200: Color(0XFFD2D7DF),
    300: Color(0XFF979DAC),
    400: Color(0XFF33415C),
  });

  /// Multiple Color Unit tone, it has shades from 50 - 100, where the main
  /// color is the strongest shade
  static const MaterialColor heirLoomTones = MaterialColor(0XFFFFDADC, {
    50: Color(0XFFFFF0FB),
    100: Color(0XFFFDE1EE),
  });

//==============================End========================//

// ================ HeirLoom Accents =====================//
  /// Single Color Unit Accent.
  static const Color heirLoomAccentRed = Color(0XFFDA2C38);

  /// Single Color Unit Accent
  static const Color heirLoomAccentYellow = Color(0XFFFFD166);

  /// Single Color Unit Accent
  static const Color heirLoomSubtleBlue = Color(0XFF0496FF);

  /// Single Color Unit Accent
  static const Color heirLoomGreen = Color(0XFF30CF63);

// ================ END HeirLoom Accents =====================//

  /// List's all the colors in the app. can be used to randomize
  /// a list to use all colors in the app.
  static List<Color> get allColors => UnmodifiableListView([
        heirLoomPrimaryPurple,
        heirLoomPrimaryPurple2,
        heirLoomPrimaryBlue,
        heirLoomPrimaryViolet,
        heirLoomPrimarySweetGreen,
        heirLoomPrimarySafetyOrange,
        heirLoomSecondary,
        heirLoomTones,
        heirLoomAccentRed,
        heirLoomAccentYellow,
        heirLoomSubtleBlue,
        heirLoomGreen,
      ]);
}
