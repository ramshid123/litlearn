import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:litlearn/core/global%20states/user%20state/bloc/user_bloc.dart';
import 'package:litlearn/core/theme/palette.dart';
import 'package:litlearn/core/utils/show_toast.dart';
import 'package:litlearn/core/widgets/common.dart';
import 'package:litlearn/features/auth/presentation/login_page/bloc/login_bloc.dart';
import 'package:litlearn/features/auth/presentation/login_page/content.dart';
import 'package:litlearn/features/learning/presentation/home_page/view.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  late AnimationController pageSwitchAnimationController;
  late AnimationController textMoveAnimationController;
  late Animation pageSwitchAnimation;
  late Animation textMoveAnimation;

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
  void initState() {
    // TODO: implement initState
    pageSwitchAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));

    textMoveAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));

    pageSwitchAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: pageSwitchAnimationController, curve: Curves.easeInOut));

    textMoveAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: pageSwitchAnimationController, curve: Curves.easeInOut));

    pageSwitchAnimationController.addListener(() async {
      if (actionIndex.value == 0) {
        await textMoveAnimationController.forward();
      } else {
        await textMoveAnimationController.reverse();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    pageSwitchAnimationController.dispose();
    textMoveAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginStateFailure) {
          showToastMessage(
            context: context,
            message: state.errormsg,
          );
        } else if (state is LoginStateSuccess) {
          showToastMessage(context: context, message: 'Login Success');
          context.read<UserBloc>().add(UserEventUserUpdate(state.user));
          Future.delayed(
              const Duration(seconds: 1),
              () async => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                  (_) => false));
        }
      },
      child: ValueListenableBuilder(
          valueListenable: actionIndex,
          builder: (context, _, __) {
            return PopScope(
              onPopInvokedWithResult: (didPop, result) async {
                if (actionIndex.value != 0) {
                  await pageSwitchAnimationController.forward();
                  actionIndex.value = 0;
                  await pageSwitchAnimationController.reverse();
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
                                color:
                                    ColorConstants.greyWhite.withOpacity(0.1),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AnimatedBuilder(
                                          animation: textMoveAnimation,
                                          builder: (context, _) {
                                            return SizedBox(
                                              height: 60.h,
                                              // +((1 - textMoveAnimation.value) *
                                              //         60.h),
                                              width: double.infinity,
                                            );
                                          }),
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(20.r),
                                        child: Image.network(
                                          'https://litlablearning.com/Logo.png',
                                          height: 70.r,
                                          width: 70.r,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      // Container(
                                      //   height: 70.r,
                                      //   width: 70.r,
                                      //   decoration: BoxDecoration(
                                      //     color: ColorConstants.white,
                                      //     borderRadius:
                                      //         BorderRadius.circular(20.r),
                                      //   ),
                                      // ),
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
                              AnimatedBuilder(
                                  animation: pageSwitchAnimation,
                                  builder: (context, _) {
                                    return Transform.translate(
                                      offset: Offset(
                                          0.0,
                                          size.height *
                                              pageSwitchAnimation.value),
                                      child: SizedBox(
                                        child: [
                                          LoginPageContents.initialPage(
                                              animController:
                                                  pageSwitchAnimationController,
                                              actionIndex: actionIndex),
                                          LoginPageContents.signUpPage(context),
                                          LoginPageContents.loginPage(context)
                                        ][actionIndex.value],
                                      ),
                                    );
                                  }),
                            ],
                          ),
                        ),
                      ),
                    ),
                    BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, state) {
                        if (state is LoginStateLoading) {
                          return Container(
                            height: size.height,
                            width: size.width,
                            color: ColorConstants.blue.withOpacity(0.5),
                            child: Center(
                              child: Container(
                                padding: EdgeInsets.all(20.r),
                                height: 100.r,
                                width: 100.r,
                                decoration: BoxDecoration(
                                  color: ColorConstants.white,
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: CircularProgressIndicator(
                                  color: ColorConstants.blue,
                                ),
                              ),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
