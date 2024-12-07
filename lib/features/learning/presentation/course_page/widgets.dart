import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:litlearn/core/entity/enrolled_course_entity.dart';
import 'package:litlearn/core/entity/video_entity.dart';
import 'package:litlearn/core/theme/palette.dart';
import 'package:litlearn/core/utils/calculate_duration.dart';
import 'package:litlearn/core/widgets/common.dart';
import 'package:litlearn/features/learning/presentation/course_page/bloc/course_page_bloc.dart';
import 'package:litlearn/features/learning/presentation/course_page/cubit/videos_cubit.dart';
import 'package:litlearn/features/learning/presentation/video_player_page/view.dart';

class CoursePageWidgets {
  static Widget infoSelection({
    required ValueNotifier<int> infoSectionIndex,
    required ValueNotifier<bool> isExpanded,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(
          color: ColorConstants.white,
          width: 1.r,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => infoSectionIndex.value = 0,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15.h),
                decoration: BoxDecoration(
                  color: infoSectionIndex.value == 0
                      ? ColorConstants.white
                      : ColorConstants.blue,
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(14.r),
                  ),
                ),
                child: Center(
                  child: kText(
                    text: 'About',
                    color: infoSectionIndex.value == 0
                        ? ColorConstants.blue
                        : ColorConstants.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => infoSectionIndex.value = 1,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15.h),
                decoration: BoxDecoration(
                  border: Border.symmetric(
                    vertical: BorderSide(
                      color: ColorConstants.white,
                      width: 1.r,
                    ),
                  ),
                  color: infoSectionIndex.value == 1
                      ? ColorConstants.white
                      : ColorConstants.blue,
                ),
                child: Center(
                  child: kText(
                    text: 'Lessons',
                    color: infoSectionIndex.value == 1
                        ? ColorConstants.blue
                        : ColorConstants.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => isExpanded.value = !isExpanded.value,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 5.h),
                decoration: BoxDecoration(
                  color: ColorConstants.blue,
                  borderRadius: BorderRadius.horizontal(
                    right: Radius.circular(14.r),
                  ),
                ),
                child: Center(
                  child: Transform.rotate(
                    angle: isExpanded.value ? -math.pi / 2 : math.pi / 2,
                    child: Icon(
                      Icons.navigate_before,
                      size: 24.r,
                      color: ColorConstants.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget videoItem(
      {required VideoEntity video,
      required EnrolledCourseEntity? enrolledStatus,
      required String courseId,
      required BuildContext context}) {
    final isVideoUnlocked =
        enrolledStatus != null && enrolledStatus.unlockCount >= video.seqCount;
    return GestureDetector(
      onTap: () async {
        if (isVideoUnlocked) {
          await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => VideoPlayerPage(
                    video: video,
                    enrolledCourseEntity: enrolledStatus,
                  )));

          context
              .read<CoursePageBloc>()
              .add(CoursePageEventGetCourseById(courseId));
        }
      },
      child: Container(
        padding: EdgeInsets.all(10.r),
        margin: EdgeInsets.symmetric(vertical: 8.h),
        decoration: BoxDecoration(
          color: ColorConstants.liteBlue,
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: Stack(
                children: [
                  Image.network(
                    video.thumbnailUrl,
                    height: 70.r,
                    width: 70.r,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    height: 70.r,
                    width: 70.r,
                    color: ColorConstants.blue
                        .withOpacity(isVideoUnlocked ? 0 : 0.6),
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.all(5.r),
                        decoration: BoxDecoration(
                          color: ColorConstants.white.withOpacity(0.4),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isVideoUnlocked
                              ? Icons.play_arrow_rounded
                              : Icons.lock,
                          color: ColorConstants.white,
                          size: 25.r,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            kWidth(10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  kText(
                    text: video.tilte,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    maxLines: 2,
                    color: ColorConstants.white,
                  ),
                  kHeight(10.h),
                  Row(
                    children: [
                      kText(
                        text: '#${video.seqCount + 1}',
                        fontSize: 13,
                        color: ColorConstants.greyWhite,
                        fontWeight: FontWeight.bold,
                      ),
                      kWidth(15.w),
                      Icon(
                        Icons.timer_outlined,
                        size: 15.r,
                        color: ColorConstants.greyWhite,
                      ),
                      kWidth(5.w),
                      kText(
                        text: formatDurationWithColon(video.durationInSeconds),
                        fontSize: 13,
                        color: ColorConstants.greyWhite,
                        fontWeight: FontWeight.bold,
                      ),
                      kWidth(15.w),
                      Icon(
                        Icons.language_sharp,
                        size: 15.r,
                        color: ColorConstants.greyWhite,
                      ),
                      kWidth(5.w),
                      kText(
                        text: video.language.toString(),
                        fontSize: 13,
                        color: ColorConstants.greyWhite,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
