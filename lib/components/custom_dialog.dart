import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nssg/components/custom_text_styles.dart';
import 'package:sizer/sizer.dart';

import '../constants/strings.dart';
import '../utils/app_colors.dart';
import 'custom_button.dart';

// ignore: must_be_immutable
class ValidationDialog extends StatelessWidget {
  String msg;
  Function() onClickNo;
  Function() onClickYes;

  ValidationDialog(this.msg, this.onClickNo, this.onClickYes, {super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
        elevation: 0.0,
        insetPadding: const EdgeInsets.only(left: 15, right: 15),
        backgroundColor: Colors.transparent,
        child: dialogContent(context));
  }

  Widget dialogContent(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
      child: Container(
        width: 85.w,
        padding: const EdgeInsets.all(0),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Wrap(
          alignment: WrapAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                SizedBox(height: 4.h),
                Text(LabelString.nssg,
                    style: CustomTextStyle.labelBoldFontTextBlue),
                SizedBox(height: 2.h),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.sp),
                    child: Text(msg,
                        textAlign: TextAlign.center,
                        style: CustomTextStyle.labelBoldFontText)),
                SizedBox(height: 3.h),

                Padding(
                  padding: EdgeInsets.symmetric(vertical: 6.sp, horizontal: 15.sp),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                          width: query.width * 0.8,
                          height: query.height * 0.06,

                          child: CustomButton(
                              buttonColor: AppColors.primaryColor,
                              title: LabelString.yes, onClick: onClickNo)),
                      SizedBox(height: 1.5.h),

                      SizedBox(
                          width: query.width * 0.8,
                          height: query.height * 0.06,
                          child: ElevatedButton(
                            onPressed: onClickYes,
                            clipBehavior: Clip.hardEdge,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor.withOpacity(0.20),
                              splashFactory: NoSplash.splashFactory,
                              shadowColor: AppColors.transparent,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
                            ),
                            child: Text( LabelString.no,
                                style:  GoogleFonts.roboto(
                                  textStyle: TextStyle(fontSize: 12.sp, color: AppColors.primaryColor),
                                )),
                          )),
                      SizedBox(height: 2.5.h),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
