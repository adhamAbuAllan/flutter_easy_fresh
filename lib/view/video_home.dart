import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_easy_fresh/view/widgets/container_logout_widget.dart';
import 'package:flutter_easy_fresh/view/widgets/videos_list_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../contoller/providers/color_provider.dart';
import '../contoller/providers/widgets_porvider.dart';
import '../contoller/status/video_status.dart';

class YouTubeHomePage extends ConsumerStatefulWidget {
  const YouTubeHomePage({super.key});

  @override
  ConsumerState<YouTubeHomePage> createState() => _YouTubeHomePageState();
}

class _YouTubeHomePageState extends ConsumerState<YouTubeHomePage> {
  final ScrollController scrollController = ScrollController();
  VideoState videoState = VideoState();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      Future.delayed(const Duration(milliseconds: 350), () {
        if (scrollController.position.userScrollDirection ==
            ScrollDirection.forward) {
          if (!videoState.loading) {
            ref.watch(isBoxVisibleNotifier.notifier).state = true;
          }
          ref.watch(isVisibleNotifier.notifier).state = true;
        } else if (scrollController.position.userScrollDirection ==
            ScrollDirection.reverse) {
          if (!videoState.loading) {
            ref.watch(isBoxVisibleNotifier.notifier).state = false;
          }
          ref.watch(isBoxVisibleNotifier.notifier).state = false;
        }
      });

    });

    // Fetch videos when the widget is initialized
  }

  @override
  Widget build(BuildContext context) {
    return ColorfulSafeArea(
      color: ref.read(themeModeNotifier.notifier).containerTheme(ref: ref),
      child: Scaffold(
        drawer: Drawer(
          backgroundColor: ref
              .read(themeModeNotifier.notifier)
              .containerTheme(ref: ref),
          child: Padding(
            padding: const EdgeInsets.only(top: 38.0),
            child: ContainerMenuWidget(
              isLogined: false,
              onChange: (value) {
                WidgetsBinding.instance.addPostFrameCallback((_) async {
                  setState(() {
                    ref.watch(themeModeNotifier.notifier).toggleThemeMode(value);
                  });
                });
              },
            ),
          ),
        ),
        drawerScrimColor: Colors.black.withAlpha(100),
      
        backgroundColor: ref
            .read(themeModeNotifier.notifier)
            .backgroundAppTheme(ref: ref),
        // const Color(0xff2B2B2B),
        body: ListVideosWithTypeBtn(scrollController: scrollController),
      ),
    );
  }

}
