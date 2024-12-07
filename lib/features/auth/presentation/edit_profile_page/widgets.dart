import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:litlearn/core/theme/palette.dart';
import 'package:litlearn/core/widgets/common.dart';

class EditProfilePageWidgets {
  static Widget textFormFields({
    required TextEditingController textController,
    required String hintText,
    bool isNumber = false,
  }) {
    final focusNode = FocusNode();
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          kText(
            text: hintText,
            color: ColorConstants.blue,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          TextFormField(
            focusNode: focusNode,
            keyboardType: isNumber ? TextInputType.number : null,
            maxLength: isNumber ? 10 : null,
            buildCounter: (context,
                {required currentLength,
                required isFocused,
                required maxLength}) {
              return null;
            },
            controller: textController,
            inputFormatters:
                isNumber ? [FilteringTextInputFormatter.digitsOnly] : [],
            cursorColor: ColorConstants.blue,
            onTapOutside: (v) => focusNode.unfocus(),
            style: GoogleFonts.nunito(
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: ColorConstants.liteBlue.withOpacity(0.2),
              hintText: hintText,
              hintStyle: GoogleFonts.nunito(
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                color: ColorConstants.blue.withOpacity(0.5),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget dobSelector(
      {required ValueNotifier<String> dob, required BuildContext context}) {
    return Theme(
      data: ThemeData(
        datePickerTheme: DatePickerThemeData(
          backgroundColor: ColorConstants.white,
          dividerColor: ColorConstants.blue,
          dayOverlayColor: WidgetStatePropertyAll(ColorConstants.blue),
          surfaceTintColor: ColorConstants.blue.withOpacity(0.1),
          yearOverlayColor: WidgetStatePropertyAll(ColorConstants.blue),
        ), // Set your desired color
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            kText(
              text: 'Date of birth',
              color: ColorConstants.blue,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            GestureDetector(
              onTap: () async =>
                  await _showCalendar(context: context, dob: dob),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15.w, horizontal: 10.h),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: ColorConstants.liteBlue.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: ValueListenableBuilder(
                    valueListenable: dob,
                    builder: (context, _, __) {
                      return kText(
                        text: dob.value.isEmpty
                            ? 'Date of birth'
                            : DateFormat('dd/MM/yyyy')
                                .format(DateTime.parse(dob.value)),
                        fontSize: 15,
                        color: dob.value.isEmpty
                            ? ColorConstants.blue.withOpacity(0.5)
                            : Colors.black,
                        fontWeight: dob.value.isEmpty
                            ? FontWeight.w500
                            : FontWeight.normal,
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget genderSelector(ValueNotifier<int> gender) {
    return Builder(builder: (context) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            kText(
              text: 'Gender',
              color: ColorConstants.blue,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            GestureDetector(
              onTap: () async =>
                  await _showbottomSheet(context: context, gender: gender),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15.w, horizontal: 10.h),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: ColorConstants.liteBlue.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                  children: [
                    ValueListenableBuilder(
                        valueListenable: gender,
                        builder: (context, _, __) {
                          return kText(
                            text: gender.value == 1 ? 'Male' : 'Female',
                            fontSize: 15,
                            color: Colors.black,
                          );
                        }),
                    const Spacer(),
                    Transform.rotate(
                      angle: -math.pi / 2,
                      child: Icon(
                        Icons.navigate_before,
                        size: 22.r,
                        color: ColorConstants.blue.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  static Widget submitButton() {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.h),
        padding: EdgeInsets.symmetric(vertical: 10.h),
        width: double.infinity,
        decoration: BoxDecoration(
          color: ColorConstants.blue,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Center(
          child: kText(
            text: 'Update',
            color: ColorConstants.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  static Future _showCalendar(
      {required BuildContext context,
      required ValueNotifier<String> dob}) async {
    dob.value = (await showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      barrierDismissible: true,
      onDatePickerModeChange: (value) => false,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDatePickerMode: DatePickerMode.year,
    ))
        .toString();
  }

  static Future _showbottomSheet(
      {required BuildContext context,
      required ValueNotifier<int> gender}) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return _TestContainre(
          gender: gender,
        );
      },
    );
  }
}

class _TestContainre extends StatelessWidget {
  final ValueNotifier<int> gender;
  const _TestContainre({super.key, required this.gender});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: gender,
        builder: (context, _, __) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(10.r),
              ),
              color: ColorConstants.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio(
                  value: 1,
                  groupValue: gender.value,
                  activeColor: ColorConstants.blue,
                  fillColor: WidgetStatePropertyAll(ColorConstants.blue),
                  onChanged: (v) => gender.value = v ?? 1,
                ),
                kText(
                  text: 'Male',
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: ColorConstants.blue,
                ),
                kWidth(50.w),
                Radio(
                  value: 0,
                  activeColor: ColorConstants.blue,
                  fillColor: WidgetStatePropertyAll(ColorConstants.blue),
                  groupValue: gender.value,
                  onChanged: (v) => gender.value = v ?? 0,
                ),
                kText(
                  text: 'Female',
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: ColorConstants.blue,
                ),
              ],
            ),
          );
        });
  }
}
