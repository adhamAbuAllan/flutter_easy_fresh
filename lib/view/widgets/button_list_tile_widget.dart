import 'package:flutter/material.dart';
import 'package:flutter_easy_fresh/const/localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../const/coordination.dart';
import '../../const/get_it_controller.dart';
import '../../contoller/providers/color_provider.dart';

class ButtonListTileWidget extends ConsumerWidget {
  const ButtonListTileWidget({
    super.key,
    required this.onTap,
    required this.titleJson,
    this.image,
    this.icon,
    this.color,
  });

  final Function onTap;
  final String titleJson;
  final Image? image;
  final IconData? icon;
  final Color? color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      iconColor: ref.read(themeModeNotifier.notifier).textTheme(ref: ref),

      onTap: () {
        onTap.call();
      },
      dense: getIt<AppDimension>().isSmallScreen(context),
      splashColor: ref
          .read(themeModeNotifier.notifier)
          .backgroundAppTheme(ref: ref),

      // minVerticalPadding: ,
      contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      // leading: icon ,
      leading:
          image != null || icon != null
              ? (image ??
                  Icon(
                    icon,
                    size:
                        getIt<AppDimension>().isSmallScreen(context)
                            ? 32 - 5
                            : 32,
                  ))
              : null,
      title: Text(
        SetLocalization.of(context)?.getTranslateValue(titleJson) ?? "",
        style: TextStyle(
          fontSize: getIt<AppDimension>().isSmallScreen(context) ? 14 : 16,
          color: ref.read(themeModeNotifier.notifier).textTheme(ref: ref),
        ),
      ),
      trailing: Icon(
        size: getIt<AppDimension>().isSmallScreen(context) ? 24 - 4 : 24,
        Icons.arrow_forward_ios_rounded,
        color: ref.read(themeModeNotifier.notifier).textTheme(ref: ref),
      ),
    );
  }
}
