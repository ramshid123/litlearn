import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:litlearn/core/entity/enrolled_course_entity.dart';
import 'package:litlearn/core/entity/video_entity.dart';
import 'package:litlearn/core/global%20states/user%20state/bloc/user_bloc.dart';
import 'package:litlearn/core/theme/palette.dart';
import 'package:litlearn/core/utils/calculate_duration.dart';
import 'package:litlearn/core/widgets/common.dart';
import 'package:litlearn/features/learning/presentation/video_player_page/cubit/video_player_cubit.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerPage extends StatefulWidget {
  // final videoId = '1733441710930';
  final VideoEntity video;
  final EnrolledCourseEntity enrolledCourseEntity;
  const VideoPlayerPage(
      {super.key, required this.video, required this.enrolledCourseEntity});

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  bool isVideoEnded = false;

  late VideoPlayerController videoPlayerController;

  final seekPosition = ValueNotifier(0.0);
  final playBackState = ValueNotifier(VideoPlayBackState.buffering);

  @override
  void initState() {
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft],
    );

    videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.video.videoUrl))
          ..initialize().then((data) {
            setState(() {
              videoPlayerController.play();
              playBackState.value = VideoPlayBackState.playing;
            });
          });

    videoPlayerController.addListener(() {
      if (videoPlayerController.value.duration.inMilliseconds > 0) {
        seekPosition.value =
            videoPlayerController.value.position.inMilliseconds /
                videoPlayerController.value.duration.inMilliseconds;
      }
      if (videoPlayerController.value.duration ==
              videoPlayerController.value.position &&
          videoPlayerController.value.duration.inMilliseconds != 0 &&
          !isVideoEnded) {
        isVideoEnded = true;
        onVideoEnd(
            courseId: widget.enrolledCourseEntity.courseId,
            userId: widget.enrolledCourseEntity.userId);
      }
    });
    context.read<VideoPlayerCubit>().loadVideo();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp],
    );
    super.dispose();
  }

  final ValueNotifier<double> _overlayOpacity = ValueNotifier<double>(0.0);

  void _toggleOverlay() {
    _overlayOpacity.value > 0
        ? _overlayOpacity.value = 0.0
        : _overlayOpacity.value = 1.0;
  }

  Future onVideoEnd({
    required String courseId,
    required String userId,
  }) async {
    if (widget.video.seqCount == widget.enrolledCourseEntity.unlockCount) {
      await context
          .read<VideoPlayerCubit>()
          .updateSeqCount(courseId: courseId, userId: userId);
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return BlocListener<VideoPlayerCubit, VideoPlayerState>(
      listener: (context, state) {
        if (state is VideoPlayerStateFinishedWatch) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: BlocBuilder<VideoPlayerCubit, VideoPlayerState>(
          builder: (context, state) {
            return Stack(
              alignment: Alignment.center,
              children: [
                Center(
                  child: state is VideoPlayerStateLoadVideo
                      ? AspectRatio(
                          aspectRatio: videoPlayerController.value.aspectRatio,
                          child: VideoPlayer(
                            videoPlayerController,
                          ),
                        )
                      : SizedBox(
                          height: size.height,
                          width: size.width,
                        ),
                ),
                state is VideoPlayerStateLoadVideo
                    ? GestureDetector(
                        onTap: _toggleOverlay,
                        child: Container(
                          height: size.height,
                          width: size.width,
                          child: ValueListenableBuilder(
                              valueListenable: _overlayOpacity,
                              builder: (context, opacity, __) {
                                return AnimatedOpacity(
                                  opacity: opacity,
                                  duration: const Duration(milliseconds: 500),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20.w, vertical: 30.h),
                                    height: size.height,
                                    width: size.width,
                                    color: Colors.black.withOpacity(0.7),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            // Seek -10
                                            GestureDetector(
                                              onTap: () async {
                                                if (opacity != 0) {
                                                  await videoPlayerController
                                                      .seekTo(Duration(
                                                          milliseconds:
                                                              videoPlayerController
                                                                      .value
                                                                      .position
                                                                      .inMilliseconds -
                                                                  10000));
                                                } else {
                                                  _toggleOverlay();
                                                }
                                              },
                                              child: Container(
                                                padding: EdgeInsets.all(15.r),
                                                decoration: BoxDecoration(
                                                  color: Colors.white
                                                      .withOpacity(0.7),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Icon(
                                                  Icons.replay_10_outlined,
                                                  color: ColorConstants.blue,
                                                  size: 150.r,
                                                ),
                                              ),
                                            ),

                                            // Play pause
                                            GestureDetector(
                                              onTap: () {
                                                if (opacity != 0) {
                                                  if (videoPlayerController
                                                      .value.isPlaying) {
                                                    videoPlayerController
                                                        .pause();
                                                    playBackState.value =
                                                        VideoPlayBackState
                                                            .paused;
                                                  } else {
                                                    videoPlayerController
                                                        .play();
                                                    playBackState.value =
                                                        VideoPlayBackState
                                                            .playing;
                                                  }
                                                } else {
                                                  _toggleOverlay();
                                                }
                                              },
                                              child: ValueListenableBuilder(
                                                  valueListenable:
                                                      playBackState,
                                                  builder: (context, _, __) {
                                                    return Container(
                                                      padding:
                                                          EdgeInsets.all(15.r),
                                                      decoration: BoxDecoration(
                                                        color: Colors.white
                                                            .withOpacity(0.7),
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: playBackState
                                                                  .value ==
                                                              VideoPlayBackState
                                                                  .buffering
                                                          ? Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(
                                                                          30.r),
                                                              child:
                                                                  CircularProgressIndicator(
                                                                color:
                                                                    ColorConstants
                                                                        .blue,
                                                              ),
                                                            )
                                                          : Icon(
                                                              playBackState
                                                                          .value ==
                                                                      VideoPlayBackState
                                                                          .playing
                                                                  ? Icons.pause
                                                                  : Icons
                                                                      .play_arrow,
                                                              color:
                                                                  ColorConstants
                                                                      .blue,
                                                              size: 150.r,
                                                            ),
                                                    );
                                                  }),
                                            ),

                                            // Seek +10
                                            GestureDetector(
                                              onTap: () async {
                                                if (opacity != 0) {
                                                  await videoPlayerController
                                                      .seekTo(Duration(
                                                          milliseconds:
                                                              videoPlayerController
                                                                      .value
                                                                      .position
                                                                      .inMilliseconds +
                                                                  10000));
                                                } else {
                                                  _toggleOverlay();
                                                }
                                              },
                                              child: Container(
                                                padding: EdgeInsets.all(15.r),
                                                decoration: BoxDecoration(
                                                  color: Colors.white
                                                      .withOpacity(0.7),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Icon(
                                                  Icons.forward_10_outlined,
                                                  color: ColorConstants.blue,
                                                  size: 150.r,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        ValueListenableBuilder(
                                            valueListenable: seekPosition,
                                            builder: (context, _, __) {
                                              return Column(
                                                children: [
                                                  Container(
                                                    height: 5.h,
                                                    width: double.infinity,
                                                    color: ColorConstants.blue
                                                        .withOpacity(0.3),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: LayoutBuilder(
                                                          builder: (context,
                                                              boxConstraints) {
                                                        return Container(
                                                          height: 5.h,
                                                          width: boxConstraints
                                                                  .maxWidth *
                                                              seekPosition
                                                                  .value,
                                                          color: ColorConstants
                                                              .blue,
                                                        );
                                                      }),
                                                    ),
                                                  ),
                                                  kHeight(15.h),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: kText(
                                                      text:
                                                          '${formatDurationWithColon(videoPlayerController.value.position.inSeconds)} / ${formatDurationWithColon(videoPlayerController.value.duration.inSeconds)}',
                                                      fontSize: 7,
                                                    ),
                                                  ),
                                                ],
                                              );
                                            }),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                      )
                    : Container(
                        padding: EdgeInsets.all(15.r),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.7),
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(30.r),
                          child: CircularProgressIndicator(
                            color: ColorConstants.blue,
                          ),
                        ),
                      ),
              ],
            );
          },
        ),
      ),
    );
  }
}

enum VideoPlayBackState {
  playing,
  paused,
  buffering,
  finished,
}
