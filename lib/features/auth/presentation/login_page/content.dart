import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:litlearn/core/theme/palette.dart';
import 'package:litlearn/core/widgets/common.dart';
import 'package:litlearn/features/auth/presentation/login_page/bloc/login_bloc.dart';
import 'package:litlearn/features/auth/presentation/login_page/widgets.dart';

class LoginPageContents {
  static Widget initialPage(
      {required ValueNotifier<int> actionIndex,
      required AnimationController animController}) {
    return Column(
      children: [
        GestureDetector(
          onTap: () async {
            await animController.forward();
            actionIndex.value = 1;
            await animController.reverse();
          },
          child: LoginPageWidgets.signInButton(),
        ),
        kHeight(20.h),
        GestureDetector(
          onTap: () async {
            await animController.forward();
            actionIndex.value = 2;
            await animController.reverse();
          },
          child: LoginPageWidgets.loginButton(),
        ),
        kHeight(100.h),
      ],
    );
  }

  static Widget signUpPage(BuildContext context) {
    final emailController = TextEditingController();
    final fullnameController = TextEditingController();
    final passwordController = TextEditingController();
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
            hintText: 'Fullname',
            icon: Icons.person_pin_circle_outlined,
            textController: fullnameController,
          ),
          kHeight(15.h),
          LoginPageWidgets.loginForm(
            hintText: 'Email',
            icon: Icons.email_outlined,
            textController: emailController,
          ),
          kHeight(15.h),
          LoginPageWidgets.loginForm(
            hintText: 'Password',
            icon: Icons.password,
            textController: passwordController,
          ),
          kHeight(30.h),
          GestureDetector(
            onTap: () {
              context.read<LoginBloc>().add(
                    LoginEventSignup(
                      email: emailController.text,
                      password: passwordController.text,
                      fullname: fullnameController.text,
                    ),
                  );
            },
            child: Container(
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
          ),
          kHeight(10.h),
        ],
      ),
    );
  }

  static Widget loginPage(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
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
            textController: emailController,
          ),
          kHeight(15.h),
          LoginPageWidgets.loginForm(
            hintText: 'Password',
            icon: Icons.password,
            textController: passwordController,
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
          GestureDetector(
            onTap: () {
              context.read<LoginBloc>().add(
                    LoginEventLogin(
                      email: emailController.text,
                      password: passwordController.text,
                    ),
                  );
            },
            child: Container(
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
          ),
        ],
      ),
    );
  }
}
