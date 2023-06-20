import 'package:flutter/material.dart';

import '../constants/strings.dart';
import '../utils/app_colors.dart';
import 'custom_text_styles.dart';
// import 'package:sizer/sizer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isEnable! ? AppColors.primaryColor : AppColors.primaryColor.withOpacity(0.5)),
          child: isDone!
              ? Padding(
                  padding: EdgeInsets.all(4.sp),
                  child: Icon(Icons.done, color: AppColors.whiteColor))
              : Padding(
                  padding: EdgeInsets.all(10.sp),
                  child: Text(containerText!, style: CustomTextStyle.buttonText)),
        ),
        SizedBox(width: 5.w),
        Text("${LabelString.lblStep} ${stepText!}", style: CustomTextStyle.commonText)
      ],
    );
  }
}
