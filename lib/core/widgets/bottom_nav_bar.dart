import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:litlearn/core/theme/palette.dart';
import 'package:litlearn/features/auth/presentation/settings_page/view.dart';
import 'package:litlearn/features/learning/presentation/home_page/view.dart';

class KustomBottomNavBar {
  static Widget bottomNavBar({required int index}) {
    final icons = [
      Icons.dashboard_outlined,
      Icons.shopping_bag_outlined,
      Icons.bookmark_outline,
      Icons.person_outline,
    ];
    const pages = [
      HomePage(),
      HomePage(),
      HomePage(),
      SettingsPage(),
    ];
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 15.h),
      // padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 15.h),
      color: ColorConstants.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          for (int i = 0; i < icons.length; i++)
            _navBarItem(
              isSelected: i == index,
              icon: icons[i],
              child: pages[i],
            ),
        ],
      ),
    );
  }

  static Widget _navBarItem({
    required bool isSelected,
    required IconData icon,
    required Widget child,
  }) {
    return Builder(builder: (context) {
      return GestureDetector(
        onTap: () async {
          if (!isSelected) {
            await Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (ctx) => child));
          }
        },
        child: Container(
          padding: EdgeInsets.all(10.r),
          decoration: BoxDecoration(
            color: isSelected ? ColorConstants.blue : Colors.transparent,
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: Icon(
            icon,
            size: 30.r,
            color: isSelected ? ColorConstants.white : ColorConstants.blue,
          ),
        ),
      );
    });
  }
}
