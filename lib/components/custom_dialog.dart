import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nssg/components/custom_text_styles.dart';
import 'package:sizer/sizer.dart';

import '../constants/strings.dart';
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
                SizedBox(height: 2.h),
                Text(LabelString.nssg,
                    style: CustomTextStyle.labelBoldFontTextBlue),
                SizedBox(height: 2.h),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.sp),
                    child: Text(msg,
                        textAlign: TextAlign.center,
                        style: CustomTextStyle.labelBoldFontText)),
                SizedBox(height: 3.h),
                const Divider(height: 1),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomButton(title: LabelString.yes, onClick: onClickNo),
                      CustomButton(
                        title: LabelString.no,
                        onClick: onClickYes,
                        /* onClick: () => Navigator.of(context)
                                .pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (c) => const RootScreen()),
                                    (route) => false)*/
                      ),
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
