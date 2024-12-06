import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:litlearn/core/entity/video_entity.dart';
import 'package:litlearn/features/learning/domain/usecases/get_video_by_id.dart';
import 'package:meta/meta.dart';

part 'video_player_state.dart';

class VideoPlayerCubit extends Cubit<VideoPlayerState> {
  final UseCaseGetVideoById _useCaseGetVideoById;

  VideoPlayerCubit({
    required UseCaseGetVideoById useCaseGetVideoById,
  })  : _useCaseGetVideoById = useCaseGetVideoById,
        super(VideoPlayerInitial());

  Future initialiseVideo(String videoId) async {
    emit(VideoPlayerStateLoading());
    final response =
        await _useCaseGetVideoById(UseCaseGetVideoByIdParams(videoId));

    response.fold(
      (l) {
        log(l.message);
      },
      (r) {
        log('video => ${r.videoUrl}');
        emit(VideoPlayerStateLoadVideo(r));
      },
    );
  }
}
