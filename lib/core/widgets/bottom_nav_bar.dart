import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:litlearn/core/theme/palette.dart';

class KustomBottomNavBar {
  static Widget bottomNavBar({required int index}) {
    final icons = [
      Icons.dashboard_outlined,
      Icons.chat_outlined,
      Icons.shopping_bag_outlined,
      Icons.bookmark_outline,
      Icons.person_outline,
    ];
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 15.h),
      color: ColorConstants.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          for (int i = 0; i < 5; i++)
            _navBarItem(isSelected: i == index, icon: icons[i]),
        ],
      ),
    );
  }

  static Widget _navBarItem(
      {required bool isSelected, required IconData icon}) {
    return Container(
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
    );
  }
}
