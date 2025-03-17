import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../session/new_session.dart';
import '../methods/language_notifier.dart';
//LanguageNotifier
final languageNotifier = StateNotifierProvider<LanguageNotifier, Locale>(
        (ref) => LanguageNotifier());


// English Size Button
final widthSizeWithActiveEnButtonInSmallScreen = StateProvider<double>((ref) =>
(NewSession
    .get
  ("language", "en") == "en" ? 48 : 50));//English Button width for small
// screen
// size
final widthSizeWithInActiveEnButton = StateProvider<double>((ref) =>  (NewSession
    .get
("language", "en") == "en" ? 62 : 64)); //English Button width for normal
// screen
// size
final heightSizeActiveEnButtonInSmallScreen = StateProvider<double>((ref) =>
(NewSession.get
  ("language", "en") == "en" ? 28 : 30)); // English Button height for small
// screen
// size
final heightSizeInActiveEnButton = StateProvider<double>((ref) =>  (NewSession
    .get
("language", "en") == "en" ? 34 : 36));//English Button height for normal
// screen
// size


/// Arabic Size Button
final widthSizeWithActiveArButtonInSmallScreen = StateProvider<double>((ref) =>
(NewSession
    .get
  ("language", "ar") == "ar" ? 48 : 50));// Arabic Button width for small
// screen
// size
final widthSizeWithInActiveArButton = StateProvider<double>((ref) =>
(NewSession
    .get
("language", "ar") == "ar" ? 62 : 64));// Arabic Button width for normal screen
// size
final heightSizeActiveArButtonInSmallScreen = StateProvider<double>((ref) =>
(NewSession.get
  ("language", "ar") == "ar" ? 28 : 30));// Arabic Button  height for small
// screen
// size
final heightSizeInActiveArButton = StateProvider<double>((ref) =>  (NewSession
    .get
("language", "ar") == "ar" ? 34 : 36));// Arabic Button height for normal
// screen
// size
/*
        width:  getIt<AppDimension>().isSmallScreen(context) ?
            (NewSession.get("language", "ar") != "ar" ?50 : 48 ) : (NewSession
                .get("language", "ar") != "ar"? 64:62),

            height:getIt<AppDimension>().isSmallScreen(context) ?
            (NewSession.get("language", "ar") != "ar" ?30 : 28 ) : (NewSession
                .get("language", "ar") != "ar" ?36:34),
 */
