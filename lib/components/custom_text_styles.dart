import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nssg/utils/app_colors.dart';
import 'package:sizer/sizer.dart';

class CustomTextStyle {
  static TextStyle labelText = GoogleFonts.roboto(
      textStyle: TextStyle(
    fontSize: 12.sp,
    color: AppColors.blackColor,
  ));

  static TextStyle labelFontText = GoogleFonts.roboto(
      textStyle: TextStyle(
    fontSize: 12.sp,
    color: AppColors.fontColor,
  ));

  static TextStyle labelMediumBoldFontText = GoogleFonts.roboto(
      textStyle: TextStyle(
          fontSize: 16.sp,
          color: AppColors.fontColor,
          fontWeight: FontWeight.w500));

  static TextStyle labelBoldFontText = GoogleFonts.roboto(
      textStyle: TextStyle(
          fontSize: 14.sp,
          color: AppColors.fontColor,
          fontWeight: FontWeight.bold));

  static TextStyle labelBoldFontTextBlue = GoogleFonts.roboto(
      textStyle: TextStyle(
          fontSize: 18.sp,
          color: AppColors.primaryColor,
          fontWeight: FontWeight.bold));

  static TextStyle commonTextBlue = GoogleFonts.roboto(
      textStyle: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.normal,
          fontStyle: FontStyle.normal,
          color: AppColors.primaryColor));

  static TextStyle labelBoldFontTextSmall = GoogleFonts.roboto(
      textStyle: TextStyle(
          fontSize: 12.sp,
          color: AppColors.fontColor,
          fontWeight: FontWeight.bold));

  static TextStyle labelFontHintText = GoogleFonts.roboto(
      textStyle: TextStyle(
    fontSize: 12.sp,
    color: AppColors.hintFontColor,
  ));

  static TextStyle buttonText = GoogleFonts.roboto(
      textStyle: TextStyle(fontSize: 12.sp, color: AppColors.whiteColor));

  static TextStyle commonText = GoogleFonts.roboto(
      textStyle: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.normal,
          fontStyle: FontStyle.normal,
          color: AppColors.blackColor));

  static TextStyle commonTextDownOpacity = GoogleFonts.roboto(
      textStyle: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.normal,
          fontStyle: FontStyle.normal,
          color: AppColors.hintFontColor));

  static TextStyle commonStyle = GoogleFonts.roboto(
    textStyle: TextStyle(
        fontSize: 10.sp,
        fontWeight: FontWeight.normal,
        fontStyle: FontStyle.normal,
        color: AppColors.blackColor),
  );
}
