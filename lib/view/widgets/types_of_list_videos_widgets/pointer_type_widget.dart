import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../contoller/providers/color_provider.dart';
import '../../../contoller/providers/widgets_porvider.dart';

class PointerTypeWidget extends ConsumerWidget {
  const PointerTypeWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {


    // If pointer is visible, render it; otherwise, return SizedBox
    return

    Container(
      width: (50 / 2.7),
      height:  (50 / 2.7),
      decoration: BoxDecoration(
        color: ref.read(themeModeNotifier.notifier).primaryTheme(ref: ref),

        borderRadius: BorderRadiusDirectional.circular(
           (7 / 2),
        ),
        border: Border.all(
          color: ref.read(themeModeNotifier.notifier).primary300Theme(ref: ref),

          strokeAlign: BorderSide.strokeAlignOutside,
          width: (7 / 2),
        ),
      ),
    );

  }
}
