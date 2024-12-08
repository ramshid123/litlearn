import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:litlearn/core/theme/palette.dart';
import 'package:litlearn/core/utils/show_toast.dart';
import 'package:litlearn/core/widgets/common.dart';
import 'package:litlearn/features/auth/presentation/email_verification_page/cubit/email_verification_cubit.dart';
import 'package:litlearn/features/auth/presentation/login_page/view.dart';
import 'package:litlearn/features/learning/presentation/home_page/view.dart';

class EmailVerificationPage extends StatefulWidget {
  const EmailVerificationPage({super.key});

  @override
  State<EmailVerificationPage> createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;

  final emailSentTime = ValueNotifier(const Duration(seconds: 60));

  final words = [
    'Advance',
    'Learn',
    'Grow',
    'Achieve',
    'Succeed',
    'Elevate',
    'Refine',
    'Enhance',
    'Master',
    'Improve',
  ];

  @override
  void initState() {
    
    _animController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    context
        .read<EmailVerificationCubit>()
        .checkForEmailVerification(sendEmail: true);
    customTimerFunction();

    Future.delayed(const Duration(seconds: 1), () async => await _animate());
    super.initState();
  }

  Future _animate() async {
    Future.delayed(const Duration(seconds: 1),
        () async => await _animController.forward());
  }

  Future sendEmail() async {
    customTimerFunction();
    context.read<EmailVerificationCubit>().sendVerificationEmail();
  }

  Future customTimerFunction() async {
    emailSentTime.value = const Duration(seconds: 60);
    bool isActive = true;
    while (isActive) {
      await Future.delayed(const Duration(seconds: 1));
      log(emailSentTime.value.inSeconds.toString());
      if (emailSentTime.value.inSeconds > 0) {
        emailSentTime.value =
            Duration(seconds: emailSentTime.value.inSeconds - 1);
      } else {
        if (isActive) {
          isActive = false;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EmailVerificationCubit, EmailVerificationState>(
      listener: (context, state) {
        if (state is EmailVerificationStateFailure) {
          showToastMessage(context: context, message: state.msg);
        }

        if (state is EmailVerificationStateStatus) {
          // showToastMessage(context: context, message: 'Email Verified');
          log(state.status.toString());
          if (state.status) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
                (_) => false);
          } else {
            if (state.sendMail) {
              sendEmail();
            }
            showToastMessage(
                context: context, message: 'Email is not verified.');
          }
        }
        if (state is EmailVerificationStateLogout) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
              (_) => false);
        }
        if (state is EmailVerificationStateSentEmail) {
          showToastMessage(
              context: context, message: 'Email is sent to your mail');
        }
        
      },
      child: Scaffold(
        backgroundColor: ColorConstants.liteBlue,
        body: Stack(
          alignment: Alignment.center,
          children: [
            Transform.scale(
              scale: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  kWidth(double.infinity),
                  for (int i = 0; i < words.length; i++)
                    Padding(
                      padding: EdgeInsets.only(
                          left: i.isEven ? 25.w : 0,
                          right: i.isOdd ? 25.w : 0),
                      child: kText(
                        text: words[i],
                        fontSize: 30,
                        family: 'PT Serif',
                        color: ColorConstants.greyWhite.withOpacity(0.1),
                      ),
                    ),
                ],
              ),
            ),
            BlocBuilder<EmailVerificationCubit, EmailVerificationState>(
              builder: (context, state) {
                return Align(
                  alignment: Alignment.center,
                  child: Builder(
                    builder: (context) {
                      if (state is EmailVerificationStateLoading) {
                        return Container(
                          height: 80.r,
                          width: 80.r,
                          padding: EdgeInsets.all(20.r),
                          decoration: BoxDecoration(
                            color: ColorConstants.white,
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          child: const CircularProgressIndicator(
                            color: ColorConstants.blue,
                          ),
                        );
                      } else {
                        return AnimatedBuilder(
                            animation: _animController,
                            builder: (context, _) {
                              return Opacity(
                                opacity: _animController.value,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20.w, vertical: 20.h),
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 25.w),
                                  decoration: BoxDecoration(
                                    color: ColorConstants.white,
                                    borderRadius: BorderRadius.circular(15.r),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.mark_email_read_rounded,
                                        color: ColorConstants.blue,
                                        size: 100.r,
                                      ),
                                      kHeight(15.h),
                                      kText(
                                        text: 'Verify your email',
                                        color: ColorConstants.blue,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        textAlign: TextAlign.center,
                                      ),
                                      kHeight(5.h),
                                      kText(
                                        text:
                                            'Please check your inbox and verify your email.',
                                        maxLines: 5,
                                        textAlign: TextAlign.center,
                                        color: ColorConstants.blue,
                                      ),
                                      kHeight(15.h),
                                      GestureDetector(
                                        onTap: () => context
                                            .read<EmailVerificationCubit>()
                                            .checkForEmailVerification(
                                                sendEmail: false),
                                        child: Container(
                                          width: double.infinity,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 40.w),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10.h, horizontal: 20.h),
                                          decoration: BoxDecoration(
                                            color: ColorConstants.blue,
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                          ),
                                          child: Center(
                                            child: kText(
                                              text: 'I have verified',
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      kHeight(15.h),
                                      GestureDetector(
                                        onTap: () => context
                                            .read<EmailVerificationCubit>()
                                            .logout(),
                                        child: Container(
                                          width: double.infinity,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 40.w),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10.h, horizontal: 20.h),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: ColorConstants.blue,
                                              width: 2.r,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                          ),
                                          child: Center(
                                            child: kText(
                                              text: 'Logout',
                                              fontWeight: FontWeight.bold,
                                              color: ColorConstants.blue,
                                            ),
                                          ),
                                        ),
                                      ),
                                      kHeight(10.h),
                                      ValueListenableBuilder(
                                          valueListenable: emailSentTime,
                                          builder: (context, _, __) {
                                            return Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 40.w),
                                              child: Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: emailSentTime
                                                            .value.inSeconds >
                                                        0
                                                    ? kText(
                                                        text:
                                                            'Resend email in ${emailSentTime.value.inSeconds} seconds',
                                                        color: ColorConstants
                                                            .blue
                                                            .withOpacity(0.4),
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )
                                                    : GestureDetector(
                                                        onTap: () async =>
                                                            await sendEmail(),
                                                        child: Container(
                                                          child: kText(
                                                            text:
                                                                'Resend email',
                                                            color: ColorConstants
                                                                .blue
                                                                .withOpacity(
                                                                    0.7),
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                              ),
                                            );
                                          })
                                    ],
                                  ),
                                ),
                              );
                            });
                      }
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
