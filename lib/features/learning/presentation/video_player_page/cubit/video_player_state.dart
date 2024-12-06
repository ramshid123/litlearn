part of 'video_player_cubit.dart';

@immutable
sealed class VideoPlayerState {}

final class VideoPlayerInitial extends VideoPlayerState {}

final class VideoPlayerStateLoading extends VideoPlayerState {}

final class VideoPlayerStateLoadVideo extends VideoPlayerState {
  final VideoEntity video;

  VideoPlayerStateLoadVideo(this.video);
}
