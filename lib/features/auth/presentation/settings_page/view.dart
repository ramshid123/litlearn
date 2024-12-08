import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:litlearn/core/entity/user_entity.dart';
import 'package:litlearn/core/global%20states/user%20state/bloc/user_bloc.dart';
import 'package:litlearn/core/theme/palette.dart';
import 'package:litlearn/core/utils/show_toast.dart';
import 'package:litlearn/core/widgets/bottom_nav_bar.dart';
import 'package:litlearn/core/widgets/common.dart';
import 'package:litlearn/features/auth/presentation/edit_profile_page/view.dart';
import 'package:litlearn/features/auth/presentation/login_page/view.dart';
import 'package:litlearn/features/auth/presentation/settings_page/cubit/settings_cubit.dart';
import 'package:litlearn/features/auth/presentation/settings_page/widgets.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late UserEntity userEntity;

  @override
  void initState() {
    userEntity =
        (context.read<UserBloc>().state as UserStateUserEntity).userEntity;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MediaQuery.sizeOf(context);
    return BlocListener<SettingsCubit, SettingsState>(
      listener: (context, state) {
        if (state is SettingsStateFailure) {
          showToastMessage(context: context, message: 'Logout failed');
        } else if (state is SettingsStateLogoutSuccess) {
          showToastMessage(context: context, message: 'Logging out');
          Future.delayed(const Duration(seconds: 1), () async {
            if (context.mounted) {
              await Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                  (_) => false);
            }
          });
        }
      },
      child: Scaffold(
        backgroundColor: ColorConstants.liteBlue,
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    kWidth(double.infinity),
                    kHeight(50.h),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 20.w),
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.w, vertical: 15.h),
                      decoration: BoxDecoration(
                        color: ColorConstants.blue,
                        border: Border.all(
                          color: ColorConstants.greyWhite,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            offset: const Offset(0, 0),
                            blurRadius: 9,
                            spreadRadius: 0,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 100.r,
                                width: 100.r,
                                decoration: BoxDecoration(
                                  color: ColorConstants.liteBlue,
                                  borderRadius: BorderRadius.circular(15.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      offset: const Offset(0, 0),
                                      blurRadius: 9,
                                      spreadRadius: 0,
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.person_rounded,
                                  color: ColorConstants.greyWhite,
                                  size: 70.r,
                                ),
                              ),
                              kWidth(20.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  kText(
                                    text: userEntity.fullName,
                                    maxLines: 3,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  kText(
                                    text: userEntity.email,
                                    // color: ColorConstants.greyWhite,
                                    fontSize: 15,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          kHeight(10.h),
                          Divider(
                              color: ColorConstants.greyWhite.withOpacity(0.4)),
                          kHeight(10.h),
                          GestureDetector(
                            onTap: () async {
                              await Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const EditProfilePage()));
                            },
                            child: SettingsPageWidgets.settingButton(
                              icon: Icons.edit,
                              title: 'Edit profile',
                              value: '',
                            ),
                          ),
                        ],
                      ),
                    ),
                    kHeight(30.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: kText(
                        text: 'Content',
                        fontWeight: FontWeight.bold,
                        color: ColorConstants.greyWhite,
                        fontSize: 15,
                      ),
                    ),
                    kHeight(5.h),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20.w),
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.w, vertical: 15.h),
                      decoration: BoxDecoration(
                        color: ColorConstants.blue,
                        border: Border.all(
                          color: ColorConstants.greyWhite,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            offset: const Offset(0, 0),
                            blurRadius: 9,
                            spreadRadius: 0,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      child: Column(
                        children: [
                          SettingsPageWidgets.settingButton(
                            title: 'Language',
                            icon: Icons.language_rounded,
                            value: 'English',
                          ),
                          Divider(
                              color: ColorConstants.greyWhite.withOpacity(0.4)),
                          SettingsPageWidgets.settingButtonWithSwitch(
                            value: true,
                            icon: Icons.replay,
                            title: 'Autoplay',
                          ),
                          Divider(
                              color: ColorConstants.greyWhite.withOpacity(0.4)),
                          SettingsPageWidgets.settingButtonWithSwitch(
                            value: false,
                            icon: Icons.pause_circle_outline_outlined,
                            title: 'Background play',
                          ),
                        ],
                      ),
                    ),
                    kHeight(20.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: kText(
                        text: 'Preferences',
                        fontWeight: FontWeight.bold,
                        color: ColorConstants.greyWhite,
                        fontSize: 15,
                      ),
                    ),
                    kHeight(5.h),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20.w),
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.w, vertical: 15.h),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            offset: const Offset(0, 0),
                            blurRadius: 9,
                            spreadRadius: 0,
                          ),
                        ],
                        color: ColorConstants.blue,
                        border: Border.all(
                          color: ColorConstants.greyWhite,
                        ),
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      child: Column(
                        children: [
                          SettingsPageWidgets.settingButton(
                            title: 'Notifications',
                            icon: Icons.notifications,
                            value: 'Enabled',
                          ),
                          Divider(
                              color: ColorConstants.greyWhite.withOpacity(0.4)),
                          SettingsPageWidgets.settingButton(
                            title: 'Theme',
                            icon: Icons.mode_night_sharp,
                            value: 'Light',
                          ),
                          Divider(
                              color: ColorConstants.greyWhite.withOpacity(0.4)),
                          SettingsPageWidgets.settingButton(
                            title: 'Privacy',
                            icon: Icons.policy_outlined,
                            value: '',
                          ),
                          Divider(
                              color: ColorConstants.greyWhite.withOpacity(0.4)),
                          SettingsPageWidgets.settingButton(
                            title: 'Support',
                            icon: Icons.support,
                            value: '',
                          ),
                          Divider(
                              color: ColorConstants.greyWhite.withOpacity(0.4)),
                          GestureDetector(
                            onTap: () async =>
                                await context.read<SettingsCubit>().logout(),
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 5.h),
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(7.r),
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                              255, 255, 121, 112)
                                          .withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(5.r),
                                    ),
                                    child: Icon(
                                      Icons.logout,
                                      size: 25.r,
                                      color: const Color.fromARGB(
                                          255, 255, 121, 112),
                                    ),
                                  ),
                                  kWidth(15.w),
                                  Expanded(
                                    child: kText(
                                      text: 'Logout',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: const Color.fromARGB(
                                          255, 255, 121, 112),
                                    ),
                                  ),
                                  Icon(
                                    Icons.navigate_next,
                                    size: 20.r,
                                    color: ColorConstants.greyWhite,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    kHeight(20.h),
                  ],
                ),
              ),
            ),
            KustomBottomNavBar.bottomNavBar(index: 3),
          ],
        ),
      ),
    );
  }
}


// autoplay,  background play, language,

// notification,  theme, Privacy, Support,

//  Payment methods