import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../const/video_duration_filter.dart';
import '../methods/video_filter_notifier.dart';
import '../methods/video_notifier.dart';
import '../status/video_status.dart';

// final videoProvider = StateNotifierProvider<GetVideos, List<YtVideo>>(
//       (ref) => GetVideos(),
// );
final videoNotifierProvider =
    StateNotifierProvider<VideoFilterNotifier, VideoState>(
      (ref) => VideoFilterNotifier(ref),
    );

final videoFilterProvider =
    StateNotifierProvider<UpdateFilterNotifier, EnumVideoDurationFilter>(
      (ref) => UpdateFilterNotifier(),
    );
final currentPlayListIdNotifier = StateProvider<String>((ref) => '');
