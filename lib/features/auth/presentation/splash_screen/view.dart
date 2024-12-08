import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:litlearn/core/global%20states/user%20state/bloc/user_bloc.dart';
import 'package:litlearn/core/theme/palette.dart';
import 'package:litlearn/features/auth/presentation/email_verification_page/view.dart';
import 'package:litlearn/features/auth/presentation/login_page/view.dart';
import 'package:litlearn/features/auth/presentation/splash_screen/cubit/user_auth_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    context.read<UserAuthCubit>().checkForLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserAuthCubit, UserAuthState>(
      listener: (context, state) async {
        if (state is UserAuthStateResult) {
          await Future.delayed(const Duration(seconds: 1));
          if (state.user == null) {
            if (context.mounted) {
              await Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                  (_) => false);
            }
          } else {
            if (context.mounted) {
              context.read<UserBloc>().add(UserEventUserUpdate(state.user!));
              await Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const EmailVerificationPage()),
                  (_) => false);
            }
          }

          // context.read<UserBloc>().add(event)
        }
      },
      child: Scaffold(
        backgroundColor: ColorConstants.blue,
        body: Center(
          child: Image.asset(
            'assets/litlab_logo.png',
            height: 150.r,
            width: 150.r,
          ),
        ),
      ),
    );
  }
}
