import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:litlearn/core/theme/palette.dart';
import 'package:litlearn/features/auth/presentation/course_page/view.dart';
import 'package:litlearn/features/auth/presentation/home_page/view.dart';
import 'package:litlearn/features/auth/presentation/login_page/view.dart';
import 'package:litlearn/features/auth/presentation/video_player_page/view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
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
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const ScreenUtilInit(
      designSize: Size(392.72727272727275, 803.6363636363636),
      child: SafeArea(
        child: MaterialApp(
          title: 'LitLearn',
          home: LoginPage(),
        ),
      ),
    );
  }
}
