import 'package:hive/hive.dart';

part 'video_model.g.dart'; // ✅ Ensure this line is present

@HiveType(typeId: 0)
class VideoModel extends HiveObject {
  @HiveField(0)
  final String videoId;

  @HiveField(1)
  final String videoTitle;

  @HiveField(2)
  final String thumbnailUrl;

  @HiveField(3)
  final String viewsCount;

  @HiveField(4)
  final String likesCount;

  @HiveField(5)
  final String? videoDuration;

  @HiveField(6)
  final String videoDescription;
  @HiveField(7)
  final String? listPlayId;

  VideoModel({
    required this.videoId,
    required this.videoTitle,
    required this.thumbnailUrl,
    required this.viewsCount,
    required this.likesCount,
    this.videoDuration,
    required this.videoDescription,
     this.listPlayId,
  });
}