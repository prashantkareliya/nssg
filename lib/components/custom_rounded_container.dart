import 'package:flutter/material.dart';

import '../constants/strings.dart';
import '../utils/app_colors.dart';
import 'custom_text_styles.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class RoundedContainer extends StatelessWidget {
  String? containerText;
  String? stepText;
  bool? isEnable;
  bool? isDone;

  RoundedContainer({
    super.key,
    this.containerText,
    this.stepText,
    this.isEnable = true,
    this.isDone = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 4.h,
          width: 8.w,
          decoration: BoxDecoration(
              color: isEnable!
                  ? AppColors.primaryColor
                  : AppColors.primaryColor.withOpacity(0.5),
              borderRadius: const BorderRadius.all(Radius.circular(80.0))),
          child: Center(
              child: isDone!
                  ? Icon(Icons.done, color: AppColors.whiteColor)
                  : Text(containerText!, style: CustomTextStyle.buttonText)),
        ),
        SizedBox(width: 1.5.w),
        Text("${LabelString.lblStep} ${stepText!}",
            style: CustomTextStyle.commonText),
      ],
    );
  }
}
