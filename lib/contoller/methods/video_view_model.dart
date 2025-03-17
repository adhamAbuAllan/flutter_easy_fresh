import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/yt_video.dart';
import '../../const/app_const.dart';

class ParentVideoNotifier {
  String baseUrl = "https://www.googleapis.com/youtube/v3/playlistItems";
  late Uri uri;

  Future<List<YtVideo>> getAllVideosFromPlaylist({
    String? listPlayId
  }) async {
    try {

      if (listPlayId?.isEmpty ?? true) {
        listPlayId = "PLiMj4nUvC2JiDluqq4-qM8sqeCNIb7sL9";
      }
      debugPrint("Fetching videos for playlist ID: $listPlayId");

      List<YtVideo> allVideos = [];

      uri = Uri.parse(
        "$baseUrl?part=snippet&playlistId=$listPlayId&key=${ApiKeys.youtubeApiKey}",
      );

      var response = await http.get(uri);
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        if (jsonData['items'] == null) {
          debugPrint("No videos found for playlist ID: $listPlayId");
          return [];
        }
        List playListItems = jsonData['items'];

        for (var videoData in playListItems) {
          var videoId = videoData['snippet']['resourceId']?['videoId'] ?? "";
          if (videoId.isEmpty) {
            debugPrint("Skipping video with missing videoId");
            continue;
          }

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

            String videoDuration = formatDuration(isoDuration);
            debugPrint(
              "Formatted Video Duration for videoId $videoId: $videoDuration",
            );

            String thumbnailUrl = videoData['snippet']['thumbnails']['maxres']
                    ?['url'] ??
                videoData['snippet']['thumbnails']['high']?['url'] ??
                "";

            YtVideo video = YtVideo(
              videoId: videoId,
              videoTitle: videoData['snippet']['title'],
              thumbnailUrl: thumbnailUrl,
              viewsCount: formatCounts(value: viewsCount, isViews: true),
              likesCount: formatCounts(value: likeCount, isViews: false),
              videoDuration: videoDuration,
            );

            allVideos.add(video);
          } else {
            debugPrint("No content details found for videoId $videoId");
          }
        }
        return allVideos; // ✅ Always return the list
      } else {
        log(
          "Unable to get data from YouTube API, status code: ${response.statusCode}, body: ${response.body}",
        );
      }
    } catch (e) {
      log("Error fetching data from YouTube API: $e");
    }

    return []; // ✅ Ensure a return value in case of an error
  }

  String formatCounts({required String value, required bool isViews}) {
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

  String formatDuration(String isoDuration) {
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
    return "$totalMinutes m ${seconds}s";
  }
}
