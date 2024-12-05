import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:litlearn/core/theme/palette.dart';
import 'package:litlearn/core/widgets/common.dart';
import 'package:litlearn/features/auth/presentation/login_page/content.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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

  final actionIndex = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return ValueListenableBuilder(
        valueListenable: actionIndex,
        builder: (context, _, __) {
          return PopScope(
            onPopInvokedWithResult: (didPop, result) {
              if (actionIndex.value != 0) {
                actionIndex.value = 0;
              }
            },
            canPop: actionIndex.value == 0,
            child: Scaffold(
              backgroundColor: ColorConstants.blue,
              body: Stack(
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
                  SingleChildScrollView(
                    child: SizedBox(
                      height: size.height,
                      child: SafeArea(
                        child: Column(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(left: 50.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 60.h,
                                      width: double.infinity,
                                    ),
                                    Container(
                                      height: 70.r,
                                      width: 70.r,
                                      decoration: BoxDecoration(
                                        color: ColorConstants.white,
                                        borderRadius:
                                            BorderRadius.circular(20.r),
                                      ),
                                    ),
                                    kHeight(20.h),
                                    kText(
                                      text: 'Enjoy the learning\nwith us',
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            [
                              LoginPageContents.initialPage(
                                  actionIndex: actionIndex),
                              LoginPageContents.signUpPage(),
                              LoginPageContents.loginPage()
                            ][actionIndex.value],
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
