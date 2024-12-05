import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:litlearn/core/theme/palette.dart';
import 'package:litlearn/core/widgets/common.dart';
import 'package:litlearn/features/auth/presentation/login_page/widgets.dart';

class LoginPageContents {
  static Widget initialPage({required ValueNotifier<int> actionIndex}) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => actionIndex.value = 1,
          child: LoginPageWidgets.signInButton(),
        ),
        kHeight(20.h),
        GestureDetector(
          onTap: () => actionIndex.value = 2,
          child: LoginPageWidgets.loginButton(),
        ),
        kHeight(100.h),
      ],
    );
  }

  static Widget signUpPage() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: ColorConstants.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(50.r),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              kText(
                text: 'New\nAccount',
                color: ColorConstants.blue,
                fontSize: 27,
                fontWeight: FontWeight.bold,
              ),
              const Spacer(),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // CircleAvatar(
                  //   radius: 40.r,
                  //   backgroundColor: ColorConstants.blue,
                  // ),
                  Container(
                    height: 80.r,
                    width: 80.r,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: ColorConstants.blue,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.camera_alt_outlined,
                      color: ColorConstants.blue,
                      size: 40.r,
                    ),
                  ),
                  kHeight(10.h),
                  kText(
                    text: 'Upload picture',
                    fontSize: 12,
                    color: ColorConstants.blue.withOpacity(0.5),
                  ),
                ],
              ),
            ],
          ),
          kHeight(20.h),
          LoginPageWidgets.loginForm(
            hintText: 'Email',
            icon: Icons.email_outlined,
          ),
          kHeight(15.h),
          LoginPageWidgets.loginForm(
            hintText: 'Username',
            icon: Icons.person,
          ),
          kHeight(15.h),
          LoginPageWidgets.loginForm(
            hintText: 'Password',
            icon: Icons.password,
          ),
          kHeight(30.h),
          Container(
            padding: EdgeInsets.symmetric(vertical: 15.h),
            width: double.infinity,
            decoration: BoxDecoration(
              color: ColorConstants.blue,
              borderRadius: BorderRadius.circular(100.r),
            ),
            child: Center(
              child: kText(
                text: 'Sign up',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: ColorConstants.white,
              ),
            ),
          ),
          kHeight(10.h),
        ],
      ),
    );
  }

  static Widget loginPage() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 30.h),
      decoration: BoxDecoration(
        color: ColorConstants.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(50.r),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              kText(
                text: 'Welcome\nBack',
                color: ColorConstants.blue,
                fontSize: 27,
                fontWeight: FontWeight.bold,
              ),
              const Spacer(),
              CircleAvatar(
                radius: 40.r,
                backgroundColor: ColorConstants.blue,
              ),
            ],
          ),
          kHeight(20.h),
          LoginPageWidgets.loginForm(
            hintText: 'Email',
            icon: Icons.email_outlined,
          ),
          kHeight(15.h),
          LoginPageWidgets.loginForm(
            hintText: 'Password',
            icon: Icons.password,
          ),
          kHeight(15.h),
          Align(
            alignment: Alignment.centerRight,
            child: kText(
              text: 'Forgot Password?',
              fontSize: 12,
              color: ColorConstants.blue.withOpacity(0.7),
            ),
          ),
          kHeight(30.h),
          Container(
            padding: EdgeInsets.symmetric(vertical: 15.h),
            width: double.infinity,
            decoration: BoxDecoration(
              color: ColorConstants.blue,
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
          ),
        ],
      ),
    );
  }
}
