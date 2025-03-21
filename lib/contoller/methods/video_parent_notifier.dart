import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../api/yt_video.dart';
import '../../const/app_const.dart';
import '../../const/localization.dart';

class ParentVideoNotifier {
  String baseUrl = "https://www.googleapis.com/youtube/v3/playlistItems";
  late Uri uri;

  Future<List<VideoModel>> getAllVideosFromPlaylist({
    String? listPlayId,
    required BuildContext context,
  }) async {
    if (listPlayId?.isEmpty ?? true) {
      listPlayId = "PLiMj4nUvC2JiDluqq4-qM8sqeCNIb7sL9";
    }
    debugPrint("Fetching videos for playlist ID: $listPlayId");

    List<VideoModel> allVideos = [];

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
        String videoDescription =
            videoData['snippet']['description'] ?? "No description available";

        var statsResponse = await http.get(
          Uri.parse(
            "https://www.googleapis.com/youtube/v3/videos?part=statistics&id=$videoId&key=${ApiKeys.youtubeApiKey}",
          ),
        );

        var statsData = jsonDecode(statsResponse.body);
        String viewsCount =
            statsData['items'].isNotEmpty
                ? (statsData['items'][0]['statistics']['viewCount'] ?? "0")
                : "0";

        String likeCount =
            statsData['items'].isNotEmpty
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
        } else {
          debugPrint("No content details found for videoId $videoId");
        }
      }

      // Fetch the next page token if available
    } else {
      log(
        "Unable to get data from YouTube API, status code: ${response.statusCode}, body: ${response.body}",
      );
    }

    return allVideos;
  }

  // try {
  //
  //   if (listPlayId?.isEmpty ?? true) {
  //     listPlayId = "PLiMj4nUvC2JiDluqq4-qM8sqeCNIb7sL9";
  //   }
  //   debugPrint("Fetching videos for playlist ID: $listPlayId");
  //
  //   List<VideoModel> allVideos = [];
  //
  //
  //   uri = Uri.parse(
  //     "$baseUrl?part=snippet&playlistId=$listPlayId&key=${ApiKeys
  //         .youtubeApiKey}",
  //   );
  //
  //   var response = await http.get(uri);
  //   if (response.statusCode == 200) {
  //     var jsonData = jsonDecode(response.body);
  //     if (jsonData['items'] == null) {
  //       debugPrint("No videos found for playlist ID: $listPlayId");
  //       return [];
  //     }
  //     List playListItems = jsonData['items'];
  //
  //     for (var videoData in playListItems) {
  //       var videoId = videoData['snippet']['resourceId']?['videoId'] ?? "";
  //       if (videoId.isEmpty) {
  //         debugPrint("Skipping video with missing videoId");
  //         continue;
  //       }
  //
  //       var statsResponse = await http.get(
  //         Uri.parse(
  //           "https://www.googleapis.com/youtube/v3/videos?part=statistics&id=$videoId&key=${ApiKeys.youtubeApiKey}",
  //         ),
  //       );
  //
  //       var statsData = jsonDecode(statsResponse.body);
  //       String viewsCount = statsData['items'].isNotEmpty
  //           ? (statsData['items'][0]['statistics']['viewCount'] ?? "0")
  //           : "0";
  //
  //       String likeCount = statsData['items'].isNotEmpty
  //           ? (statsData['items'][0]['statistics']['likeCount'] ?? "0")
  //           : "0";
  //
  //       var contentDetailsResponse = await http.get(
  //         Uri.parse(
  //           "https://www.googleapis.com/youtube/v3/videos?part=contentDetails&id=$videoId&key=${ApiKeys.youtubeApiKey}",
  //         ),
  //       );
  //
  //       var contentDetailsData = jsonDecode(contentDetailsResponse.body);
  //
  //       if (contentDetailsData['items'] != null &&
  //           contentDetailsData['items'].isNotEmpty) {
  //         var duration = contentDetailsData['items'][0]['contentDetails'];
  //         String isoDuration = duration['duration'];
  //
  //           debugPrint(
  //             "Raw Video Duration for videoId $videoId: $isoDuration",
  //           );
  //
  //           String videoDuration = formatDuration(isoDuration,context: context);
  //           debugPrint(
  //             "Formatted Video Duration for videoId $videoId: $videoDuration",
  //           );
  //
  //         String thumbnailUrl = videoData['snippet']['thumbnails']['maxres']
  //                 ?['url'] ??
  //             videoData['snippet']['thumbnails']['high']?['url'] ??
  //             "";
  //
  //           VideoModel video = VideoModel(
  //             videoId: videoId,
  //             videoTitle: videoData['snippet']['title'],
  //             thumbnailUrl: thumbnailUrl,
  //             viewsCount: formatCounts(
  //               value: viewsCount,
  //               isViews: true,
  //               context: context,
  //             ),
  //             likesCount: formatCounts(
  //               value: likeCount,
  //               isViews: false,
  //               context: context,
  //             ),
  //             videoDuration: videoDuration,
  //           );
  //
  //           allVideos.add(video);
  //           debugPrint("allVideos length: ${allVideos.length}");
  //         } else {
  //           debugPrint("No content details found for videoId $videoId");
  //         }
  //       }
  //
  //       // Fetch the next page token if available
  //     } else {
  //       log(
  //         "Unable to get data from YouTube API, status code: ${response.statusCode}, body: ${response.body}",
  //       );
  //     }
  //
  //   return allVideos;
  // }
  // catch (e) {
  //     log("Error fetching data from YouTube API: $e");
  //   }
  //
  //   return [];
  // }
  String formatCounts({
    required String value,
    required bool isViews,
    required BuildContext context,
  }) {
    int viewsNum = int.tryParse(value) ?? 0;

    if (viewsNum >= 1000000000) {
      return "${(viewsNum / 1000000000).toStringAsFixed(1)}B ${isViews ? SetLocalization.of(context)?.getTranslateValue("views") : "likes"}";
    } else if (viewsNum >= 1000000) {
      return "${(viewsNum / 1000000).toStringAsFixed(1)}${SetLocalization.of(context)?.getTranslateValue("M")} "
          "${isViews ? SetLocalization.of(context)?.getTranslateValue("views") : SetLocalization.of(context)?.getTranslateValue("likes")}";
    } else if (viewsNum >= 1000) {
      return "${(viewsNum / 1000).toStringAsFixed(1)}"
          "${SetLocalization.of(context)?.getTranslateValue("K")}"
          " ${isViews ? SetLocalization.of(context)?.getTranslateValue("views") : SetLocalization.of(context)?.getTranslateValue("likes")}";
    } else if (viewsNum >= 100) {
      return "${(viewsNum / 1).toStringAsFixed(0)}"
          " ${isViews ? SetLocalization.of(context)?.getTranslateValue("views") : SetLocalization.of(context)?.getTranslateValue("likes")}";
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
    return " $totalMinutes ${SetLocalization.of(context)?.getTranslateValue("minute")}";
  }
}

/*
  String formatCounts({
    required String value,
    required bool isViews,
    required BuildContext context,
  }) {
    int viewsNum = int.tryParse(value) ?? 0;

    if (viewsNum >= 1000000000) {
      return "${(viewsNum / 1000000000).toStringAsFixed(1)}B ${isViews ? SetLocalization.of(context)?.getTranslateValue("views") : "likes"}";
    } else if (viewsNum >= 1000000) {
      return "${(viewsNum / 1000000).toStringAsFixed(1)}${SetLocalization.of(context)?.getTranslateValue("M")} "
          "${isViews ? SetLocalization.of(context)?.getTranslateValue("views") : SetLocalization.of(context)?.getTranslateValue("likes")}";
    } else if (viewsNum >= 1000) {
      return "${(viewsNum / 1000).toStringAsFixed(1)}"
          "${SetLocalization.of(context)?.getTranslateValue("K")}"
          " ${isViews ? SetLocalization.of(context)?.getTranslateValue("views") : SetLocalization.of(context)?.getTranslateValue("likes")}";
    } else if (viewsNum >= 100) {
      return "${(viewsNum / 1).toStringAsFixed(0)}"
          " ${isViews ? SetLocalization.of(context)?.getTranslateValue("views") : SetLocalization.of(context)?.getTranslateValue("likes")}";
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
    return " $totalMinutes ${SetLocalization.of(context)?.getTranslateValue("minute")}";
  }
}
  */
