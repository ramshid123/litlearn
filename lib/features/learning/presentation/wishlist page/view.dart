import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:litlearn/core/theme/palette.dart';
import 'package:litlearn/core/widgets/bottom_nav_bar.dart';
import 'package:litlearn/core/widgets/common.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.white,
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  color: ColorConstants.liteBlue,
                ),
              ),
              Expanded(
                child: Container(
                  color: ColorConstants.white,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                decoration: BoxDecoration(
                  color: ColorConstants.liteBlue,
                ),
                child: kText(
                  text: 'Wishlist',
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: ColorConstants.greyWhite,
                ),
              ),
              Expanded(
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  decoration: BoxDecoration(
                    color: ColorConstants.blue,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(50.r),
                      top: Radius.circular(25.r),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: ColorConstants.blue.withOpacity(0.5),
                        offset: Offset(0, -5.h),
                        blurRadius: 9,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      kHeight(100.h),
                      kWidth(double.infinity),
                      Center(
                        child: kText(
                          fontSize: 25,
                          maxLines: 3,
                          text: 'Coming soon!!',
                          color: ColorConstants.greyWhite.withOpacity(0.7),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              KustomBottomNavBar.bottomNavBar(index: 2),
            ],
          ),
        ],
      ),
    );
  }
}
