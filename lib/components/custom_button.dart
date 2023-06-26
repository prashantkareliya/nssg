import 'package:flutter/material.dart';
import 'package:nssg/components/custom_text_styles.dart';
import 'package:nssg/utils/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Function()? onClick;
  final Color? buttonColor;

  const CustomButton(
      {Key? key, required this.title, this.onClick, this.buttonColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onClick,
        clipBehavior: Clip.hardEdge,
        style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor ?? AppColors.primaryColor,
            splashFactory: NoSplash.splashFactory,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)))),
        child: Text(title, style: CustomTextStyle.buttonText));
  }
}

class BorderButton extends StatelessWidget {
  final String btnString;
  final Function()? onClick;

  const BorderButton({Key? key, required this.btnString, this.onClick})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
            foregroundColor:
                MaterialStateProperty.all<Color>(AppColors.primaryColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side:
                        BorderSide(color: AppColors.primaryColor, width: 2)))),
        onPressed: onClick,
        child: Text(btnString, style: CustomTextStyle.commonTextBlue));
  }
}
