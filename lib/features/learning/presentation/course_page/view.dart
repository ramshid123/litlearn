import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:litlearn/core/entity/enrolled_course_entity.dart';
import 'package:litlearn/core/entity/user_entity.dart';
import 'package:litlearn/core/global%20states/user%20state/bloc/user_bloc.dart';
import 'package:litlearn/core/theme/palette.dart';
import 'package:litlearn/core/utils/calculate_duration.dart';
import 'package:litlearn/core/widgets/common.dart';
import 'package:litlearn/features/learning/presentation/course_page/bloc/course_page_bloc.dart';
import 'package:litlearn/features/learning/presentation/course_page/cubit/enrolled_course_cubit.dart';
import 'package:litlearn/features/learning/presentation/course_page/cubit/videos_cubit.dart';
import 'package:litlearn/features/learning/presentation/course_page/widgets.dart';

class CoursePage extends StatefulWidget {
  final String courseId;
  const CoursePage({super.key, required this.courseId});

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  final isExpanded = ValueNotifier(false);
  final infoSectionIndex = ValueNotifier(0);
  late UserEntity storedUserData;

  final scrollController = ScrollController();

  @override
  void initState() {
    storedUserData =
        (context.read<UserBloc>().state as UserStateUserEntity).userEntity;

    context
        .read<CoursePageBloc>()
        .add(CoursePageEventGetCourseById(widget.courseId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MediaQuery.sizeOf(context);
    return BlocListener<CoursePageBloc, CoursePageState>(
      listener: (context, state) {
        if (state is CoursePageStateCourse) {
          context.read<VideosCubit>().getVideos(state.course.videoIds);
          context.read<EnrolledCourseCubit>().getEnrolledStatus(
              userId: storedUserData.userId, courseId: widget.courseId);
          // context
          //     .read<CoursePageBloc>()
          //     .add(CoursePageEventGetVideos(state.course.videoIds));
        }
      },
      child: Scaffold(
        backgroundColor: ColorConstants.liteBlue,
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              decoration: const BoxDecoration(
                color: ColorConstants.liteBlue,
                // boxShadow: [
                //   BoxShadow(
                //     color: ColorConstants.blue,
                //     offset: Offset(0, 5.h),
                //     blurRadius: 9,
                //     spreadRadius: 0,
                //   ),
                // ],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: SafeArea(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: EdgeInsets.all(8.r),
                          decoration: BoxDecoration(
                            color: ColorConstants.white,
                            borderRadius: BorderRadius.circular(10.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                offset: const Offset(0, 0),
                                blurRadius: 9,
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.navigate_before,
                            size: 35.r,
                            color: ColorConstants.blue,
                          ),
                        ),
                      ),
                      BlocBuilder<EnrolledCourseCubit, EnrolledCourseEntity?>(
                        builder: (context, enrolledStatus) {
                          return enrolledStatus != null
                              ? Container()
                              : Container(
                                  padding: EdgeInsets.all(8.r),
                                  decoration: BoxDecoration(
                                    color: ColorConstants.white,
                                    borderRadius: BorderRadius.circular(10.r),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.5),
                                        offset: const Offset(0, 0),
                                        blurRadius: 9,
                                        spreadRadius: 0,
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    Icons.bookmark_add_outlined,
                                    size: 35.r,
                                    color: ColorConstants.blue,
                                  ),
                                );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            BlocBuilder<CoursePageBloc, CoursePageState>(
              builder: (context, state) {
                if (state is CoursePageStateLoading) {
                  return Expanded(
                    child: Center(
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          padding: EdgeInsets.all(20.r),
                          decoration: BoxDecoration(
                            color: ColorConstants.white,
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          child: const CircularProgressIndicator(
                            color: ColorConstants.blue,
                          ),
                        ),
                      ),
                    ),
                  );
                } else if (state is CoursePageStateCourse) {
                  return Expanded(
                    child: Stack(
                      children: [
                        Container(
                          color: ColorConstants.liteBlue,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    kHeight(10.h),
                                    kText(
                                      text: state.course.category,
                                      fontSize: 16,
                                      color: ColorConstants.greyWhite,
                                    ),
                                    kText(
                                      text: state.course.courseName,
                                      fontSize: 30,
                                      maxLines: 10,
                                      color: ColorConstants.greyWhite,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    kHeight(20.h),
                                    Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.w, vertical: 10.h),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                            border: Border.all(
                                              color: ColorConstants.white,
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.play_lesson_outlined,
                                                size: 20.r,
                                                color: ColorConstants.white,
                                              ),
                                              kWidth(10.w),
                                              kText(
                                                text:
                                                    '${state.course.totalVideoCounts} lessons',
                                                fontSize: 17,
                                                color: ColorConstants.white,
                                              ),
                                            ],
                                          ),
                                        ),
                                        kWidth(20.w),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.w, vertical: 10.h),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                            border: Border.all(
                                              color: ColorConstants.white,
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.timer_outlined,
                                                size: 20.r,
                                                color: ColorConstants.white,
                                              ),
                                              kWidth(10.w),
                                              kText(
                                                text: calculateDurationInHourMin(
                                                    Duration(
                                                        milliseconds: int.parse(
                                                            state.course
                                                                .totalVideoHours))),
                                                fontSize: 17,
                                                color: ColorConstants.white,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    kHeight(20.h),
                                  ],
                                ),
                              ),
                              ValueListenableBuilder(
                                  valueListenable: isExpanded,
                                  builder: (context, _, __) {
                                    return Visibility(
                                      visible: !isExpanded.value,
                                      replacement: Container(),
                                      child: Expanded(
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20.w),
                                          decoration: BoxDecoration(
                                            color: ColorConstants.blue,
                                            borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(50.r),
                                            ),
                                          ),
                                          child: ValueListenableBuilder(
                                              valueListenable: infoSectionIndex,
                                              builder: (context, _, __) {
                                                return Column(
                                                  children: [
                                                    kHeight(25.h),
                                                    CoursePageWidgets
                                                        .infoSelection(
                                                      infoSectionIndex:
                                                          infoSectionIndex,
                                                      isExpanded: isExpanded,
                                                    ),
                                                    BlocBuilder<VideosCubit,
                                                        VideosState>(
                                                      builder: (context,
                                                          videosState) {
                                                        return BlocBuilder<
                                                            EnrolledCourseCubit,
                                                            EnrolledCourseEntity?>(
                                                          builder: (context,
                                                              enrolledStatus) {
                                                            if (videosState
                                                                is VideosStateLoading) {
                                                              return Expanded(
                                                                child: Center(
                                                                  child: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child:
                                                                        Container(
                                                                      padding: EdgeInsets
                                                                          .all(20
                                                                              .r),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: ColorConstants
                                                                            .white,
                                                                        borderRadius:
                                                                            BorderRadius.circular(15.r),
                                                                      ),
                                                                      child:
                                                                          const CircularProgressIndicator(
                                                                        color: ColorConstants
                                                                            .blue,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            } else if (videosState
                                                                is VideosStateVideos) {
                                                              return Expanded(
                                                                child:
                                                                    // child: ListView

                                                                    infoSectionIndex.value ==
                                                                            0
                                                                        ? CoursePageWidgets.aboutCourseSection(state
                                                                            .course)
                                                                        : ListView
                                                                            .builder(
                                                                            controller:
                                                                                scrollController,
                                                                            itemCount:
                                                                                videosState.videos.length,
                                                                            itemBuilder: (context, index) => CoursePageWidgets.videoItem(
                                                                                courseId: widget.courseId,
                                                                                context: context,
                                                                                video: videosState.videos[index],
                                                                                enrolledStatus: enrolledStatus),
                                                                          ),
                                                              );
                                                            }
                                                            return Container();
                                                          },
                                                        );
                                                      },
                                                    ),
                                                  ],
                                                );
                                              }),
                                        ),
                                      ),
                                    );
                                  }),
                            ],
                          ),
                        ),
                        ValueListenableBuilder(
                            valueListenable: isExpanded,
                            builder: (context, _, __) {
                              return Visibility(
                                visible: isExpanded.value,
                                replacement: Container(),
                                child: Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.w),
                                  color: ColorConstants.blue,
                                  child: ValueListenableBuilder(
                                      valueListenable: infoSectionIndex,
                                      builder: (context, _, __) {
                                        return Column(
                                          children: [
                                            kHeight(25.h),
                                            CoursePageWidgets.infoSelection(
                                              infoSectionIndex:
                                                  infoSectionIndex,
                                              isExpanded: isExpanded,
                                            ),
                                            BlocBuilder<VideosCubit,
                                                VideosState>(
                                              builder: (context, videosState) {
                                                return BlocBuilder<
                                                    EnrolledCourseCubit,
                                                    EnrolledCourseEntity?>(
                                                  builder: (context,
                                                      enrolledStatus) {
                                                    if (videosState
                                                        is VideosStateLoading) {
                                                      return Expanded(
                                                        child: Center(
                                                          child: Align(
                                                            alignment: Alignment
                                                                .center,
                                                            child: Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(
                                                                          20.r),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color:
                                                                    ColorConstants
                                                                        .white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15.r),
                                                              ),
                                                              child:
                                                                  const CircularProgressIndicator(
                                                                color:
                                                                    ColorConstants
                                                                        .blue,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    } else if (videosState
                                                        is VideosStateVideos) {
                                                      return Expanded(
                                                        child:
                                                            // child: ListView

                                                            infoSectionIndex
                                                                        .value ==
                                                                    0
                                                                ? CoursePageWidgets
                                                                    .aboutCourseSection(
                                                                        state
                                                                            .course)
                                                                : ListView
                                                                    .builder(
                                                                    controller:
                                                                        scrollController,
                                                                    itemCount: videosState
                                                                        .videos
                                                                        .length,
                                                                    itemBuilder: (context, index) => CoursePageWidgets.videoItem(
                                                                        courseId:
                                                                            widget
                                                                                .courseId,
                                                                        context:
                                                                            context,
                                                                        video: videosState.videos[
                                                                            index],
                                                                        enrolledStatus:
                                                                            enrolledStatus),
                                                                  ),
                                                      );
                                                    }
                                                    return Container();
                                                  },
                                                );
                                              },
                                            ),
                                          ],
                                        );
                                      }),
                                ),
                              );
                            }),
                      ],
                    ),
                  );
                } else if (state is CoursePageStateFailure) {
                  return kText(text: state.errorMsg);
                } else {
                  return Container();
                }
              },
            ),
            BlocBuilder<VideosCubit, VideosState>(
              builder: (context, videoState) {
                return BlocBuilder<EnrolledCourseCubit, EnrolledCourseEntity?>(
                  builder: (context, enrolledCourse) {
                    if (enrolledCourse != null ||
                        videoState is VideosStateLoading ||
                        videoState is VideosStateInitial) {
                      return const SizedBox();
                    } else {
                      return GestureDetector(
                        onTap: () async {
                          await context
                              .read<EnrolledCourseCubit>()
                              .enrollCourse(
                                  courseId: widget.courseId,
                                  userId: storedUserData.userId);

                          if (context.mounted) {
                            context.read<CoursePageBloc>().add(
                                CoursePageEventGetCourseById(widget.courseId));
                          }
                        },
                        child: Container(
                          color: ColorConstants.white,
                          padding: EdgeInsets.symmetric(vertical: 15.h),
                          child: Center(
                            child: kText(
                              text: 'Enroll Now',
                              color: ColorConstants.blue,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    }
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
