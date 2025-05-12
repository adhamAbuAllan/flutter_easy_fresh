import 'package:flutter/material.dart';
import 'package:flutter_easy_fresh/contoller/providers/video_provider.dart';
import 'package:flutter_easy_fresh/view/widgets/types_of_list_videos_widgets/show_types_button_widget.dart';
import 'package:flutter_easy_fresh/view/widgets/types_of_list_videos_widgets/types_of_videos_box_widget.dart';
import 'package:flutter_easy_fresh/view/widgets/video_card.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../contoller/providers/widgets_porvider.dart';
import '../../session/new_session.dart';
import 'loading_widgets.dart';

class ListVideosWithTypeBtn extends ConsumerWidget {
  const ListVideosWithTypeBtn({super.key, required this.scrollController});

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        ref.read(isBoxVisibleNotifier.notifier).state =
            !ref.read(isBoxVisibleNotifier);
      },
      child: Stack(
        alignment:
            NewSession.get("language", "ar") ==
                    "en"
                        ""
                ? Alignment.topLeft
                : Alignment.topRight,
        children: [

          ref.watch(videoNotifierProvider).loading
          /// [LoadingWidgets] is a widgets that when the list of videos is loading
              ? LoadingWidgets()
          /// [YouTubeVideoCard] is a widgets of list of videos.

              : YouTubeVideoCard(scrollController: scrollController),

          ShowTypesButtonWidget(text: "level_of_list"),

          /// a button to show
          /// the list of levels.
          const ShowVideosTypesBoxWidget(), // list of levels
        ],
      ),
    );
  }
}
