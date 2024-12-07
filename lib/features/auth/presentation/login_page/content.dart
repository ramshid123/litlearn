import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litlearn/core/theme/palette.dart';
import 'package:litlearn/core/utils/check_email_format.dart';
import 'package:litlearn/core/utils/show_toast.dart';
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
                  // Container(
                  //   height: 80.r,
                  //   width: 80.r,
                  //   decoration: BoxDecoration(
                  //     border: Border.all(
                  //       color: ColorConstants.blue,
                  //     ),
                  //     shape: BoxShape.circle,
                  //   ),
                  //   child: Icon(
                  //     Icons.camera_alt_outlined,
                  //     color: ColorConstants.blue,
                  //     size: 40.r,
                  //   ),
                  // ),
                  // kHeight(10.h),
                  // kText(
                  //   text: 'Upload picture',
                  //   fontSize: 12,
                  //   color: ColorConstants.blue.withOpacity(0.5),
                  // ),
                  CircleAvatar(
                    radius: 40.r,
                    backgroundColor: ColorConstants.blue,
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
            loginFormType: LoginFormType.name,
          ),
          kHeight(15.h),
          LoginPageWidgets.loginForm(
            hintText: 'Email',
            icon: Icons.email_outlined,
            textController: emailController,
            loginFormType: LoginFormType.email,
          ),
          kHeight(15.h),
          LoginPageWidgets.loginForm(
            hintText: 'Password',
            icon: Icons.password,
            textController: passwordController,
            loginFormType: LoginFormType.password,
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
            loginFormType: LoginFormType.email,
          ),
          kHeight(15.h),
          LoginPageWidgets.loginForm(
            hintText: 'Password',
            icon: Icons.password,
            textController: passwordController,
            loginFormType: LoginFormType.password,
          ),
          kHeight(15.h),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () async => await _showResetPasswordForm(context),
              child: Container(
                child: kText(
                  text: 'Forgot Password?',
                  fontSize: 12,
                  color: ColorConstants.blue.withOpacity(0.7),
                ),
              ),
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

  static Future _showResetPasswordForm(BuildContext context) async {
    final size = MediaQuery.sizeOf(context);
    final focusNode = FocusNode();
    final textController = TextEditingController();
    await showDialog(
        context: context,
        builder: (context) => Align(
              alignment: Alignment.center,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: size.width * 0.8,
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                  decoration: BoxDecoration(
                    color: ColorConstants.white,
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      kText(
                        text: 'Email',
                        color: ColorConstants.blue,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      TextFormField(
                        focusNode: focusNode,
                        keyboardType: TextInputType.emailAddress,
                        buildCounter: (context,
                            {required currentLength,
                            required isFocused,
                            required maxLength}) {
                          return null;
                        },
                        controller: textController,
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
                          hintText: 'Enter your email*',
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
                      kHeight(15.h),
                      GestureDetector(
                        onTap: () {
                          if (textController.text.isNotEmpty ||
                              checkEmailFormat(textController.text)) {
                            context.read<LoginBloc>().add(
                                LoginEventForgotPassword(textController.text));
                            Navigator.pop(context);
                            showToastMessage(
                                context: context,
                                message:
                                    'Password reset link is send to your email');
                          } else {
                            Navigator.pop(context);
                            showToastMessage(
                                context: context,
                                message: 'Enter a valid email address');
                          }
                        },
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
                              text: 'Send email',
                              color: ColorConstants.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}
