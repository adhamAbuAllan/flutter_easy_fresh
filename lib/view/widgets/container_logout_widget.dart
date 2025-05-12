import 'package:flutter/material.dart';
import 'package:flutter_easy_fresh/contoller/methods/route_pages/push_routes.dart';
import 'package:flutter_easy_fresh/view/widgets/aline_widget.dart';
import 'package:flutter_easy_fresh/view/widgets/button_list_tile_widget.dart';
import 'package:flutter_easy_fresh/view/widgets/language_switcher_widget.dart';
import 'package:flutter_easy_fresh/view/widgets/theme_mode_switcher_widget.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../const/coordination.dart';
import '../../const/get_it_controller.dart';
import '../../const/localization.dart';
import '../../contoller/providers/color_provider.dart';
import '../my_cv/cv_ui.dart';

class ContainerMenuWidget extends ConsumerStatefulWidget {
  const ContainerMenuWidget({
    super.key,
    this.onChange,
    required this.isLogined,
  });

  final Function(bool)? onChange;
  final bool isLogined;

  @override
  ConsumerState createState() => _ContainerLogoutWidgetState();
}

class _ContainerLogoutWidgetState extends ConsumerState<ContainerMenuWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(7)),
      child: Column(
        children: [
          ThemeModeSwitcherWidget(onChange: widget.onChange),
          Padding(padding: const EdgeInsets.only(top: 0), child: aline),
          const LanguageSwitcherWidget(),
          Padding(padding: const EdgeInsets.only(top: 4.0), child: aline),
          ButtonListTileWidget(
            onTap: () {
              myPush(context: context, ui: PortfolioScreen());
            },
            titleJson: "about_developer",
            icon: Icons.info,
          ),
          // ListTile(
          //   iconColor: ref.read(themeModeNotifier.notifier).textTheme(ref: ref),
          //   dense: getIt<AppDimension>().isSmallScreen(context),
          //   splashColor: ref
          //       .read(themeModeNotifier.notifier)
          //       .backgroundAppTheme(ref: ref),
          //
          //   // minVerticalPadding: ,
          //   contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
          //   // leading: icon ,
          //   leading: Icon(
          //     Icons.language_outlined,
          //     size: 32,
          //     color: ref.read(themeModeNotifier.notifier).textTheme(ref: ref),
          //   ),
          //
          //   // titleAlignment: ListTileTitleAlignment.center,
          //   title: Text(
          //     SetLocalization.of(context)!.getTranslateValue("about_developer"),
          //     style: TextStyle(
          //       fontSize: getIt<AppDimension>().isSmallScreen(context) ? 14 : 16,
          //       color: ref.read(themeModeNotifier.notifier).textTheme(ref: ref),
          //     ),
          //   ),
          //   trailing: const Column(
          //     mainAxisSize: MainAxisSize.min,
          //     // Keep the widget compact
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: [
          //       Row(
          //         mainAxisSize: MainAxisSize.min,
          //         // Keep the widget compact
          //         mainAxisAlignment: MainAxisAlignment.end,
          //         crossAxisAlignment: CrossAxisAlignment.center,
          //
          //       ),
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
}
