import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:litlearn/core/theme/palette.dart';
import 'package:litlearn/core/widgets/bottom_nav_bar.dart';
import 'package:litlearn/core/widgets/common.dart';
import 'package:litlearn/features/learning/presentation/home_page/bloc/home_page_bloc.dart';
import 'package:litlearn/features/learning/presentation/home_page/cubit/categories_cubit.dart';
import 'package:litlearn/features/learning/presentation/home_page/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final selectedCategory = ValueNotifier(0);

  @override
  void initState() {
    

    context.read<CategoriesCubit>().getCategories();
    context.read<HomePageBloc>().add(HomePageEventGetCourses(null));

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
                        Container(
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
                                offset: const Offset(0, 0),
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
                        BlocBuilder<CategoriesCubit, CategoriesState>(
                          builder: (context, categoriesState) {
                            if (categoriesState is CategoriesStatePageLoading) {
                              return Align(
                                alignment: Alignment.center,
                                child: Container(
                                  margin: EdgeInsets.only(top: 100.h),
                                  padding: EdgeInsets.all(20.r),
                                  decoration: BoxDecoration(
                                    color: ColorConstants.white,
                                    borderRadius: BorderRadius.circular(15.r),
                                  ),
                                  child: const CircularProgressIndicator(
                                    color: ColorConstants.blue,
                                  ),
                                ),
                              );
                            } else if (categoriesState
                                is CategoriesStateCategories) {
                              return Column(
                                // NOTE HERE
                                children: [
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    clipBehavior: Clip.none,
                                    child: ValueListenableBuilder(
                                        valueListenable: selectedCategory,
                                        builder: (context, _, __) {
                                          return Row(
                                            children: [
                                              for (int i = 0;
                                                  i <
                                                      categoriesState
                                                          .categories.length;
                                                  i++)
                                                HomePageWidgets.categoryItem(
                                                  context: context,
                                                  index: i,
                                                  category: categoriesState
                                                      .categories[i],
                                                  selectedCategory:
                                                      selectedCategory,
                                                ),
                                            ],
                                          );
                                        }),
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
                                    builder: (context, state) {
                                      if (state is HomePageStateCourseLoading) {
                                        return Align(
                                          alignment: Alignment.center,
                                          child: Container(
                                            margin: EdgeInsets.only(top: 100.h),
                                            padding: EdgeInsets.all(20.r),
                                            decoration: BoxDecoration(
                                              color: ColorConstants.white,
                                              borderRadius:
                                                  BorderRadius.circular(15.r),
                                            ),
                                            child: const CircularProgressIndicator(
                                              color: ColorConstants.blue,
                                            ),
                                          ),
                                        );
                                      } else if (state
                                          is HomePageStateCourses) {
                                        return state.courses.isEmpty
                                            ? Container(
                                                margin:
                                                    EdgeInsets.only(top: 100.h),
                                                width: double.infinity,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 20.w),
                                                child: kText(
                                                  text: 'No Courses Found',
                                                  textAlign: TextAlign.center,
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold,
                                                  color: ColorConstants.white
                                                      .withOpacity(0.3),
                                                ),
                                              )
                                            : Column(
                                                children: [
                                                  for (int i = 0;
                                                      i < state.courses.length;
                                                      i++)
                                                    HomePageWidgets.courseItem(
                                                      courseEntity:
                                                          state.courses[i],
                                                      context: context,
                                                    )
                                                ],
                                              );
                                      }
                                      return Align(
                                        alignment: Alignment.center,
                                        child: Container(
                                          margin: EdgeInsets.only(top: 100.h),
                                          padding: EdgeInsets.all(10.r),
                                          decoration: BoxDecoration(
                                            color: ColorConstants.white,
                                            borderRadius:
                                                BorderRadius.circular(15.r),
                                          ),
                                          child: Icon(
                                            Icons.replay,
                                            color: ColorConstants.blue,
                                            size: 50.r,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              );
                            } else {
                              return const CircularProgressIndicator();
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
