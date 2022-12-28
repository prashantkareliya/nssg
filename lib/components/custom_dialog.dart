import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nssg/components/custom_text_styles.dart';
import 'package:nssg/screens/qoute/quotes_screen.dart';
import 'package:sizer/sizer.dart';

import '../constants/navigation.dart';
import '../constants/strings.dart';
import '../screens/dashboard/root_screen.dart';
import 'custom_button.dart';

// ignore: must_be_immutable
class ValidationDialog extends StatelessWidget {
  String msg;
  Function() onClickNo;

  ValidationDialog(this.msg, this.onClickNo, {super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0.0,
      insetPadding: const EdgeInsets.only(left: 15, right: 15),
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
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
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(msg,
                        textAlign: TextAlign.center,
                        style: CustomTextStyle.labelBoldFontText)),
                SizedBox(height: 3.h),
                const Divider(height: 1),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomButton(title: LabelString.yes, onClick: onClickNo!),
                      CustomButton(
                          title: LabelString.no,
                          onClick: () => Navigator.of(context)
                              .pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (c) => const RootScreen()),
                                  (route) => false))
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
