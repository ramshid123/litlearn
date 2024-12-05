import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:litlearn/core/theme/palette.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerPage extends StatefulWidget {
  const VideoPlayerPage({super.key});

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late VideoPlayerController videoPlayerController;
  final currentSeek = ValueNotifier(const Duration(seconds: 0));
  final seekWidth = ValueNotifier(0.0);
  double maxWidth = double.infinity;
  Duration totalDuration = Duration(seconds: 0);
  final isPlaying = ValueNotifier(1);
  // 1 -> play
  // 0 -> pause
  // -1 -> buffering

  @override
  void initState() {
    // TODO: implement initState
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight],
    );

    videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(
        'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
      ),
    )..initialize().then((v) => setState(() {}));
    totalDuration = videoPlayerController.value.duration;
    videoPlayerController.play();

    videoPlayerController.addListener(() async {
      if (videoPlayerController.value.isBuffering) {
        isPlaying.value = -1;
      } else {
        isPlaying.value = 1;
      }
      currentSeek.value =
          await videoPlayerController.position ?? const Duration(seconds: 0);

      seekWidth.value = (maxWidth - 20.w) *
          (currentSeek.value.inMilliseconds / videoPlayerController.value.duration.inMilliseconds);

      log('width => ${ videoPlayerController.value.duration.inMilliseconds}');
    });

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.center,
        children: [
          AspectRatio(
            aspectRatio: videoPlayerController.value.aspectRatio,
            child: VideoPlayer(
              videoPlayerController,
            ),
          ),
          ValueListenableBuilder(
              valueListenable: isPlaying,
              builder: (context, _, __) {
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 50.h),
                  color: Colors.black.withOpacity(0.4),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () async {
                              await videoPlayerController.seekTo(
                                  (await videoPlayerController.position ??
                                          Duration(seconds: 0)) -
                                      Duration(seconds: 10));
                              await videoPlayerController.play();
                            },
                            child: Container(
                              padding: EdgeInsets.all(10.r),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black.withOpacity(0.4),
                              ),
                              child: Icon(
                                Icons.replay_10,
                                size: 150.r,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              if (isPlaying.value == 1) {
                                await videoPlayerController.pause();
                                isPlaying.value = 0;
                              } else if (isPlaying.value == 0) {
                                await videoPlayerController.play();
                                isPlaying.value = 1;
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.all(10.r),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black.withOpacity(0.4),
                              ),
                              child: Icon(
                                isPlaying.value == -1
                                    ? Icons.menu
                                    : (isPlaying.value == 0
                                        ? Icons.play_arrow_rounded
                                        : Icons.pause),
                                size: 150.r,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              await videoPlayerController.seekTo(
                                  (await videoPlayerController.position ??
                                          Duration(seconds: 0)) +
                                      Duration(seconds: 10));
                              await videoPlayerController.play();
                            },
                            child: Container(
                              padding: EdgeInsets.all(10.r),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black.withOpacity(0.4),
                              ),
                              child: Icon(
                                Icons.forward_10,
                                size: 150.r,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      LayoutBuilder(builder: (context, boxConstraints) {
                        maxWidth = boxConstraints.maxWidth;
                        return ValueListenableBuilder(
                            valueListenable: seekWidth,
                            builder: (context, _, __) {
                              return Container(
                                margin: EdgeInsets.symmetric(horizontal: 10.w),
                                height: 10.h,
                                width: double.infinity,
                                color: ColorConstants.white.withOpacity(0.5),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    height: 10.h,
                                    width: seekWidth.value,
                                    color: ColorConstants.blue,
                                  ),
                                ),
                              );
                            });
                      }),
                    ],
                  ),
                );
              }),
        ],
      ),
    );
  }
}
