import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../const/coordination.dart';
import '../../const/get_it_controller.dart';
import '../../const/localization.dart';
import '../../contoller/providers/color_provider.dart';


class ThemeModeSwitcherWidget extends ConsumerStatefulWidget {
  const ThemeModeSwitcherWidget({super.key, this.onChange});

  final Function(bool value)? onChange;

  @override
  ConsumerState createState() => _ThemeModeSwitcherWidgetState();
}

class _ThemeModeSwitcherWidgetState
    extends ConsumerState<ThemeModeSwitcherWidget> {
  @override
  Widget build(BuildContext context) {
    final themeModeNoti = ref.watch(themeModeNotifier.notifier);

    return SwitchListTile(
        inactiveThumbColor: ref.read(backgroundAppColorLight),
        activeColor:
        ref.read(themeModeNotifier.notifier).primaryTheme(ref: ref),

        dense: getIt<AppDimension>().isSmallScreen(context),
        title: Row(
          children: [
            Icon(
              themeModeNoti.isLightMode
                  ? Icons.light_mode_outlined
                  : Icons.dark_mode_outlined,
              color:
              ref.read(themeModeNotifier.notifier).textTheme(ref: ref),

              size:  32,
            ),
            const SizedBox(
              width: 18,
            ),
            Text(SetLocalization.of(context)!.getTranslateValue("appearance"),
                style: TextStyle(
                    fontSize:14 ,
                    color: ref.read(themeModeNotifier.notifier).textTheme(ref: ref),
                )),
          ],
        ),
        value: themeModeNoti.isLightMode,
        onChanged: widget.onChange);
  }
}
