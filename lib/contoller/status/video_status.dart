import '../../api/yt_video.dart';

class VideoState {
  final List<YtVideo> ?playListItems;
  final bool loading;
  final bool ?noVideosFound;
  final bool ?isBoyStudent;

  VideoState({
    this.playListItems,
    this.loading = false,
    this.noVideosFound,
    this.isBoyStudent,
  });

  VideoState copyWith({
    List<YtVideo>? playListItems,
    bool? loading,
    bool? noVideosFound,
    bool? isBoyStudent,
  }) {
    return VideoState(
      playListItems: playListItems ?? this.playListItems,
      loading: loading ?? this.loading,
      noVideosFound: noVideosFound ?? this.noVideosFound,
      isBoyStudent: isBoyStudent ?? this.isBoyStudent,
    );
  }
}
