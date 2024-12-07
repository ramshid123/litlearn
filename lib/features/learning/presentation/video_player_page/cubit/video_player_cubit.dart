import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:litlearn/core/entity/video_entity.dart';
import 'package:litlearn/features/learning/domain/usecases/get_video_by_id.dart';
import 'package:litlearn/features/learning/domain/usecases/update_enrolled_course_seqcount.dart';
import 'package:meta/meta.dart';

part 'video_player_state.dart';

class VideoPlayerCubit extends Cubit<VideoPlayerState> {
  final UseCaseUpdateEnrolledVideoSeqCount _useCaseUpdateEnrolledVideoSeqCount;

  VideoPlayerCubit({
    required UseCaseGetVideoById useCaseGetVideoById,
    required UseCaseUpdateEnrolledVideoSeqCount
        useCaseUpdateEnrolledVideoSeqCount,
  })  : _useCaseUpdateEnrolledVideoSeqCount =
            useCaseUpdateEnrolledVideoSeqCount,
        super(VideoPlayerInitial());

  void loadVideo() {
    emit(VideoPlayerStateLoadVideo());
  }

  Future updateSeqCount(
      {required String courseId, required String userId}) async {
    final response = await _useCaseUpdateEnrolledVideoSeqCount(
        UseCaseUpdateEnrolledVideoSeqCountParams(
            courseId: courseId, userId: userId));

    response.fold(
      (l) {
        log(l.message);
      },
      (r) {
        emit(VideoPlayerStateFinishedWatch());
      },
    );
  }
}
