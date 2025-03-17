import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../const/video_duration_filter.dart';

class UpdateFilterNotifier extends StateNotifier<EnumVideoDurationFilter> {
  UpdateFilterNotifier() : super(EnumVideoDurationFilter.allVideos);

  void updateFilter(EnumVideoDurationFilter filter) {
    state = filter;
  }
}