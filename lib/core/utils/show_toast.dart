import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:litlearn/core/theme/palette.dart';
import 'package:litlearn/core/widgets/common.dart';

void showToastMessage({
  required BuildContext context,
  required String message,
  DelightSnackbarPosition position = DelightSnackbarPosition.top,
  Color bgColor = ColorConstants.white,
  Color fgColor = ColorConstants.blue,
}) {
  DelightToastBar(
    autoDismiss: true,
    position: position,
    builder: (context) => ToastCard(
      color: bgColor,
      leading: Icon(
        Icons.info,
        size: 28.r,
        color: fgColor,
      ),
      title: kText(
        text: message,
        color: fgColor,
        fontWeight: FontWeight.bold,
        maxLines: 5,
      ),
    ),
  ).show(context);
}
