import 'package:flutter_easy_fresh/contoller/methods/video_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/yt_video.dart';
import '../../const/video_duration_filter.dart';

import '../providers/video_provider.dart';
import '../status/video_status.dart';
class VideoFilterNotifier extends StateNotifier<VideoState> {
  VideoFilterNotifier(this.ref)
      : super(
    VideoState(
      playListItems: [],
      loading: false,
      noVideosFound: false,
      isBoyStudent: false,
    ),
  );

  final Ref ref;

  Future<void> getAllVideos({String ? listPlayId}) async {
    state = state.copyWith(loading: true);
ref.read(currentPlayListIdNotifier.notifier).state = listPlayId ?? "PLiMj4nUvC2JiDluqq4-qM8sqeCNIb7sL9";
    List<YtVideo> allVideos = await ParentVideoNotifier()
        .getAllVideosFromPlaylist(listPlayId: listPlayId);

    List<YtVideo> filteredVideos = allVideos;

    final selectedFilterA = ref.read(videoFilterProvider);

    if (selectedFilterA == EnumVideoDurationFilter.under30) {
      filteredVideos =
          allVideos.where((video) {
            int? duration = int.tryParse(
              video.videoDuration?.split(' ')[0] ?? '0',
            );
            return duration != null && duration < 30;
          }).toList();
    } else if (selectedFilterA == EnumVideoDurationFilter.between30And60) {
      filteredVideos =
          allVideos.where((video) {
            int? duration = int.tryParse(
              video.videoDuration?.split(' ')[0] ?? '0',
            );
            return duration != null && duration >= 30 && duration <= 60;
          }).toList();
    } else if (selectedFilterA == EnumVideoDurationFilter.above60) {
      filteredVideos =
          allVideos.where((video) {
            int? duration = int.tryParse(
              video.videoDuration?.split(' ')[0] ?? '0',
            );
            return duration != null && duration > 60;
          }).toList();
    }

    state = state.copyWith(
      playListItems: filteredVideos,
      loading: false,
      noVideosFound: filteredVideos.isEmpty,
    );
  }

}