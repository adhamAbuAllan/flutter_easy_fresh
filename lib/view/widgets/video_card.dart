import 'package:flutter/material.dart';
import 'package:flutter_easy_fresh/const/localization.dart';
import 'package:flutter_easy_fresh/view/widgets/video_card_skeleton.dart';
import 'package:flutter_easy_fresh/view/widgets/video_details_bottom_sheet.dart';
import 'package:flutter_easy_fresh/view/widgets/video_filter_bar_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/yt_video.dart';
import '../../contoller/providers/color_provider.dart';
import '../../contoller/providers/video_provider.dart';
import '../video_player_ui.dart';

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
      Future.microtask(() {
        ref
            .read(videoNotifierProvider.notifier)
            .getAllVideos(
              context: context,
              listPlayId: "PLiMj4nUvC2JhKASaQGaIEiPd_sNLw5I-t",
            );
      });
    });
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
          backgroundColor: ref.read(themeModeNotifier.notifier).backgroundAppTheme(ref: ref),
          leading: SizedBox(),
          expandedHeight: 50, // Adjust the height as needed
          floating: true, // Makes the app bar visible as soon as the user scrolls
          pinned: false, // Keeps the app bar visible when scrolled up
          flexibleSpace: FlexibleSpaceBar(

            background: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: ref.watch(horizontalScrollController),
              child: VideoFilterBarWidgetA(), // Your filter widget
            ),
          ),
        ),

        // Check if video state is loading, if yes show skeleton, else show list of videos
        if(videoState.playListItems?.isEmpty??true && !videoState.loading)
        SliverToBoxAdapter(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              //no data icon , result is not found icon

              Icon(Icons.cancel_presentation,size: 100,color: ref.read(themeModeNotifier
                  .notifier).textTheme(ref: ref),),
              Text("not found",style: TextStyle(color: ref.read
              (themeModeNotifier.notifier).textTheme(ref: ref)

              ),)],
          ),
        ),
        videoState.loading
            ? SkeletonHomeUi(hasCitiesBar: false)
            : SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: videoState.playListItems?.length,
                (context, index) {
              final ytVideo = videoState.playListItems?[index];
              return RepaintBoundary(
                child: VideoCard(
                  videoModel: ytVideo ??
                      VideoModel(
                        videoId: "",
                        videoTitle: "",
                        thumbnailUrl: "",
                        viewsCount: "",
                        likesCount: '',
                        videoDescription: '',
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

    return GestureDetector(
      onTap: () {
        // if (!mounted) return; // Ensure widget is mounted before navigating
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder:
                (context, animation, secondaryAnimation) =>
                    VideoPlayerUI(videoId: videoModel.videoId),
            transitionsBuilder: (
              context,
              animation,
              secondaryAnimation,
              child,
            ) {
              return FadeTransition(
                opacity: animation,
                child: child,
              ); // Simple fade instead of Hero
            },
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(10, 0, 10, 23),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: ref.read(themeModeNotifier.notifier).containerTheme(ref: ref).withAlpha(200),
        ),
        child: Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            Hero(
              tag: 'video_thumbnail_${videoModel.videoId}', // Unique tag
              child: ClipRRect(
                borderRadius: BorderRadius.circular(7),
                child: Image.network(
                  videoModel.thumbnailUrl,
                  fit: BoxFit.cover,
                  width: 367,
                  height: 220,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                videoModel.videoTitle,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: ref
                      .read(themeModeNotifier.notifier)
                      .textTheme(ref: ref).withAlpha(200),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Icon(
                    size: 14,
                    Icons.thumb_up, // Your icon of choice
                    color: ref
                        .read(themeModeNotifier.notifier)
                        .textTheme(ref: ref).withAlpha(200),
                    // const Color(0xfdfCfCfC),
                  ),
                  const SizedBox(width: 3),
                  Text(
                    videoModel.likesCount,
                    style: TextStyle(
                      color: ref
                          .read(themeModeNotifier.notifier)
                          .textTheme(ref: ref).withAlpha(200),
                      // const Color(0xfdfCfCfC),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: (){
                showModalBottomSheet(
                  context: context,

                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  builder: (context) {
                    return VideoDetailsBottomSheet(videoModel: videoModel);
                  },
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    Icon(
                      size: 14,
                      Icons.remove_red_eye, // Your icon of choice
                      color: ref
                          .read(themeModeNotifier.notifier)
                          .textTheme(ref: ref).withAlpha(200),
                      // const Color(0xfdfCfCfC),
                    ),
                    const SizedBox(width: 3),
                    Row(
                      children: [
                        Text(
                          videoModel.viewsCount,
                          style: TextStyle(
                            color: ref
                                .read(themeModeNotifier.notifier)
                                .textTheme(ref: ref).withAlpha(200),
                            // const Color(0xfdfCfCfC)
                          ),
                        ),                 Text(
                          "${SetLocalization.of(context)?.getTranslateValue("more")}",
                          style: TextStyle(
                            color: ref
                                .read(themeModeNotifier.notifier)
                                .textTheme(ref: ref)
                            // const Color(0xfdfCfCfC)
                          ),
                        ),

                      ],
                    ),
                    const Expanded(child: SizedBox()),
                    Icon(
                      size: 14,
                      Icons.access_time,
                      color: ref
                          .read(themeModeNotifier.notifier)
                          .textTheme(ref: ref).withAlpha(200),
                      // const Color(0xfdfCfCfC),
                    ),
                    const SizedBox(width: 3),
                    Text(
                      videoModel.videoDuration ?? "0:00",
                      style: TextStyle(
                        color: ref
                            .read(themeModeNotifier.notifier)
                            .textTheme(ref: ref).withAlpha(200),
                        // const Color(0xfdfCfCfC)
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
