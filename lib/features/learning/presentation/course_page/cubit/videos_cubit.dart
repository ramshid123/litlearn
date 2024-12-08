import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:litlearn/core/entity/video_entity.dart';
import 'package:litlearn/features/learning/domain/usecases/get_video_by_id.dart';

class VideosCubit extends Cubit<VideosState> {
  final UseCaseGetVideoById _useCaseGetVideoById;

  VideosCubit({required UseCaseGetVideoById useCaseGetVideoById})
      : _useCaseGetVideoById = useCaseGetVideoById,
        super(VideosStateInitial());

  Future getVideos(List<String> videoIds) async {
    emit(VideosStateLoading());
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

    emit(VideosStateVideos(videos));
  }
}

@immutable
sealed class VideosState {}

final class VideosStateInitial extends VideosState {}

final class VideosStateLoading extends VideosState {}

final class VideosStateVideos extends VideosState {
  final List<VideoEntity> videos;

  VideosStateVideos(this.videos);
}
