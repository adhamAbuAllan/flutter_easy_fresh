import 'package:flutter/material.dart';
import 'package:flutter_easy_fresh/contoller/methods/route_pages/push_routes.dart';
import 'package:flutter_easy_fresh/view/widgets/aline_widget.dart';
import 'package:flutter_easy_fresh/view/widgets/button_list_tile_widget.dart';
import 'package:flutter_easy_fresh/view/widgets/language_switcher_widget.dart';
import 'package:flutter_easy_fresh/view/widgets/theme_mode_switcher_widget.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

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
        ],
      ),
    );
  }
}
