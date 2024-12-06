import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:litlearn/core/global%20states/user%20state/bloc/user_bloc.dart';
import 'package:litlearn/core/theme/palette.dart';
import 'package:litlearn/features/auth/presentation/login_page/bloc/login_bloc.dart';
import 'package:litlearn/features/auth/presentation/settings_page/view.dart';
import 'package:litlearn/features/auth/presentation/splash_screen/cubit/user_auth_cubit.dart';
import 'package:litlearn/features/learning/presentation/course_page/bloc/course_page_bloc.dart';
import 'package:litlearn/features/learning/presentation/course_page/cubit/enrolled_course_cubit.dart';
import 'package:litlearn/features/learning/presentation/course_page/cubit/videos_cubit.dart';
import 'package:litlearn/features/learning/presentation/course_page/view.dart';
import 'package:litlearn/features/learning/presentation/home_page/bloc/home_page_bloc.dart';
import 'package:litlearn/features/learning/presentation/home_page/view.dart';
import 'package:litlearn/features/auth/presentation/login_page/view.dart';
import 'package:litlearn/features/auth/presentation/splash_screen/view.dart';
import 'package:litlearn/features/learning/presentation/video_player_page/cubit/video_player_cubit.dart';
import 'package:litlearn/features/learning/presentation/video_player_page/view.dart';
import 'package:litlearn/init_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: ColorConstants.blue,
      systemNavigationBarColor: ColorConstants.white,
      systemNavigationBarDividerColor: ColorConstants.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.immersiveSticky,
    overlays: [
      SystemUiOverlay.top,
    ],
  );

  await initDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomePageBloc>(create: (_) => serviceLocator()),
        BlocProvider<CoursePageBloc>(create: (_) => serviceLocator()),
        BlocProvider<VideosCubit>(create: (_) => serviceLocator()),
        BlocProvider<EnrolledCourseCubit>(create: (_) => serviceLocator()),
        BlocProvider<VideoPlayerCubit>(create: (_) => serviceLocator()),
        BlocProvider<LoginBloc>(create: (_) => serviceLocator()),
        BlocProvider<UserAuthCubit>(create: (_) => serviceLocator()),
        BlocProvider<UserBloc>(create: (_) => serviceLocator()),
      ],
      child: const ScreenUtilInit(
        designSize: Size(392.72727272727275, 803.6363636363636),
        child: SafeArea(
          child: MaterialApp(
            title: 'LitLearn',
            home: SplashScreen(),
            // home: SettingsPage(),
          ),
        ),
      ),
    );
  }
}
