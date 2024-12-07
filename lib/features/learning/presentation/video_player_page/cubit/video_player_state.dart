part of 'video_player_cubit.dart';

@immutable
sealed class VideoPlayerState {}

final class VideoPlayerInitial extends VideoPlayerState {}

final class VideoPlayerStateLoading extends VideoPlayerState {}

// final class VideoPlayerStateGetVideo extends VideoPlayerState {
//   final VideoEntity video;

//   VideoPlayerStateGetVideo(this.video);
// }

final class VideoPlayerStateLoadVideo extends VideoPlayerState {}

final class VideoPlayerStateFinishedWatch extends VideoPlayerState {}
