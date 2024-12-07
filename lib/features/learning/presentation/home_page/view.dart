import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:litlearn/core/entity/course_entity.dart';
import 'package:litlearn/core/theme/palette.dart';
import 'package:litlearn/core/widgets/bottom_nav_bar.dart';
import 'package:litlearn/core/widgets/common.dart';
import 'package:litlearn/features/learning/presentation/home_page/bloc/home_page_bloc.dart';
import 'package:litlearn/features/learning/presentation/home_page/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    context.read<HomePageBloc>().add(HomePageEventGetCourses());
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
                padding: EdgeInsets.symmetric(vertical: 10.h),
                decoration: BoxDecoration(
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
                        Container(
                          padding: EdgeInsets.all(8.r),
                          decoration: BoxDecoration(
                            color: ColorConstants.white,
                            borderRadius: BorderRadius.circular(10.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                offset: Offset(0, 0),
                                blurRadius: 9,
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.search,
                            size: 35.r,
                            color: ColorConstants.blue,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(8.r),
                          decoration: BoxDecoration(
                            color: ColorConstants.white,
                            borderRadius: BorderRadius.circular(10.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                offset: Offset(0, 0),
                                blurRadius: 9,
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.notifications_outlined,
                            size: 35.r,
                            color: ColorConstants.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  clipBehavior: Clip.hardEdge,
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        kWidth(double.infinity),
                        kHeight(30.h),
                        kText(
                          text: 'What you want to\nlearn today?',
                          fontSize: 35,
                          color: ColorConstants.greyWhite,
                          fontWeight: FontWeight.bold,
                        ),
                        kHeight(30.h),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          clipBehavior: Clip.none,
                          child: Row(
                            children: [
                              for (int i = 0; i < 5; i++)
                                HomePageWidgets.categoryItem(
                                  index: i,
                                  text: 'Design',
                                  icon: Icons.design_services,
                                ),
                            ],
                          ),
                        ),
                        kHeight(30.h),
                        // kText(
                        //   text: 'Most Popular:',
                        //   fontSize: 27,
                        //   fontWeight: FontWeight.bold,
                        //   color: ColorConstants.greyWhite,
                        // ),
                        // kHeight(20.h),
                        BlocBuilder<HomePageBloc, HomePageState>(
                          buildWhen: (previous, current) {
                            if (current is HomePageStateCourses) {
                              return true;
                            }
                            return false;
                          },
                          builder: (context, state) {
                            List<CourseEntity> homePageCourses = [];
                            if (state is HomePageStateCourses) {
                              homePageCourses = state.courses;
                            }

                            if (homePageCourses.isEmpty) {
                              return CircularProgressIndicator();
                            } else {
                              return Column(
                                children: [
                                  for (int i = 0;
                                      i < homePageCourses.length;
                                      i++)
                                    HomePageWidgets.courseItem(
                                      courseEntity: homePageCourses[i],
                                      context: context,
                                    )
                                ],
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              KustomBottomNavBar.bottomNavBar(index: 0),
            ],
          ),
        ],
      ),
    );
  }
}
