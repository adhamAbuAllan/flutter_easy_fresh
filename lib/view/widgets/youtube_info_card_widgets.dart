
import 'package:flutter/material.dart';
import 'package:flutter_easy_fresh/view/widgets/video_details_bottom_sheet.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/video_model.dart';
import '../../const/localization.dart';
import '../../contoller/providers/color_provider.dart';
import '../video_player_ui.dart';

/// this widgets has the information of the video
/// like title, description, channel name, channel image, video image.
class VideoItemConainerWidget extends ConsumerWidget {
  const VideoItemConainerWidget({super.key,required this.videoModel});
  final VideoModel videoModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                VideoPlayerUI(videoId: videoModel.videoId),
            transitionsBuilder: (context, animation, _, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(10, 0, 10, 23),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: ref.read(themeModeNotifier.notifier).containerTheme(ref: ref),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            VideoThumbnail(videoModel: videoModel),
            VideoTitle(videoModel: videoModel),
            LikesRow(videoModel: videoModel),
            ViewsAndDetailsRow(videoModel: videoModel),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
class VideoThumbnail extends StatelessWidget {
  final VideoModel videoModel;

  const VideoThumbnail({super.key, required this.videoModel});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'video_thumbnail_${videoModel.videoId}',
      child: ClipRRect(
        borderRadius: BorderRadius.circular(7),
        child: Image.network(
          videoModel.thumbnailUrl,
          fit: BoxFit.cover,
          width: 367,
          height: 220,
        ),
      ),
    );
  }
}
class VideoTitle extends ConsumerWidget {
  final VideoModel videoModel;

  const VideoTitle({super.key, required this.videoModel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        videoModel.videoTitle,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: ref.read(themeModeNotifier.notifier).textTheme(ref: ref).withAlpha(200),
        ),
      ),
    );
  }
}
class LikesRow extends ConsumerWidget {
  final VideoModel videoModel;

  const LikesRow({super.key, required this.videoModel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = ref.read(themeModeNotifier.notifier).textTheme(ref: ref).withAlpha(200);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Icon(Icons.thumb_up, size: 14, color: color),
          const SizedBox(width: 3),
          Text(
            videoModel.likesCount,
            style: TextStyle(color: color, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
class ViewsAndDetailsRow extends ConsumerWidget {
  final VideoModel videoModel;

  const ViewsAndDetailsRow({super.key, required this.videoModel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = ref.read(themeModeNotifier.notifier).textTheme(ref: ref).withAlpha(200);

    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          builder: (_) => VideoDetailsBottomSheet(videoModel: videoModel),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Icon(Icons.remove_red_eye, size: 14, color: color),
            const SizedBox(width: 3),
            Row(
              children: [
                Text(videoModel.viewsCount, style: TextStyle(color: color)),
                Text(
                  "${SetLocalization.of(context)?.getTranslateValue("more")}",
                  style: TextStyle(color: ref.read(themeModeNotifier.notifier).textTheme(ref: ref)),
                ),
              ],
            ),
            const Spacer(),
            Icon(Icons.access_time, size: 14, color: color),
            const SizedBox(width: 3),
            Text(
              videoModel.videoDuration ?? "0:00",
              style: TextStyle(color: color),
            ),
          ],
        ),
      ),
    );
  }
}