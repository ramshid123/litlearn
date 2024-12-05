import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:litlearn/core/theme/palette.dart';
import 'package:litlearn/core/widgets/common.dart';

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

  static Widget courseItem() {
    return Container(
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
                  text: 'Business Management',
                  fontSize: 20,
                  maxLines: 3,
                  fontWeight: FontWeight.w600,
                ),
                kText(
                  text: 'By Ramshid Dilhan',
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
                    text: '20h 12m',
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
                    text: '20 chapters',
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
                  'https://zsecurity.org/wp-content/uploads/2024/11/DarkWeb-2-1-e1732103292363.png',
                  height: 150.r,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
