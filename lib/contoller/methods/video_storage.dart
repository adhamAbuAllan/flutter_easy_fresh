import 'package:hive/hive.dart';

import '../../api/video_model.dart';

class VideoStorage {
  static Future<List<VideoModel>> getVideosForListId(String? listPlayId) async {
    final box = await Hive.openBox<VideoModel>('videos');
    return box.values.where((video) => video.listPlayId == listPlayId).toList();
  }

  static Future<void> saveVideos(List<VideoModel> videos, String? listPlayId) async {
    final box = await Hive.openBox<VideoModel>('videos');
    for (var video in videos) {
      await box.put('$listPlayId-${video.videoId}', video);
    }
  }
}