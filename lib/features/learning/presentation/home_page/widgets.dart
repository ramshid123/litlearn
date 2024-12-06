import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:litlearn/core/entity/course_entity.dart';
import 'package:litlearn/core/theme/palette.dart';
import 'package:litlearn/core/utils/calculate_duration.dart';
import 'package:litlearn/core/widgets/common.dart';
import 'package:litlearn/features/learning/presentation/course_page/view.dart';

class HomePageWidgets {
  static Widget categoryItem({
    required int index,
    required String text,
    required IconData icon,
  }) {
    final isSelected = index == 0;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      margin: EdgeInsets.only(right: 15.w),
      decoration: BoxDecoration(
        color: isSelected ? ColorConstants.white : ColorConstants.blue,
        border: isSelected
            ? const Border()
            : Border.all(
                color: ColorConstants.white,
              ),
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: const Color(0xFF000000).withOpacity(0.4),
                  offset: const Offset(0, 0),
                  blurRadius: 9,
                  spreadRadius: 0,
                ),
              ]
            : [],
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20.r,
            color: isSelected ? ColorConstants.blue : ColorConstants.white,
          ),
          kWidth(10.w),
          kText(
            text: 'Design',
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: isSelected ? ColorConstants.blue : ColorConstants.white,
          ),
        ],
      ),
    );
  }

  static Widget courseItem(
      {required CourseEntity courseEntity, required BuildContext context}) {
    return GestureDetector(
      onTap: () async => await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => CoursePage(
                courseId: courseEntity.courseId,
              ))),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        margin: EdgeInsets.only(bottom: 15.h),
        decoration: BoxDecoration(
          color: ColorConstants.liteBlue,
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Row(
          children: [
            // text contents
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  kText(
                    text: courseEntity.courseName,
                    fontSize: 20,
                    maxLines: 3,
                    fontWeight: FontWeight.w600,
                  ),
                  kText(
                    text: 'By ${courseEntity.teacherName}',
                    fontSize: 14,
                    color: ColorConstants.white.withOpacity(0.8),
                  ),
                  kHeight(20.h),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.r),
                      border: Border.all(
                        color: ColorConstants.greyWhite,
                      ),
                    ),
                    child: kText(
                      text: calculateDurationInHourMin(Duration(
                          milliseconds:
                              int.parse(courseEntity.totalVideoHours))),
                      color: ColorConstants.greyWhite,
                      fontSize: 14,
                    ),
                  ),
                  kHeight(10.h),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.r),
                      border: Border.all(
                        color: ColorConstants.greyWhite,
                      ),
                    ),
                    child: kText(
                      text: '${courseEntity.totalVideoCounts} chapters',
                      color: ColorConstants.greyWhite,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            kWidth(10.w),

            // Image
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF000000).withOpacity(0.4),
                      offset: const Offset(0, 0),
                      blurRadius: 9,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: Image.network(
                    // 'https://zsecurity.org/wp-content/uploads/2024/11/DarkWeb-2-1-e1732103292363.png',
                    courseEntity.thumbnailUrl,
                    height: 150.r,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
