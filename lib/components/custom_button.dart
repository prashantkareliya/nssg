import 'package:flutter/material.dart';
import 'package:nssg/components/custom_text_styles.dart';
import 'package:nssg/utils/app_colors.dart';
import 'package:sizer/sizer.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Function()? onClick;
  final Color? buttonColor;

  const CustomButton(
      {Key? key,
      required this.title,
      this.onClick,
      this.buttonColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onClick,
      clipBehavior: Clip.hardEdge,
      style: ElevatedButton.styleFrom(
        primary: buttonColor ?? AppColors.primaryColor,
        splashFactory: NoSplash.splashFactory,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
      ),
      child: Text(title,
          style: CustomTextStyle.buttonText),
    );
  }
}
