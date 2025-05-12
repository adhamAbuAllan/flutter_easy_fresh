import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../../const/localization.dart';
import '../../contoller/providers/color_provider.dart';
import '../../contoller/providers/video_provider.dart';

class LoadingWidgets extends ConsumerStatefulWidget {
  const LoadingWidgets({super.key});

  @override
  ConsumerState createState() => _LoadingWidgetsState();
}

class _LoadingWidgetsState extends ConsumerState<LoadingWidgets> {
  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end
      ,
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 300),
          child: Center(
            child: Text(
              SetLocalization.of(
                context,
              )!.getTranslateValue("this_progress_take_an_1_to_3_minutes"),
              style: TextStyle(
                color: ref.read(themeModeNotifier.notifier).textTheme(ref: ref),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 50,
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 50,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: ref
                    .read(themeModeNotifier.notifier)
                    .backgroundAppTheme(ref: ref),
              ),

              //here should to use the linear progress that load according
              child: LinearProgressIndicator(
                semanticsLabel: SetLocalization.of(
                  context,
                )!.getTranslateValue("loading..."),
                borderRadius: BorderRadius.circular(30),
                color: ref
                    .read(themeModeNotifier.notifier)
                    .primaryTheme(ref: ref),
                value: ref.watch(videoNotifierProvider).progressValue,
              ),
            ),
          ),
        ),

        Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 30,
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              SetLocalization.of(context)!.getTranslateValue(
                "loading"
                "...",
              ),
              style: TextStyle(
                color: ref.read(themeModeNotifier.notifier).textTheme(ref: ref),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
