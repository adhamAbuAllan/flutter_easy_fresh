import 'package:flutter/material.dart';
import 'package:flutter_easy_fresh/contoller/providers/video_provider.dart';
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
      splashColor: ref
          .read(themeModeNotifier.notifier)
          .backgroundAppTheme(ref: ref),

      // minVerticalPadding: ,
      contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
      // leading: icon ,
      leading: Icon(
        Icons.language_outlined,
        size: 32,
        color: ref.read(themeModeNotifier.notifier).textTheme(ref: ref),
      ),

      // titleAlignment: ListTileTitleAlignment.center,
      title: Text(
        SetLocalization.of(context)!.getTranslateValue("language"),
        style: TextStyle(
          fontSize: getIt<AppDimension>().isSmallScreen(context) ? 14 : 16,
          color: ref.read(themeModeNotifier.notifier).textTheme(ref: ref),
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
              SizedBox(width: 10),

              EnglishButton(),

              // Spacing between buttons
              // SizedBox(width: 10),
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
    var inActiveWidthButton = ref.read(
      widthSizeWithInActiveArButton,
    ); // normal screen size
    var activeWidthButton = ref.read(
      widthSizeWithActiveArButtonInSmallScreen,
    ); //small screen size

    /// Active height button
    var inActiveHeightButton = ref.read(
      heightSizeInActiveArButton,
    ); // normal screen size
    var activeHeightButton = ref.read(
      heightSizeActiveArButtonInSmallScreen,
    ); //small screen size

    return SizedBox(
      width:
          getIt<AppDimension>().isSmallScreen(context)
              ? activeWidthButton
              : inActiveWidthButton,
      height:
          getIt<AppDimension>().isSmallScreen(context)
              ? activeHeightButton
              : inActiveHeightButton,
      child: ElevatedButton(
        /*
        onPressed: () async {
  WidgetsBinding.instance.addPostFrameCallback((_) async {
    ref.read(languageNotifier.notifier).changeLanguage("ar", context);
    ref.read(languageNotifier.notifier).saveLanguage("ar");

    switch (true) {
      case bool when ref.read(isLevelOneNotifier):
        runLevelOneMethod();
        break;
      case bool when ref.read(isLevelTowNotifier):
        runLevelTwoMethod();
        break;
      case bool when ref.read(isLevelThreeNotifier):
        runLevelThreeMethod();
        break;
      case bool when ref.read(isLevelFourNotifier):
        runLevelFourMethod();
        break;
      default:
        // Handle case where no level is active (optional)
        break;
    }
  });

  if (NewSession.get("language", "ar") == "ar") {
    return;
  }

  NewSession.save("language", "ar");
},
         */
        onPressed: () async {
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            ref.read(languageNotifier.notifier).changeLanguage("ar", context);
            ref.read(languageNotifier.notifier).saveLanguage("ar");
            //that should use a switch , to check current level, that when
            // change the language, that should keep in current level even
            // else the language is changed

            final currentId = ref.read(currentPlayListIdNotifier);

            switch (currentId) {
              case 'PLFky0QidIsRXWOwxtSerlqeRtaHM7XMt_': // Replace with actual ID
                WidgetsBinding.instance.addPostFrameCallback((_) async {
                 await ref
                      .watch(videoNotifierProvider.notifier)
                      .getAllVideos(
                        context: context,
                        listPlayId: "PLFky0QidIsRVe6LCB_AmakRBALyqDOdN9",
                   //PLFky0QidIsRVe6LCB_AmakRBALyqDOdN9
                      );
                });
                break;
              case 'PLFky0QidIsRX9imrxA4cmg_FcY9h9TTWH': // Replace with actual ID
                WidgetsBinding.instance.addPostFrameCallback((_) async {
                await  ref
                      .watch(videoNotifierProvider.notifier)
                      .getAllVideos(
                        context: context,

                        listPlayId: "PLFky0QidIsRU6hwTIVSUSIGHw-3iPBlHy",
                      );
                });
                break;
              case 'PLFky0QidIsRXF6rZbVp4xe9ueBEec3Lnv': // Replace with actual ID
                WidgetsBinding.instance.addPostFrameCallback((_) async {
                await  ref
                      .watch(videoNotifierProvider.notifier)
                      .getAllVideos(
                        context: context,

                        listPlayId: "PLFky0QidIsRVNWtfMFszywLppLgTfa4I2",
                      );
                });
                break;
              case 'PLFky0QidIsRUOZNykwJTHb2he3ccEL0A6': // Replace with actual ID
                WidgetsBinding.instance.addPostFrameCallback((_) async {
                await  ref
                      .watch(videoNotifierProvider.notifier)
                      .getAllVideos(
                        context: context,

                        listPlayId: "PLFky0QidIsRU2stZpEjBgE85Ncvo92F4g",
                      );
                });
                break;
              default:
                // Handle case where no level is active
                break;
            }

            if (NewSession.get("language", "ar") == "ar") {
              return;
            }

            NewSession.save("language", "ar");
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
          backgroundColor:
              NewSession.get(
                        "language",
                        "ar"
                            "",
                      ) ==
                      'ar'
                  ? (ref
                      .read(themeModeNotifier.notifier)
                      .primaryTheme(ref: ref))
                  : Colors.grey, // Highlight selected language
        ),
        child: Text(
          'ع',
          style: TextStyle(
            fontSize: getIt<AppDimension>().isSmallScreen(context) ? 14 : 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class EnglishButton extends ConsumerWidget {
  const EnglishButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var inActiveWidthButton = ref.read(
      widthSizeWithInActiveEnButton,
    ); // normal screen size
    var activeWidthButton = ref.read(
      widthSizeWithActiveEnButtonInSmallScreen,
    ); //small screen size

    /// Active height button
    var inActiveHeightButton = ref.read(
      heightSizeInActiveEnButton,
    ); // normal screen size
    var activeHeightButton = ref.read(
      heightSizeActiveEnButtonInSmallScreen,
    ); //small screen size

    return SizedBox(
      width:
          getIt<AppDimension>().isSmallScreen(context)
              ? activeWidthButton
              : inActiveWidthButton,
      height:
          getIt<AppDimension>().isSmallScreen(context)
              ? activeHeightButton
              : inActiveHeightButton,
      child: ElevatedButton(
        onPressed: () async {
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            ref.read(languageNotifier.notifier).changeLanguage("en", context);
            ref.read(languageNotifier.notifier).saveLanguage("en");
            //that should use a switch , to check current level, that when
            // change the language, that should keep in current level even
            // else the language is changed

            ///  inActive width button
            final currentId = ref.read(currentPlayListIdNotifier);

            switch (currentId) {
              case 'PLFky0QidIsRVe6LCB_AmakRBALyqDOdN9': // Replace with actual ID
                WidgetsBinding.instance.addPostFrameCallback((_) async {
                await  ref
                      .watch(videoNotifierProvider.notifier)
                      .getAllVideos(
                        context: context,

                        listPlayId: "PLFky0QidIsRXWOwxtSerlqeRtaHM7XMt_",
                      );
                });
                break;
              case 'PLFky0QidIsRU6hwTIVSUSIGHw-3iPBlHy': // Replace with actual ID
                WidgetsBinding.instance.addPostFrameCallback((_) async {
              await    ref
                      .watch(videoNotifierProvider.notifier)
                      .getAllVideos(
                        context: context,

                        listPlayId: "PLFky0QidIsRX9imrxA4cmg_FcY9h9TTWH",
                      );
                });
                break;
              case 'PLFky0QidIsRVNWtfMFszywLppLgTfa4I2': // Replace with actual ID
                WidgetsBinding.instance.addPostFrameCallback((_) async {
               await   ref
                      .watch(videoNotifierProvider.notifier)
                      .getAllVideos(
                        context: context,

                        listPlayId: "PLFky0QidIsRXF6rZbVp4xe9ueBEec3Lnv",
                      );
                });
                break;
              case 'PLFky0QidIsRU2stZpEjBgE85Ncvo92F4g': // Replace with actual ID
                WidgetsBinding.instance.addPostFrameCallback((_) async {
               await   ref
                      .watch(videoNotifierProvider.notifier)
                      .getAllVideos(
                        context: context,

                        listPlayId: "PLFky0QidIsRUOZNykwJTHb2he3ccEL0A6",
                      );
                });
                break;
              default:
                // Handle case where no level is active
                break;
            }
          });

          if (NewSession.get("language", "en") == "en") {
            return;
          }

          // await myPushNameAnimation(context);
          NewSession.save("language", "en");
        },
        style: ElevatedButton.styleFrom(
          elevation: NewSession.get("language", "en") == 'en' ? 0 : 3.5,
          backgroundColor:
              NewSession.get("language", "en") == 'en'
                  ? (ref
                      .read(themeModeNotifier.notifier)
                      .primaryTheme(ref: ref))
                  : Colors.grey, // Highlight selected
          // language
        ),
        child: Text(
          'EN',
          softWrap: false,
          style: TextStyle(
            fontSize: getIt<AppDimension>().isSmallScreen(context) ? 14 : 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
