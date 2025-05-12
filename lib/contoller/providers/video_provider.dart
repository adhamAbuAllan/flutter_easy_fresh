import 'package:flutter/cupertino.dart';
import 'package:flutter_easy_fresh/api/video_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../const/video_duration_filter.dart';
import '../methods/video_filter_notifier.dart';
import '../methods/video_notifier.dart';
import '../status/video_status.dart';
final videoNotifierProvider =
    StateNotifierProvider<VideoFilterNotifier, VideoState>(
      (ref) => VideoFilterNotifier(ref),
    );
final availableFiltersProvider =
StateProvider<Set<EnumVideoDurationFilter>>((ref) => {});

final videoFilterProvider =
    StateNotifierProvider<UpdateFilterNotifier, EnumVideoDurationFilter>(
      (ref) => UpdateFilterNotifier(),
    );
final currentPlayListIdNotifier = StateProvider<String>((ref) => '');
final horizontalScrollController = Provider<ScrollController>((ref) {
    return ScrollController();
});
// a list of videoModel
final allVideosProvider = StateProvider<List<VideoModel>>((ref) => []);
//boolean value
final isFirstTimeLoadList = StateProvider<bool>((ref) => false);
final didHaveUnder30Min = StateProvider<bool>((ref) => false);
final didHaveBetween30And60Min = StateProvider<bool>((ref) => false);
final didHaveOver60Min = StateProvider<bool>((ref) => false);
