import 'package:flutter/material.dart';
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
    });
  }

  @override
  Widget build(BuildContext context) {
    // Watch the YtVideoViewModel state
return Text("data");

  }
}













