import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:litlearn/core/theme/palette.dart';
import 'package:litlearn/core/widgets/common.dart';

class SettingsPageWidgets {
  static Widget settingButton({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(7.r),
            decoration: BoxDecoration(
              color: ColorConstants.liteBlue,
              borderRadius: BorderRadius.circular(5.r),
            ),
            child: Icon(
              icon,
              size: 25.r,
              color: ColorConstants.white,
            ),
          ),
          kWidth(15.w),
          Expanded(
            child: kText(
              text: title,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          kText(
            text: value,
            fontSize: 13,
            color: ColorConstants.greyWhite,
          ),
          Icon(
            Icons.navigate_next,
            size: 20.r,
            color: ColorConstants.greyWhite,
          ),
        ],
      ),
    );
  }

  static Widget settingButtonWithSwitch({
    required IconData icon,
    required String title,
    required bool value,
  }) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(7.r),
          decoration: BoxDecoration(
            color: ColorConstants.liteBlue,
            borderRadius: BorderRadius.circular(5.r),
          ),
          child: Icon(
            icon,
            size: 25.r,
            color: ColorConstants.white,
          ),
        ),
        kWidth(15.w),
        Expanded(
          child: kText(
            text: title,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        Switch(
          value: value,
          onChanged: (v) {},
          thumbColor: const WidgetStatePropertyAll(ColorConstants.greyWhite),
          activeTrackColor: ColorConstants.liteBlue,
          inactiveTrackColor: ColorConstants.blue,
          trackOutlineColor:
              const WidgetStatePropertyAll(ColorConstants.greyWhite),
        ),
      ],
    );
  }
}
