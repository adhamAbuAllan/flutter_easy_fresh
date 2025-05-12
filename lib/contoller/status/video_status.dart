import '../../api/video_model.dart';

class VideoState {
  final List<VideoModel>? playListItems;
  final bool loading;
  final bool? noVideosFound;
  final bool? isBoyStudent;
  final double? progressValue;

  VideoState({
    this.playListItems,
    this.loading = false,
    this.noVideosFound,
    this.isBoyStudent,
    this. progressValue = 0.0,
  });

  VideoState copyWith({
    List<VideoModel>? playListItems,
    bool? loading,
    bool? noVideosFound,
    bool? isBoyStudent,
    double ? progressValue
  }) {
    return VideoState(
      playListItems: playListItems ?? this.playListItems,
      loading: loading ?? this.loading,
      noVideosFound: noVideosFound ?? this.noVideosFound,
      isBoyStudent: isBoyStudent ?? this.isBoyStudent,
      progressValue: progressValue ?? this.progressValue
    );
  }
}
