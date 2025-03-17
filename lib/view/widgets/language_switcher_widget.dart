import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../session/new_session.dart';
import '../../const/coordination.dart';
import '../../const/get_it_controller.dart';
import '../../const/localization.dart';
import '../../contoller/providers/color_provider.dart';
import '../../contoller/providers/language_proivder.dart';

class LanguageSwitcherWidget extends ConsumerWidget {
  const LanguageSwitcherWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      iconColor: ref.read(themeModeNotifier.notifier).textTheme(ref: ref),
      dense: getIt<AppDimension>().isSmallScreen(context),
      splashColor:
          ref.read(themeModeNotifier.notifier).backgroundAppTheme(ref: ref),
      // minVerticalPadding: ,

      contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      // leading: icon ,
      leading: Icon(
        Icons.language_outlined,
        size: getIt<AppDimension>().isSmallScreen(context) ? 32 - 5 : 32,
        color: ref.read(themeModeNotifier.notifier).textTheme(ref: ref),
      ),

      // titleAlignment: ListTileTitleAlignment.center,
      title: Text(
        SetLocalization.of(context)!.getTranslateValue("language"),
        style: TextStyle(
          fontSize: getIt<AppDimension>().isSmallScreen(context) ? 14 : 16,
          color: ref.read(themeModeNotifier.notifier).textTheme(ref: ref)
        ),
      ),
      trailing: const Column(
        mainAxisSize: MainAxisSize.min,
        // Keep the widget compact
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            // Keep the widget compact
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// buttons
              ArabicButton(),
              SizedBox(width: 20),

              EnglishButton(),
              // Spacing between buttons

              SizedBox(
                width: 10,
              )
            ],
          ),
        ],
      ),
    );

  }
}

class ArabicButton extends ConsumerWidget {
  const ArabicButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ///  inActive width button
    var inActiveWidthButton =
        ref.read(widthSizeWithInActiveArButton); // normal screen size
    var activeWidthButton =
        ref.read(widthSizeWithActiveArButtonInSmallScreen); //small screen size

    /// Active height button
    var inActiveHeightButton =
        ref.read(heightSizeInActiveArButton); // normal screen size
    var activeHeightButton =
        ref.read(heightSizeActiveArButtonInSmallScreen); //small screen size

    return SizedBox(
      width: getIt<AppDimension>().isSmallScreen(context)
          ? activeWidthButton
          : inActiveWidthButton,
      height: getIt<AppDimension>().isSmallScreen(context)
          ? activeHeightButton
          : inActiveHeightButton,
      child: ElevatedButton(
        onPressed: () async {
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            ref.read(languageNotifier.notifier).changeLanguage("ar", context);
            ref.read(languageNotifier.notifier).saveLanguage("ar");
          });
          if (NewSession.get("language", "ar") == "ar") {
            return;
          }
          // await myPushNameAnimation(context);

          NewSession.save("language", "ar");

          /// languageController.changeLanguage("ar", context);

          // changeLanguage('ar', context);
          // Call your language change function here
          // e.g., changeLanguage('ar', context);
        },
        style: ElevatedButton.styleFrom(
          elevation: NewSession.get("language", "ar") == 'ar' ? 0 : 3.5,
          backgroundColor: NewSession.get(
                      "language",
                      "ar"
                          "") ==
                  'ar'
              ? (ref.read(themeModeNotifier.notifier).primaryTheme(ref: ref))
              : Colors.grey, // Highlight selected language
        ),
        child: Text('ع',
            style: TextStyle(
                fontSize:
                    getIt<AppDimension>().isSmallScreen(context) ? 14 : 16,
                color: Colors.white)),
      ),
    );
  }
}

class EnglishButton extends ConsumerWidget {
  const EnglishButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ///  inActive width button
    var inActiveWidthButton =
        ref.read(widthSizeWithInActiveEnButton); // normal screen size
    var activeWidthButton =
        ref.read(widthSizeWithActiveEnButtonInSmallScreen); //small screen size

    /// Active height button
    var inActiveHeightButton =
        ref.read(heightSizeInActiveEnButton); // normal screen size
    var activeHeightButton =
        ref.read(heightSizeActiveEnButtonInSmallScreen); //small screen size

    return SizedBox(
      width: getIt<AppDimension>().isSmallScreen(context)
          ? activeWidthButton
          : inActiveWidthButton,
      height: getIt<AppDimension>().isSmallScreen(context)
          ? activeHeightButton
          : inActiveHeightButton,
      child: ElevatedButton(
        onPressed: () async {
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            ref.read(languageNotifier.notifier).changeLanguage("en", context);
            ref.read(languageNotifier.notifier).saveLanguage("en");
          });

          if (NewSession.get("language", "en") == "en") {
            return;
          }

          // await myPushNameAnimation(context);
          NewSession.save("language", "en");
        },
        style: ElevatedButton.styleFrom(
          elevation: NewSession.get("language", "en") == 'en' ? 0 : 3.5,
          backgroundColor: NewSession.get("language", "en") == 'en'
              ? (ref.read(themeModeNotifier.notifier).primaryTheme(ref: ref))
              : Colors.grey, // Highlight selected
          // language
        ),
        child: Text('EN',
            softWrap: false,
            style: TextStyle(
                fontSize:
                    getIt<AppDimension>().isSmallScreen(context) ? 14 : 16,
                color: Colors.white)),
      ),
    );
  }
}
