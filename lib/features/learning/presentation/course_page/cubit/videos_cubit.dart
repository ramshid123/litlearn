import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:litlearn/core/entity/video_entity.dart';
import 'package:litlearn/features/learning/domain/usecases/get_video_by_id.dart';
import 'package:meta/meta.dart';

class VideosCubit extends Cubit<List<VideoEntity>> {
  final UseCaseGetVideoById _useCaseGetVideoById;

  VideosCubit({required UseCaseGetVideoById useCaseGetVideoById})
      : _useCaseGetVideoById = useCaseGetVideoById,
        super([]);

  Future getVideos(List<String> videoIds) async {
    List<VideoEntity> videos = [];

    for (var id in videoIds) {
      final response =
          await _useCaseGetVideoById(UseCaseGetVideoByIdParams(id));
      response.fold(
        (l) {
          log(l.message);
        },
        (r) {
          videos.add(r);
        },
      );
    }
    videos.sort((a, b) => a.seqCount.compareTo(b.seqCount));

    emit(videos);
  }
}
