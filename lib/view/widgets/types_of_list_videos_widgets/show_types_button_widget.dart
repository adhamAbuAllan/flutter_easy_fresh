import 'package:flutter/material.dart';
import 'package:flutter_easy_fresh/const/localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../contoller/providers/widgets_porvider.dart';
import '../outline_button_widget.dart';

// Assuming ChangeThemeMode is a provider that holds theme data

class ShowTypesButtonWidget extends ConsumerWidget {
  final void Function()? onPressed;
  final String text;

  const ShowTypesButtonWidget({super.key, this.onPressed, required this.text});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get the theme mode from Riverpod state
    var isBoxVisible = ref.watch(isBoxVisibleNotifier);
    return SizedBox(
      child:
          isBoxVisible
              ? Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 102,
                ),
                child: BtnShowTypesOfVideos(onPressed: onPressed, text: text),
              )
              : null,
    );
  }
} //

class BtnShowTypesOfVideos extends ConsumerStatefulWidget {
  const BtnShowTypesOfVideos({
    super.key,
    required this.onPressed,
    required this.text,
  });

  final void Function()? onPressed;
  final String text;

  @override
  ConsumerState<BtnShowTypesOfVideos> createState() =>
      _BtnShowTypesOfVideosState();
}

class _BtnShowTypesOfVideosState extends ConsumerState<BtnShowTypesOfVideos> {
  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    final isListOfTypes = ref.watch(isListOfTypesNotifier);

    return OutlinedButtonWidget(
      isFloatingOutlinedButton: true,
      onPressed:
          widget.onPressed ??
          () {
            ref.read(isListOfTypesNotifier.notifier).state = !isListOfTypes;
          },
      child: Text(SetLocalization.of(context)!.getTranslateValue(widget.text)),
    );
  }
}
