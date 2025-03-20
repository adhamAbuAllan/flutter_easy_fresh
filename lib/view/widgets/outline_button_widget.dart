import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../contoller/providers/color_provider.dart';

class OutlinedButtonWidget extends ConsumerWidget {
  const OutlinedButtonWidget(
      {super.key,
      required this.child,
      this.onPressed,
      this.isFloatingOutlinedButton,
      this.borderSide,
      this.overlayColor,
      this.buttonStyle});

  final ButtonStyle? buttonStyle;
  final Widget child;
  final void Function()? onPressed;
  final bool? isFloatingOutlinedButton;
  final Color? overlayColor;
  final BorderSide? borderSide;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OutlinedButton(
      onPressed: onPressed,
      style:buttonStyle?? outlinedButton(
        borderSide: borderSide,
        overlayColor: overlayColor,
        isFloatingOutlinedButton: isFloatingOutlinedButton,
        forgroundColor:
        // Color(0xff546FFA),
            ref.read(themeModeNotifier.notifier).primaryTheme(ref: ref),
        backgroundColor: isFloatingOutlinedButton != null
            ? ref
                .read(themeModeNotifier.notifier)
                .containerTheme(ref: ref, withOpacity: 0.98)
            : ref.read(themeModeNotifier.notifier).containerTheme(ref: ref),
        primaryColor:
            ref.read(themeModeNotifier.notifier).primaryTheme(ref: ref),
        borderColor:
            ref.read(themeModeNotifier.notifier).primaryTheme(ref: ref),
        context: context,
      ),
      child: child,
    );
  }
}

ButtonStyle outlinedButton({
  required Color forgroundColor,
  required Color backgroundColor,
  required Color primaryColor,
  required Color borderColor,
  required BuildContext context,
  bool? isFloatingOutlinedButton,
  Color? overlayColor,
  BorderSide? borderSide,
}) {
  return OutlinedButton.styleFrom(
    foregroundColor: forgroundColor,
    backgroundColor: isFloatingOutlinedButton ?? false ? backgroundColor : null,
    textStyle: TextStyle(
      fontSize:  16,
      color: primaryColor,
      fontWeight: FontWeight.w500,
      fontFamily: 'IBM',
    ),
    side: borderSide ?? BorderSide(width: 1, color: borderColor),
    padding: const EdgeInsets.symmetric(horizontal: 10),
    alignment: Alignment.center,
    overlayColor: overlayColor,
  );
}
