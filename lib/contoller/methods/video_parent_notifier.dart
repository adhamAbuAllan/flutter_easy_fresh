import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_easy_fresh/api/video_model.dart';
import 'package:http/http.dart' as http;

import '../../const/app_const.dart';

class ParentVideoNotifier {
  String baseUrl = "https://www.googleapis.com/youtube/v3/playlistItems";
  late Uri uri;
  double progressValue = 0.0;  // Add progress tracking

  Future<PlaylistResponse> getAllVideosFromPlaylist({
    String? listPlayId,
    required BuildContext context,
    String? pageToken, // For pagination
    required Function(double progress) updateProgress, // Progress update callback
  }) async {
    if (listPlayId?.isEmpty ?? true) {
      listPlayId = "PLFky0QidIsRVe6LCB_AmakRBALyqDOdN9";
    }
    debugPrint("Fetching videos for playlist ID: $listPlayId");

    List<VideoModel> allVideos = [];
    uri = Uri.parse(
      "$baseUrl?part=snippet&playlistId=$listPlayId&key=${ApiKeys.youtubeApiKey}"
          "&maxResults=50&pageToken=${pageToken ?? ''}",
    );

    var response = await http.get(uri);
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      if (jsonData['items'] == null) {
        debugPrint("No videos found for playlist ID: $listPlayId");
        return PlaylistResponse(videos: [], nextPageToken: null);
      }

      List playListItems = jsonData['items'];
      String? nextPageToken = jsonData['nextPageToken']; // Get next page token

      // Update progress: 50% after fetching the video list
      updateProgress(0.5);

      int videoCount = playListItems.length;
      int processedVideos = 0;

      for (var videoData in playListItems) {
        var videoId = videoData['snippet']['resourceId']?['videoId'] ?? "";
        if (videoId.isEmpty) {
          debugPrint("Skipping video with missing videoId");
          continue;
        }

        String videoDescription =
            videoData['snippet']['description'] ?? "No description available";

        var statsResponse = await http.get(
          Uri.parse(
            "https://www.googleapis.com/youtube/v3/videos?part=statistics&id=$videoId&key=${ApiKeys.youtubeApiKey}",
          ),
        );

        var statsData = jsonDecode(statsResponse.body);
        String viewsCount = statsData['items'].isNotEmpty
            ? (statsData['items'][0]['statistics']['viewCount'] ?? "0")
            : "0";

        String likeCount = statsData['items'].isNotEmpty
            ? (statsData['items'][0]['statistics']['likeCount'] ?? "0")
            : "0";

        var contentDetailsResponse = await http.get(
          Uri.parse(
            "https://www.googleapis.com/youtube/v3/videos?part=contentDetails&id=$videoId&key=${ApiKeys.youtubeApiKey}",
          ),
        );

        var contentDetailsData = jsonDecode(contentDetailsResponse.body);

        if (contentDetailsData['items'] != null &&
            contentDetailsData['items'].isNotEmpty) {
          var duration = contentDetailsData['items'][0]['contentDetails'];
          String isoDuration = duration['duration'];

          debugPrint("Raw Video Duration for videoId $videoId: $isoDuration");

          String videoDuration = formatDuration(isoDuration, context: context);
          debugPrint(
            "Formatted Video Duration for videoId $videoId: $videoDuration",
          );

          String thumbnailUrl =
              videoData['snippet']['thumbnails']['maxres']?['url'] ??
                  videoData['snippet']['thumbnails']['high']?['url'] ??
                  "";

          VideoModel video = VideoModel(
            videoId: videoId,
            videoTitle: videoData['snippet']['title'],
            thumbnailUrl: thumbnailUrl,
            videoDescription: videoDescription,
            viewsCount: formatCounts(
              value: viewsCount,
              isViews: true,
              context: context,
            ),
            likesCount: formatCounts(
              value: likeCount,
              isViews: false,
              context: context,
            ),
            videoDuration: videoDuration,
          );

          allVideos.add(video);
          debugPrint("allVideos length: ${allVideos.length}");

          // Update progress: Increment based on processed video
          processedVideos++;
          updateProgress(0.5 + (0.5 * processedVideos / videoCount));
        } else {
          debugPrint("No content details found for videoId $videoId");
        }
      }

      return PlaylistResponse(videos: allVideos, nextPageToken: nextPageToken);
    } else {
      log(
        "Unable to get data from YouTube API, status code: ${response.statusCode}, body: ${response.body}",
      );
      return PlaylistResponse(videos: [], nextPageToken: null);
    }
  }

  String formatCounts({
    required String value,
    required bool isViews,
    required BuildContext context,
  }) {
    int viewsNum = int.tryParse(value) ?? 0;

    if (viewsNum >= 1000000000) {
      return "${(viewsNum / 1000000000).toStringAsFixed(1)}B ${isViews ? "views" : "likes"}";
    } else if (viewsNum >= 1000000) {
      return "${(viewsNum / 1000000).toStringAsFixed(1)}M ${isViews ? "views" : "likes"}";
    } else if (viewsNum >= 1000) {
      return "${(viewsNum / 1000).toStringAsFixed(1)}K ${isViews ? "views" : "likes"}";
    } else {
      return value;
    }
  }

  String formatDuration(String isoDuration, {required BuildContext context}) {
    RegExp regExp = RegExp(r"PT(\d+H)?(\d+M)?(\d+S)?");
    var matches = regExp.firstMatch(isoDuration);

    int hours = 0, minutes = 0, seconds = 0;

    if (matches != null) {
      hours = int.tryParse(matches.group(1)?.replaceAll("H", "") ?? "0") ?? 0;
      minutes = int.tryParse(matches.group(2)?.replaceAll("M", "") ?? "0") ?? 0;
      seconds = int.tryParse(matches.group(3)?.replaceAll("S", "") ?? "0") ?? 0;
    }

    if (hours == 0 && minutes == 0 && seconds == 0) {
      return "Unavailable";
    }

    int totalMinutes = hours * 60 + minutes;
    return " $totalMinutes min";
  }
}

class PlaylistResponse {
  final List<VideoModel> videos;
  final String? nextPageToken;

  PlaylistResponse({required this.videos, required this.nextPageToken});
}