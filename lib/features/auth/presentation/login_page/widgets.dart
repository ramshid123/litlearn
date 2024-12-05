import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litlearn/core/theme/palette.dart';
import 'package:litlearn/core/widgets/common.dart';

class LoginPageWidgets {
  static Widget signInButton() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 70.w),
      padding: EdgeInsets.symmetric(vertical: 15.h),
      decoration: BoxDecoration(
        color: ColorConstants.white,
        borderRadius: BorderRadius.circular(100.r),
      ),
      child: Center(
        child: kText(
          text: 'Sign up',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: ColorConstants.blue,
        ),
      ),
    );
  }

  static Widget loginButton() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 70.w),
      padding: EdgeInsets.symmetric(vertical: 15.h),
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorConstants.white,
          width: 3.r,
        ),
        borderRadius: BorderRadius.circular(100.r),
      ),
      child: Center(
        child: kText(
          text: 'Login',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: ColorConstants.white,
        ),
      ),
    );
  }

  static Widget loginForm({
    required String hintText,
    required IconData icon,
  }) {
    final focusNode = FocusNode();
    return TextFormField(
      focusNode: focusNode,
      onTapOutside: (v) => focusNode.unfocus(),
      decoration: InputDecoration(
        labelText: hintText,
        labelStyle: GoogleFonts.nunito(
          color: ColorConstants.blue,
        ),
        prefixIcon: Icon(
          icon,
          size: 20.r,
          color: ColorConstants.blue.withOpacity(0.7),
        ),
        enabledBorder: UnderlineInputBorder(
          // borderRadius: BorderRadius.circular(100.r),
          borderSide: BorderSide(
            color: ColorConstants.blue.withOpacity(0.7),
            width: 1.r,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(100.r),
          borderSide: BorderSide(
            color: ColorConstants.blue.withOpacity(0.7),
            width: 2.r,
          ),
        ),
      ),
    );
  }
}
