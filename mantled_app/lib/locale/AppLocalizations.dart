import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:nb_utils/nb_utils.dart';
import 'package:mantled_app/locale/LanguageEn.dart';
import 'package:mantled_app/locale/LanguageFr.dart';
import 'package:mantled_app/locale/Languages.dart';

import 'LanguageAr.dart';
import 'LanguageHi.dart';

class AppLocalizations extends LocalizationsDelegate<BaseLanguage> {
  const AppLocalizations();

  @override
  Future<BaseLanguage> load(Locale locale) async {
    switch (locale.languageCode) {
      case 'en':
        return LanguageEn();
      case 'ar':
        return LanguageAr();
      case 'hi':
        return LanguageHi();
      case 'fr':
        return LanguageFr();
      default:
        return LanguageEn();
    }
  }

  @override
  bool isSupported(Locale locale) => LanguageDataModel.languages().contains(locale.languageCode);

  @override
  bool shouldReload(LocalizationsDelegate<BaseLanguage> old) => false;
}
