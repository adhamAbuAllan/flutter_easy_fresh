import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import '../../../../session/new_session.dart';

class LanguageNotifier extends StateNotifier<Locale> {
  LanguageNotifier([Locale? initialLocale])
      : super(initialLocale ?? const Locale('ar', 'US'));

  void changeLanguage(String langCode, BuildContext context) {
    Locale newLocale;
    switch (langCode) {
      case 'en':
        newLocale = const Locale('en', 'US');
        break;
      case 'ar':
        newLocale = const Locale('ar', 'JO');
        break;
      default:
        return;
    }
    state = newLocale;
    Get.updateLocale(newLocale);
    saveLanguage(langCode);
  }

  Future<void> saveLanguage(String langCode) async {
    await NewSession.save('language', langCode);
  }


}
