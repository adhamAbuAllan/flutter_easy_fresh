import 'dart:ui';

import 'package:flutter_easy_fresh/contoller/methods/language_notifier.dart';
import 'package:flutter_easy_fresh/session/new_session.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
final savedLanguage = NewSession.get('language', 'ar');
final initialLocale = (savedLanguage == 'ar')
    ? const Locale('ar', 'JO')
    : const Locale('en', 'US');
final languageProvider = StateNotifierProvider<LanguageNotifier, Locale>(
  (ref) => LanguageNotifier(initialLocale),
);

