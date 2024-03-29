import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import 'custom_text_styles.dart';
import 'package:sizer/sizer.dart';

class RadioModel {
  bool isSelected;
  final String buttonText;

  RadioModel(this.isSelected, this.buttonText);
}

class RadioItem extends StatelessWidget {
  final RadioModel item;

  const RadioItem(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 4.sp, bottom: 4.sp, right: 6.sp),

      decoration: BoxDecoration(
          color:
          item.isSelected ? AppColors.primaryColor : AppColors.transparent,
          border: Border.all(width: 1.0, color: AppColors.primaryColor),
          borderRadius: BorderRadius.all(Radius.circular(5.sp))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.sp),
            child: Text(item.buttonText,
                style: item.isSelected
                    ? CustomTextStyle.buttonText
                    : CustomTextStyle.labelFontText),
          ),
        ],
      ),
    );
  }
}