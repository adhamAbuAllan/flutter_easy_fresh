import 'package:flutter/material.dart';
import 'package:flutter_easy_fresh/contoller/providers/video_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerUI extends StatefulWidget {
  final String videoId;
  const VideoPlayerUI({super.key, required this.videoId});

  @override
  State<VideoPlayerUI> createState() => _VideoPlayerUIState();
}

class _VideoPlayerUIState extends State<VideoPlayerUI> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    debugPrint("");

    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: YoutubePlayerFlags(autoPlay: true, mute: false),
    );
    _controller.toggleFullScreenMode(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: YoutubePlayerBuilder(
        player: YoutubePlayer(controller: _controller),
        builder: (context, player) {
          return Column(
            children: [
              // some widgets
              Container(
                width: double.infinity,
                height: 200, // Adjust as per your requirement
                child: player,
              ), //some other widgets
            ],
          );
        },
      ),
    );
  }
}

class VideoListScreen extends ConsumerStatefulWidget {
  const VideoListScreen({super.key});

  @override
  ConsumerState<VideoListScreen> createState() => _VideoListScreenState();
}

class _VideoListScreenState extends ConsumerState<VideoListScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch videos when the widget is initialized
    Future.microtask(() {
      // ref.read(ytVideoViewModelProvider.notifier).getAllVideos(context:context,);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Watch the YtVideoViewModel state
    final ytVideoState = ref.watch(videoNotifierProvider);
return Text("data");
    // return Scaffold(
    //   backgroundColor: const Color(0xff2B2B2B),
    //   body: SafeArea(
    //     child: CustomScrollView(
    //       physics: const ClampingScrollPhysics(),
    //       slivers: [
    //         SliverToBoxAdapter(
    //           child: SizedBox(
    //             height: 50,
    //             child: SingleChildScrollView(
    //               scrollDirection: Axis.horizontal,
    //               child: VideoFilterBarWidgetA(),
    //             ),
    //           ),
    //         ),
    //         if (ytVideoState.loading)
    //           SliverList(
    //             delegate: SliverChildBuilderDelegate(
    //               (context, index) => SkeletonVideoCardA(),
    //               childCount: 10,
    //             ),
    //           ),
    //         if (ytVideoState.noVideosFound)
    //           SliverFillRemaining(
    //             child: Center(
    //               child: Column(
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 children: [
    //                   Icon(
    //                     Icons.image_not_supported,
    //                     size: 100,
    //                     color: Colors.blue,
    //                   ),
    //                   Padding(
    //                     padding: const EdgeInsets.symmetric(vertical: 20),
    //                     child: Text(
    //                       "No videos found with the selected duration.",
    //                       style: TextStyle(
    //                         fontSize: 16,
    //                         color: Colors.blue,
    //                       ),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ),
    //         if (!ytVideoState.loading && !ytVideoState.noVideosFound)
    //           if (ytVideoState.playListItems.isNotEmpty)
    //             SliverList(
    //               delegate: SliverChildBuilderDelegate((context, index) {
    //                 return YouTubeVideoCard(
    //                   ytVideo: ytVideoState.playListItems[index],
    //                 );
    //               }, childCount: ytVideoState.playListItems.length),
    //             )
    //           else
    //             SliverFillRemaining(
    //               child: Center(
    //                 child: Column(
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   children: [
    //                     Icon(
    //                       Icons.image_not_supported,
    //                       size: 100,
    //                       color: Colors.blue,
    //                     ),
    //                     Padding(
    //                       padding: const EdgeInsets.symmetric(vertical: 20),
    //                       child: Text(
    //                         "No videos available.",
    //                         style: TextStyle(
    //                           fontSize: 16,
    //                           color: Colors.blue,
    //                         ),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //       ],
    //     ),
    //   ),
    // );
  }
}













