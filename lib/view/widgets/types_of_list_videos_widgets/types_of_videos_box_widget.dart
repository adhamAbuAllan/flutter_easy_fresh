import 'package:flutter/material.dart';
import 'package:flutter_easy_fresh/contoller/providers/video_provider.dart';
import 'package:flutter_easy_fresh/view/widgets/types_of_list_videos_widgets/pointer_type_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../const/localization.dart';
import '../../../contoller/providers/color_provider.dart';
import '../../../contoller/providers/widgets_porvider.dart';
import '../../../session/new_session.dart';

class ShowVideosTypesBoxWidget extends ConsumerWidget {
  const ShowVideosTypesBoxWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the visibility state of both the box and the list

    var isListOfTypes = ref.watch(isListOfTypesNotifier);
    var isBoxVisible = ref.watch(isBoxVisibleNotifier);
    return SizedBox(
      child:
          isListOfTypes && isBoxVisible
              ? Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 155.0,
                  horizontal: 15,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 7,
                      color: ref
                          .watch(themeModeNotifier.notifier)
                          .backgroundAppTheme(ref: ref),
                      strokeAlign: BorderSide.strokeAlignOutside,
                    ),
                    color: ref
                        .watch(themeModeNotifier.notifier)
                        .containerTheme(ref: ref),
                    borderRadius: BorderRadiusDirectional.circular(7),
                  ),
                  height: 200,
                  width: 150,
                  child: const Padding(
                    padding: EdgeInsets.only(top: 0, left: 8, right: 8),
                    child: Column(
                      children: [
                        TypeRowOfLevelOne(),
                        TypeRowOfLevelTwo(),
                        TypeRowOfLevelThree(),
                        TypeRowOfLevelFour(),
                      ],
                    ),
                  ),
                ),
              )
              : null,
    );
  }
}

class VideosShowTypesTextButtonWidget extends ConsumerWidget {
  final String textType;
  final void Function()? onPressed;

  const VideosShowTypesTextButtonWidget({
    super.key,
    this.onPressed,
    required this.textType,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get the theme mode from Riverpod state
    // final themeMode = ref.watch(themeModeProvider);

    return Expanded(
      child: TextButton(
        style: ButtonStyle(
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 10),
          ),
          alignment:
              NewSession.get("language", "ar") == "en"
                  ? Alignment.centerLeft
                  : Alignment.centerRight,
          overlayColor: WidgetStatePropertyAll(
            ref.watch(themeModeNotifier.notifier).primaryTheme(ref: ref),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          SetLocalization.of(context)!.getTranslateValue(textType),
          style: TextStyle(
            color: ref.watch(themeModeNotifier.notifier).textTheme(ref: ref),
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}

class TypeRowOfLevelOne extends ConsumerWidget {
  const TypeRowOfLevelOne({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String viewsLabel = SetLocalization.of(context)?.getTranslateValue("views") ?? "views";
    String likesLabel = SetLocalization.of(context)?.getTranslateValue("likes") ?? "likes";
    String MLabel = SetLocalization.of(context)?.getTranslateValue("M") ?? "M";
    String KLabel = SetLocalization.of(context)?.getTranslateValue("K") ?? "K";
    String minuteLabel = SetLocalization.of(context)?.getTranslateValue("minute") ?? "min";

    return Row(
      children: [
        VideosShowTypesTextButtonWidget(
          textType: "level_1", // Change this as per localization
          onPressed: () {
            Future.microtask(() {
              if (NewSession.get("language", "") == "ar") {
                ref
                    .watch(videoNotifierProvider.notifier)
                    .getAllVideos(     viewsLabel: viewsLabel,
                  likesLabel: likesLabel,
                  MLabel: MLabel,
                  KLabel: KLabel,
                  minuteLabel: minuteLabel,
                      listPlayId: "PLFky0QidIsRVe6LCB_AmakRBALyqDOdN9",
                    );
              } else {
                ref
                    .watch(videoNotifierProvider.notifier)
                    .getAllVideos(     viewsLabel: viewsLabel,
      likesLabel: likesLabel,
      MLabel: MLabel,
      KLabel: KLabel,
      minuteLabel: minuteLabel,
                      listPlayId: "PLFky0QidIsRXWOwxtSerlqeRtaHM7XMt_",
                    );
              }
            });
          },
        ),
        Padding(
          padding: const EdgeInsets.only(right: 5),
          child: AnimatedOpacity(
            opacity:
                ref.watch(currentPlayListIdNotifier) ==
                            "PLFky0QidIsRXWOwxtSerlqeRtaHM7XMt_" ||
                        ref.watch(currentPlayListIdNotifier) ==
                            "PLFky0QidIsRVe6LCB_AmakRBALyqDOdN9"
                    ? 1.0
                    : 0.0,
            duration: const Duration(milliseconds: 200),
            child:
                ref.watch(currentPlayListIdNotifier) ==
                            "PLFky0QidIsRXWOwxtSerlqeRtaHM7XMt_" ||
                        ref.watch(currentPlayListIdNotifier) ==
                            "PLFky0QidIsRVe6LCB_AmakRBALyqDOdN9"
                    ? const PointerTypeWidget()
                    : const SizedBox(),
          ),
        ),

        const SizedBox(width: 10),
      ],
    );
  }
}

class TypeRowOfLevelTwo extends ConsumerWidget {
  const TypeRowOfLevelTwo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String viewsLabel = SetLocalization.of(context)?.getTranslateValue("views") ?? "views";
    String likesLabel = SetLocalization.of(context)?.getTranslateValue("likes") ?? "likes";
    String MLabel = SetLocalization.of(context)?.getTranslateValue("M") ?? "M";
    String KLabel = SetLocalization.of(context)?.getTranslateValue("K") ?? "K";
    String minuteLabel = SetLocalization.of(context)?.getTranslateValue("minute") ?? "min";

    return Row(
      children: [
        VideosShowTypesTextButtonWidget(
          textType: "level_2", // Change this as per localization
          onPressed: () {
            // ref.watch(isLevelOneNotifier.notifier).state = false;
            // ref.watch(isLevelTwoNotifier.notifier).state = true;
            // ref.watch(isLevelThreeNotifier.notifier).state = false;
            // ref.watch(isLevelFourNotifier.notifier).state = false;

            /*
                      WidgetsBinding.instance.addPostFrameCallback((_) async {
                        Future.microtask(() {
                          if (NewSession.get("language", "") == "ar") {
                            debugPrint("arabic");
                          } else {
                            debugPrint("english");
                          }
                          ref
                              .watch(videoNotifierProvider.notifier)
                              .getAllVideos(
                                listPlayId:
                                    "PLiMj4nUvC2JhKASaQGaIEiPd_sNLw5I-t",
                              );
                        });
                      });
 */
            //PLFky0QidIsRU6hwTIVSUSIGHw-3iPBlHy
            Future.microtask(() {
              if (NewSession.get("language", "") == "ar") {
                ref
                    .watch(videoNotifierProvider.notifier)
                    .getAllVideos(     viewsLabel: viewsLabel,
      likesLabel: likesLabel,
      MLabel: MLabel,
      KLabel: KLabel,
      minuteLabel: minuteLabel,
                      listPlayId: "PLFky0QidIsRU6hwTIVSUSIGHw-3iPBlHy",
                    );

              } else {
                ref
                    .watch(videoNotifierProvider.notifier)
                    .getAllVideos(     viewsLabel: viewsLabel,
      likesLabel: likesLabel,
      MLabel: MLabel,
      KLabel: KLabel,
      minuteLabel: minuteLabel,
                      listPlayId: "PLFky0QidIsRX9imrxA4cmg_FcY9h9TTWH",
                    );
              }
            });
          },
        ),
        Padding(
          padding: const EdgeInsets.only(right: 5),
          child: AnimatedOpacity(
            opacity:
                ref.watch(currentPlayListIdNotifier) ==
                            "PLFky0QidIsRX9imrxA4cmg_FcY9h9TTWH" ||
                        ref.watch(currentPlayListIdNotifier) ==
                            "PLFky0QidIsRU6hwTIVSUSIGHw-3iPBlHy"
                    ? 1.0
                    : 0.0,
            duration: const Duration(milliseconds: 200),
            child:
                ref.watch(currentPlayListIdNotifier) ==
                            "PLFky0QidIsRX9imrxA4cmg_FcY9h9TTWH" ||
                        ref.watch(currentPlayListIdNotifier) ==
                            "PLFky0QidIsRU6hwTIVSUSIGHw-3iPBlHy"
                    ? const PointerTypeWidget()
                    : const SizedBox(),
          ),
        ),

        const SizedBox(width: 10),
      ],
    );
  }
}

class TypeRowOfLevelThree extends ConsumerWidget {
  const TypeRowOfLevelThree({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String viewsLabel = SetLocalization.of(context)?.getTranslateValue("views") ?? "views";
    String likesLabel = SetLocalization.of(context)?.getTranslateValue("likes") ?? "likes";
    String MLabel = SetLocalization.of(context)?.getTranslateValue("M") ?? "M";
    String KLabel = SetLocalization.of(context)?.getTranslateValue("K") ?? "K";
    String minuteLabel = SetLocalization.of(context)?.getTranslateValue("minute") ?? "min";

    return Row(
      children: [
        VideosShowTypesTextButtonWidget(
          textType: "level_3", // Change this as per localization
          onPressed: () {
            // ref.watch(isLevelThreeNotifier.notifier).state = true;
            // ref.watch(isLevelOneNotifier.notifier).state = false;
            // ref.watch(isLevelTwoNotifier.notifier).state = false;
            // ref.watch(isLevelFourNotifier.notifier).state = false;
            /*
                      WidgetsBinding.instance.addPostFrameCallback((_) async {
                        Future.microtask(() {
                          if (NewSession.get("language", "") == "ar") {
                            debugPrint("arabic");
                          } else {
                            debugPrint("english");
                          }
                          ref
                              .watch(videoNotifierProvider.notifier)
                              .getAllVideos(
                                listPlayId:
                                    "PLiMj4nUvC2JhKASaQGaIEiPd_sNLw5I-t",
                              );
                        });
                      });
 *///
            WidgetsBinding.instance.addPostFrameCallback((_) async {
              if (NewSession.get("language", "") == "ar") {
                ref
                    .watch(videoNotifierProvider.notifier)
                    .getAllVideos(     viewsLabel: viewsLabel,
      likesLabel: likesLabel,
      MLabel: MLabel,
      KLabel: KLabel,
      minuteLabel: minuteLabel,
                  listPlayId: "PLFky0QidIsRVNWtfMFszywLppLgTfa4I2",
                );              } else {
                ref
                    .watch(videoNotifierProvider.notifier)
                    .getAllVideos(     viewsLabel: viewsLabel,
      likesLabel: likesLabel,
      MLabel: MLabel,
      KLabel: KLabel,
      minuteLabel: minuteLabel,
                      listPlayId: "PLFky0QidIsRXF6rZbVp4xe9ueBEec3Lnv",
                    );
              }
            });
          },
        ),
        Padding(
          padding: const EdgeInsets.only(right: 5),
          child: AnimatedOpacity(
            opacity:
                ref.watch(currentPlayListIdNotifier) ==
                        "PLFky0QidIsRXF6rZbVp4xe9ueBEec3Lnv" || ref.watch
                  (currentPlayListIdNotifier) == "PLFky0QidIsRVNWtfMFszywLppLgTfa4I2"
                    ? 1.0
                    : 0.0,
            duration: const Duration(milliseconds: 200),
            child:
                ref.watch(currentPlayListIdNotifier) ==
                        "PLFky0QidIsRXF6rZbVp4xe9ueBEec3Lnv" || ref.watch
    (currentPlayListIdNotifier) == "PLFky0QidIsRVNWtfMFszywLppLgTfa4I2"
                    ? const PointerTypeWidget()
                    : const SizedBox(),
          ),
        ),

        const SizedBox(width: 10),
      ],
    );
  }
}

class TypeRowOfLevelFour extends ConsumerWidget {

  const TypeRowOfLevelFour({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String viewsLabel = SetLocalization.of(context)?.getTranslateValue("views") ?? "views";
    String likesLabel = SetLocalization.of(context)?.getTranslateValue("likes") ?? "likes";
    String MLabel = SetLocalization.of(context)?.getTranslateValue("M") ?? "M";
    String KLabel = SetLocalization.of(context)?.getTranslateValue("K") ?? "K";
    String minuteLabel = SetLocalization.of(context)?.getTranslateValue("minute") ?? "min";

    return Row(
      children: [
        VideosShowTypesTextButtonWidget(
          textType: "level_4", // Change this as per localization
          onPressed: () {
            // ref.watch(isLevelFourNotifier.notifier).state = true;
            WidgetsBinding.instance.addPostFrameCallback((_) async {
              ref
                  .watch(videoNotifierProvider.notifier)
                  .getAllVideos(     viewsLabel: viewsLabel,
      likesLabel: likesLabel,
      MLabel: MLabel,
      KLabel: KLabel,
      minuteLabel: minuteLabel,
                    listPlayId: "PLiMj4nUvC2JhKASaQGaIEiPd_sNLw5I-t",
                  );
            });
            // ref.watch(isLevelOneNotifier.notifier).state = false;
            // ref.watch(isLevelTwoNotifier.notifier).state = false;
            // ref.watch(isLevelThreeNotifier.notifier).state = false;
            /*
                      WidgetsBinding.instance.addPostFrameCallback((_) async {
                        Future.microtask(() {
                          if (NewSession.get("language", "") == "ar") {
                            debugPrint("arabic");
                          } else {
                            debugPrint("english");
                          }
                          ref
                              .watch(videoNotifierProvider.notifier)
                              .getAllVideos(
                                listPlayId:
                                    "PLiMj4nUvC2JhKASaQGaIEiPd_sNLw5I-t",
                              );
                        });
                      });
 */
          },
        ),
        Padding(
          padding: const EdgeInsets.only(right: 5),
          child: AnimatedOpacity(
            opacity:
                ref.watch(currentPlayListIdNotifier) ==
                        "PLiMj4nUvC2JhKASa"
                            "QGaIEiPd_sNLw5I-t"
                    ? 1.0
                    : 0.0,
            duration: const Duration(milliseconds: 200),
            child:
                ref.watch(currentPlayListIdNotifier) ==
                        "PLiMj4nUvC2JhKASaQGaIEiPd_sNLw5I-t"
                    ? const PointerTypeWidget()
                    : const SizedBox(),
          ),
        ),

        const SizedBox(width: 10),
      ],
    );
  }
}
