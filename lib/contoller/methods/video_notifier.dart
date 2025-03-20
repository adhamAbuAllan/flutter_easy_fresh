import 'dart:developer';

import 'package:flutter/material.dart';
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

  Future<void> getAllVideos({
    String? listPlayId,
required BuildContext context
  }) async {
    state = state.copyWith(loading: true);
    List<VideoModel> allVideos = await ParentVideoNotifier()
        .getAllVideosFromPlaylist(listPlayId: listPlayId,
context: context
    );
    ref.read(currentPlayListIdNotifier.notifier).state =
        listPlayId ?? "PLiMj4nUvC2JiDluqq4-qM8sqeCNIb7sL9";

    List<VideoModel> filteredVideos = allVideos;
    final selectedFilterA = ref.read(videoFilterProvider);

    if (selectedFilterA == EnumVideoDurationFilter.under30) {
      filteredVideos =
          allVideos.where((video) {
            final String? rawDuration = video.videoDuration;

            if (rawDuration == null || rawDuration.isEmpty) {
              return false;
            }

            // Extract numbers from the duration string
            RegExp regex = RegExp(r'\d+'); // Finds any number in the string
            Match? match = regex.firstMatch(rawDuration);

            if (match == null) {
              return false;
            }
            int duration = int.parse(
              match.group(0)!,
            ); // Extract first number found

            return duration < 30;
          }).toList();
    } else if (selectedFilterA == EnumVideoDurationFilter.between30And60) {
      filteredVideos =
          allVideos.where((video) {
            final String? rawDuration = video.videoDuration;

            if (rawDuration == null || rawDuration.isEmpty) {
              return false;
            }

            // Extract numbers from the duration string
            RegExp regex = RegExp(r'\d+'); // Finds any number in the string
            Match? match = regex.firstMatch(rawDuration);

            if (match == null) {
              return false;
            }
            int duration = int.parse(
              match.group(0)!,
            ); // Extract first number found

            return duration >= 30 && duration <= 60;
          }).toList();
    } else if (selectedFilterA == EnumVideoDurationFilter.above60) {
      filteredVideos =
          allVideos.where((video) {
            final String? rawDuration = video.videoDuration;

            if (rawDuration == null || rawDuration.isEmpty) {
              return false;
            }

            // Extract numbers from the duration string
            RegExp regex = RegExp(r'\d+'); // Finds any number in the string
            Match? match = regex.firstMatch(rawDuration);

            if (match == null) {
              return false;
            }
            int duration = int.parse(
              match.group(0)!,
            ); // Extract first number found

            return duration > 60;
          }).toList();
    }
    log("a videoFilterProvider : ${ref.read(videoFilterProvider)}");

    state = state.copyWith(
      playListItems: filteredVideos,
      loading: false,
      noVideosFound: filteredVideos.isEmpty,
    );
  }
}
