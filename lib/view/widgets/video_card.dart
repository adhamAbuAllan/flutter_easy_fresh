import 'package:flutter/material.dart';
import 'package:flutter_easy_fresh/session/new_session.dart';
import 'package:flutter_easy_fresh/view/widgets/video_filter_bar_widget.dart';
import 'package:flutter_easy_fresh/view/widgets/youtube_info_card_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/video_model.dart';
import '../../contoller/providers/color_provider.dart';
import '../../contoller/providers/video_provider.dart';

///a [YouTubeVideoCard]  has an element of every youtube video card, that has
/// info of every videos
class YouTubeVideoCard extends ConsumerStatefulWidget {
  const YouTubeVideoCard({super.key, this.scrollController});

  final ScrollController? scrollController;

  @override
  ConsumerState createState() => _YouTubeVideoCardState();
  // _YouTubeVideoCardState createState() => _YouTubeVideoCardState();
}

class _YouTubeVideoCardState extends ConsumerState<YouTubeVideoCard> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (NewSession.get(
        "playListId",
        "PLFky0QidIsRVe6LCB_AmakRBALyqDOdN9",
      ).isNotEmpty) {
        await ref
            .read(videoNotifierProvider.notifier)
            .getAllVideos(
              context: context,
              listPlayId: NewSession.get(
                "playListId",
                "PLFky0QidIsRVe6LCB_AmakRBALyqDOdN9",
              ),
            );
      } else {
        await ref
            .read(videoNotifierProvider.notifier)
            .getAllVideos(
              context: context,
              listPlayId: "PLFky0QidIsRVe6LCB_AmakRBALyqDOdN9",
            );
      }
    });
    NewSession.save("isFirstTime", "OK");
  }

  @override
  Widget build(BuildContext context) {
    final videoState = ref.watch(videoNotifierProvider);

    return CustomScrollView(
      controller: widget.scrollController,
      physics: const BouncingScrollPhysics(),
      slivers: [
        // Add SliverAppBar for app bar behavior
        SliverAppBar(
          backgroundColor: ref
              .read(themeModeNotifier.notifier)
              .backgroundAppTheme(ref: ref),
          leading: SizedBox(),
          expandedHeight: 50,
          // Adjust the height as needed
          floating: true,
          // Makes the app bar visible as soon as the user scrolls
          pinned: false,
          // Keeps the app bar visible when scrolled up
          flexibleSpace: FlexibleSpaceBar(
            background: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: ref.watch(horizontalScrollController),
              child: VideoFilterBarWidgetA(), // Your filter widget
            ),
          ),
        ),

        // Check if video state is loading, if yes show skeleton, else show list of videos
        //   if (videoState.playListItems?.isEmpty ?? false)
        videoState.loading
            ? SliverToBoxAdapter(child: SizedBox())
            // SkeletonHomeUi(hasCitiesBar: false)
            //
            : SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: videoState.playListItems?.length,
                (context, index) {
                  final ytVideo = videoState.playListItems?[index];
                  return RepaintBoundary(
                    child: VideoCard(
                      videoModel:
                          ytVideo ??
                          VideoModel(
                            videoId: "",
                            videoTitle: "",
                            thumbnailUrl: "",
                            viewsCount: "",
                            likesCount: '',
                            videoDescription: '',
                            videoDuration: '',
                          ),
                    ),
                  );
                },
              ),
            ),
      ],
    );
  }
}

class VideoCard extends ConsumerWidget {
  const VideoCard({super.key, required this.videoModel});

  final VideoModel videoModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Access the video data from the provider

    return VideoItemConainerWidget(videoModel: videoModel);
  }
}
