import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:litlearn/core/entity/user_entity.dart';
import 'package:litlearn/core/global%20states/user%20state/bloc/user_bloc.dart';
import 'package:litlearn/core/theme/palette.dart';
import 'package:litlearn/core/widgets/bottom_nav_bar.dart';
import 'package:litlearn/core/widgets/common.dart';
import 'package:litlearn/features/learning/presentation/my_courses_page/bloc/my_courses_bloc.dart';
import 'package:litlearn/features/learning/presentation/my_courses_page/widgets.dart';

class MyCoursesPage extends StatefulWidget {
  const MyCoursesPage({super.key});

  @override
  State<MyCoursesPage> createState() => _MyCoursesPageState();
}

class _MyCoursesPageState extends State<MyCoursesPage> {
  late UserEntity storedUserData;

  @override
  void initState() {
    storedUserData =
        (context.read<UserBloc>().state as UserStateUserEntity).userEntity;
    // TODO: implement initState
    context
        .read<MyCoursesBloc>()
        .add(MyCoursesEventFetchCourses(storedUserData.userId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.white,
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  color: ColorConstants.liteBlue,
                ),
              ),
              Expanded(
                child: Container(
                  color: ColorConstants.white,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                decoration: BoxDecoration(
                  color: ColorConstants.liteBlue,
                ),
                child: kText(
                  text: 'My Courses',
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: ColorConstants.greyWhite,
                ),
                // child: Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 20.w),
                //   child: SafeArea(
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         Container(
                //           padding: EdgeInsets.all(8.r),
                //           decoration: BoxDecoration(
                //             color: ColorConstants.white,
                //             borderRadius: BorderRadius.circular(10.r),
                //             boxShadow: [
                //               BoxShadow(
                //                 color: Colors.black.withOpacity(0.5),
                //                 offset: Offset(0, 0),
                //                 blurRadius: 9,
                //                 spreadRadius: 0,
                //               ),
                //             ],
                //           ),
                //           child: Icon(
                //             Icons.search,
                //             size: 35.r,
                //             color: ColorConstants.blue,
                //           ),
                //         ),
                //         Container(
                //           padding: EdgeInsets.all(8.r),
                //           decoration: BoxDecoration(
                //             color: ColorConstants.white,
                //             borderRadius: BorderRadius.circular(10.r),
                //             boxShadow: [
                //               BoxShadow(
                //                 color: Colors.black.withOpacity(0.5),
                //                 offset: Offset(0, 0),
                //                 blurRadius: 9,
                //                 spreadRadius: 0,
                //               ),
                //             ],
                //           ),
                //           child: Icon(
                //             Icons.notifications_outlined,
                //             size: 35.r,
                //             color: ColorConstants.blue,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
              ),
              Expanded(
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  decoration: BoxDecoration(
                    color: ColorConstants.blue,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(50.r),
                      top: Radius.circular(25.r),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: ColorConstants.blue.withOpacity(0.5),
                        offset: Offset(0, -5.h),
                        blurRadius: 9,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    clipBehavior: Clip.none,
                    child: BlocBuilder<MyCoursesBloc, MyCoursesState>(
                      builder: (context, state) {
                        if (state is MyCoursesStateEnrolledCourses) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              kHeight(30.h),
                              if (state.courses.isNotEmpty)
                                for (var course in state.courses)
                                  MyCoursesPageWidgets.courseItem(
                                      courseEntity: course, context: context),
                              if (state.courses.isEmpty)
                                Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 100.h),
                                    child: kText(
                                      fontSize: 20,
                                      maxLines: 3,
                                      text:
                                          'You haven\'t enrolled in any courses yet.',
                                      color: ColorConstants.greyWhite
                                          .withOpacity(0.5),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              kHeight(30.h),
                            ],
                          );
                        } else if (state is MyCoursesStateLoading) {
                          return Align(
                            alignment: Alignment.center,
                            child: Container(
                              margin: EdgeInsets.only(top: 100.h),
                              height: 80.r,
                              width: 80.r,
                              padding: EdgeInsets.all(20.r),
                              decoration: BoxDecoration(
                                color: ColorConstants.white,
                                borderRadius: BorderRadius.circular(15.r),
                              ),
                              child: CircularProgressIndicator(
                                color: ColorConstants.blue,
                              ),
                            ),
                          );
                        } else {
                          return Align(
                            alignment: Alignment.center,
                            child: Container(
                              margin: EdgeInsets.only(top: 100.h),
                              padding: EdgeInsets.all(15.r),
                              decoration: BoxDecoration(
                                color: ColorConstants.white,
                                borderRadius: BorderRadius.circular(15.r),
                              ),
                              child: Icon(
                                Icons.replay,
                                color: ColorConstants.blue,
                                size: 30.r,
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),
              KustomBottomNavBar.bottomNavBar(index: 1),
            ],
          ),
        ],
      ),
    );
  }
}
