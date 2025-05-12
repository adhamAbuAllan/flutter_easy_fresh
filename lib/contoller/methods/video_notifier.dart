import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easy_fresh/contoller/methods/video_parent_notifier.dart';
import 'package:flutter_easy_fresh/contoller/methods/video_storage.dart';
import 'package:flutter_easy_fresh/session/new_session.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/video_model.dart';

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

  // Future<void> getAllVideos({
  //
  //   String? listPlayId,
  //   required BuildContext context,
  // }) async {
  //   if (state.loading) {
  //     return;
  //   }
  //
  //   final selectedFilter = ref.read(videoFilterProvider);
  //
  //
  //   // Use already fetched videos, apply filters
  //   if (state.playListItems?.isNotEmpty ?? false) {
  //     Map<EnumVideoDurationFilter, List<VideoModel>> categorizedVideos =
  //         categorizeVideos(state.playListItems ?? []);
  //
  //     ref.read(availableFiltersProvider.notifier).state =
  //         categorizedVideos.keys.toSet();
  //
  //     state = state.copyWith(
  //       playListItems: categorizedVideos[selectedFilter] ?? [],
  //       loading: true,
  //       noVideosFound: categorizedVideos[selectedFilter]!.isEmpty,
  //     );
  //     if (listPlayId == ref.watch(currentPlayListIdNotifier)) {
  //       debugPrint("$listPlayId == ${ref.read(currentPlayListIdNotifier)}");
  //       return;
  //     }
  //   }
  //   ref.read(currentPlayListIdNotifier.notifier).state =
  //       listPlayId ?? "PLFky0QidIsRVe6LCB_AmakRBALyqDOdN9";
  //
  //   List<VideoModel> storedVideos = await VideoStorage.getVideosForListId(
  //
  //     listPlayId,
  //   );
  //
  //   List<VideoModel> allVideos =
  //       storedVideos.isNotEmpty
  //           ? storedVideos
  //           : await fetchAllVideos(listPlayId, context);
  //
  //   await VideoStorage.saveVideos(allVideos, listPlayId);
  //
  //   Map<EnumVideoDurationFilter, List<VideoModel>> categorizedVideos =
  //       categorizeVideos(allVideos);
  //
  //   ref.read(availableFiltersProvider.notifier).state =
  //       categorizedVideos.keys.toSet();
  //
  //   state = state.copyWith(
  //     playListItems: categorizedVideos[selectedFilter] ?? [],
  //     loading: false,
  //     noVideosFound: categorizedVideos[selectedFilter]!.isEmpty,
  //   );
  // }
  Future<void> getAllVideos({
    String? listPlayId,
    required BuildContext context,
  }) async {
    if (state.loading) {
      return; // Avoid concurrent requests
    }

    final selectedFilter = ref.read(videoFilterProvider);
    final currentListPlayId = ref.read(currentPlayListIdNotifier);
    // Set the playlist ID if not provided
    listPlayId ??= "PLFky0QidIsRVe6LCB_AmakRBALyqDOdN9";
    NewSession.save("playListId", listPlayId);
    // Try to load from local storage first

    // if(currentListPlayId != listPlayId){
    //   if(storedVideos.isNotEmpty){
    //
    //   }
    // }
    // Check if we're working with the same playlist
    if (listPlayId == currentListPlayId &&
        (state.playListItems?.isNotEmpty ?? false)) {
      // If the playlist is already loaded, just apply the filter
      log("a playlist before categorizeVideos : ${state.playListItems}");

      Map<EnumVideoDurationFilter, List<VideoModel>> categorizedVideos =
          categorizeVideos(ref.read(allVideosProvider));
      log("a categorizedVideos : $categorizedVideos");
      state = state.copyWith(
        playListItems: categorizedVideos[selectedFilter] ?? [],
        loading: false,
        noVideosFound: categorizedVideos[selectedFilter]!.isEmpty,
      );
      log("playListItems : ${categorizedVideos[selectedFilter]}");
      debugPrint("Reused existing playlist data for $listPlayId");
      return;
    } else {
      log("it look like an storage is empty ");
    }

    // Mark as loading
    state = state.copyWith(loading: true);
    List<VideoModel> storedVideos = await VideoStorage.getVideosForListId(
      currentListPlayId,
    );
    List<VideoModel> allVideos =
        storedVideos.isNotEmpty
            ? storedVideos
            : await fetchAllVideos(listPlayId, context);

    // Save to storage if fetched from API
    if (storedVideos.isEmpty) {
      await VideoStorage.saveVideos(allVideos, listPlayId);
    }

    // Categorize videos by duration
    Map<EnumVideoDurationFilter, List<VideoModel>> categorizedVideos =
        categorizeVideos(allVideos);

    ref.read(availableFiltersProvider.notifier).state =
        categorizedVideos.keys.toSet();

    // Update the current playlist ID
    ref.read(currentPlayListIdNotifier.notifier).state = listPlayId;
    // Update filter visibility based on video availability

    // Update state with filtered videos
    state = state.copyWith(
      playListItems: categorizedVideos[selectedFilter] ?? [],
      loading: false,
      noVideosFound: categorizedVideos[selectedFilter]!.isEmpty,
    );
    ref.read(availableFiltersProvider.notifier).state =
        categorizedVideos.keys.toSet();
    ref.read(didHaveUnder30Min.notifier).state =
        categorizedVideos[EnumVideoDurationFilter.under30]!.isNotEmpty;
    ref.read(didHaveBetween30And60Min.notifier).state =
        categorizedVideos[EnumVideoDurationFilter.between30And60]!.isNotEmpty;
    ref.read(didHaveOver60Min.notifier).state =
        categorizedVideos[EnumVideoDurationFilter.above60]!.isNotEmpty;
  }

  Future<List<VideoModel>> fetchAllVideos(
    String? listPlayId,
    BuildContext context,
  ) async {
    List<VideoModel> allVideos = [];
    String? nextPageToken;

    do {
      final response = await ParentVideoNotifier().getAllVideosFromPlaylist(
        listPlayId: listPlayId,
        context: context,
        pageToken: nextPageToken,
        updateProgress:
            (progress) => state = state.copyWith(progressValue: progress),
      );
      allVideos.addAll(response.videos);
      nextPageToken = response.nextPageToken;
    } while (nextPageToken != null);
    ref.read(allVideosProvider.notifier).state = allVideos;
    return allVideos;
  }

  // Function to fetch all pages of videos
  // Future<List<VideoModel>> fetchAllVideos(
  //   String? listPlayId,
  //   BuildContext context,
  // ) async {
  //   List<VideoModel> allVideos = [];
  //   String? nextPageToken;
  //
  //   do {
  //     final result = await ParentVideoNotifier().getAllVideosFromPlaylist(
  //       updateProgress: (progress) {
  //         // WidgetsBinding.instance.addPostFrameCallback((_) {
  //         if (mounted) {
  //           state = state.copyWith(progressValue: progress);
  //         }
  //         // });
  //
  //       },
  //       listPlayId: listPlayId,
  //       context: context,
  //       pageToken: nextPageToken, // Pass nextPageToken if available
  //     );
  //
  //     allVideos.addAll(result.videos);
  //     nextPageToken =
  //         result.nextPageToken; // Get next page token from API response
  //   } while (nextPageToken != null &&
  //       nextPageToken.isNotEmpty); // Continue fetching if more pages exist
  //
  //   return allVideos;
  // }

  // Extract filtering logic into a separate function

  Map<EnumVideoDurationFilter, List<VideoModel>> categorizeVideos(
    List<VideoModel> allVideos,
  ) {
    Map<EnumVideoDurationFilter, List<VideoModel>> categorized = {
      EnumVideoDurationFilter.allVideos: [],
      EnumVideoDurationFilter.under30: [],
      EnumVideoDurationFilter.between30And60: [],
      EnumVideoDurationFilter.above60: [],
    };

    for (var video in allVideos) {
      final String? rawDuration = video.videoDuration;

      if (rawDuration == null || rawDuration.isEmpty) continue;

      RegExp regex = RegExp(r'\d+');
      Match? match = regex.firstMatch(rawDuration);
      if (match == null) continue;

      int duration = int.parse(match.group(0)!);

      categorized[EnumVideoDurationFilter.allVideos]!.add(video);

      if (duration < 30) {
        categorized[EnumVideoDurationFilter.under30]!.add(video);
      } else if (duration >= 30 && duration <= 60) {
        categorized[EnumVideoDurationFilter.between30And60]!.add(video);
      } else {
        log("above 60 try to fetching now ");
        categorized[EnumVideoDurationFilter.above60]!.add(video);
      }
    }

    return categorized;
  }
}
