import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litlearn/core/theme/palette.dart';

Widget kText({
  required String text,
  Color color = ColorConstants.white,
  double fontSize = 16,
  FontWeight fontWeight = FontWeight.normal,
  int? maxLines,
  TextAlign textAlign = TextAlign.start,
  bool applyHorizontalSpace = true,
  String family = 'Nunito',
}) {
  return Text(
    text,
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: TextOverflow.ellipsis,
    textHeightBehavior: TextHeightBehavior(
      applyHeightToFirstAscent: applyHorizontalSpace,
      applyHeightToLastDescent: applyHorizontalSpace,
    ),
    style: GoogleFonts.getFont(
      family,
      fontSize: fontSize.sp,
      fontWeight: fontWeight,
      color: color,
    ),
  );
}

Widget kHeight(double height) {
  return SizedBox(height: height);
}

Widget kWidth(double width) {
  return SizedBox(width: width);
}
