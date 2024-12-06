import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:litlearn/core/entity/video_entity.dart';

class VideoModel extends VideoEntity {
  VideoModel(
      {required super.videoId,
      required super.tilte,
      required super.durationInSeconds,
      required super.seqCount,
      required super.language,
      required super.videoUrl,
      required super.thumbnailUrl});

  factory VideoModel.fromJson(
      QueryDocumentSnapshot<Map<String, dynamic>> json) {
    return VideoModel(
      videoId: json.data()['video_id'],
      tilte: json.data()['title'],
      durationInSeconds: int.parse(json.data()['duration'].toString()),
      seqCount: int.parse(json.data()['seq_count'].toString()),
      language: json.data()['language'],
      videoUrl: json.data()['video_url'],
      thumbnailUrl: json.data()['thumbnail_url'],
    );
  }

  factory VideoModel.fromEntity(VideoEntity videoEntity) {
    return VideoModel(
      videoId: videoEntity.videoId,
      tilte: videoEntity.tilte,
      durationInSeconds: videoEntity.durationInSeconds,
      seqCount: videoEntity.seqCount,
      language: videoEntity.language,
      videoUrl: videoEntity.videoUrl,
      thumbnailUrl: videoEntity.thumbnailUrl,
    );
  }

  Map<String, dynamic> toJson(VideoModel videoModel) {
    return {
      'video_id': videoModel.videoId,
      'title': videoModel.tilte,
      'duration': videoModel.durationInSeconds,
      'seq_count': videoModel.seqCount,
      'language': videoModel.language,
      'video_url': videoModel.videoUrl,
      'thumbnail_url': videoModel.thumbnailUrl,
    };
  }
}
