import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nssg/components/custom_text_styles.dart';
import 'package:nssg/utils/app_colors.dart';
import 'package:sizer/sizer.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {Key? key,
      this.hint,
      required this.controller,
      required this.keyboardType,
      this.errorText,
      this.titleText,
      this.onEditingComplete,
      required this.readOnly,
      this.onTap,
      this.inputFormatters,
      this.validator,
      this.isRequired,
      required this.obscureText,
      this.suffixWidget,
      this.copyWidget,
      this.prefixIcon,
      this.maxLength,
      this.maxLines,
      this.minLines,
      this.star,
      this.textInputAction})
      : super(key: key);

  final String? hint;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String? errorText;
  final String? titleText;
  final Function()? onEditingComplete;
  final bool readOnly;
  final bool obscureText;
  final Function()? onTap;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String? val)? validator;
  final bool? isRequired;
  final Widget? suffixWidget;
  final Widget? copyWidget;
  final Widget? prefixIcon;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final String? star;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       /* Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (titleText != null) ...[
              Row(
                children: [
                  Text(
                    titleText ?? "",
                    style: CustomTextStyle.labelFontText,
                  ),
                  Text(
                    star ?? "",
                    style: TextStyle(color: AppColors.redColor),
                  )
                ],
              ),
            ],
            copyWidget ?? Container(),
          ],
        ),*/
        SizedBox(height: 1.h),
        TextFormField(
          controller: controller,
          style: TextStyle(color: AppColors.blackColor),
          textCapitalization: TextCapitalization.sentences,
          inputFormatters: inputFormatters,
          textInputAction: textInputAction,
          maxLines: maxLines,
          minLines: minLines,
          maxLength: maxLength,
          readOnly: readOnly,
          onTap: onTap,
          obscureText: obscureText,
          onEditingComplete: onEditingComplete,
          keyboardType: keyboardType,
          cursorColor: AppColors.blackColor,
          decoration: InputDecoration(
              suffixIcon: suffixWidget,
              prefixIcon: prefixIcon,
             /* border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(width: 2, color: AppColors.primaryColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(width: 2, color: AppColors.primaryColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(width: 2, color: AppColors.primaryColor),
              ),*/
             /* enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    width: 1, color: AppColors.primaryColor)
              ),*/
              border: UnderlineInputBorder(
                  borderSide: BorderSide(
                      width: 1, color: AppColors.primaryColor)
              ),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      width: 1, color: AppColors.primaryColor)
              ),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      width: 1, color: AppColors.primaryColor)
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.only(left: 12.sp),
              hintText: hint,
              hintStyle: CustomTextStyle.labelFontHintText,
              counterText: "",

            labelStyle: CustomTextStyle.labelFontHintText,
            labelText: titleText!
          ),
          validator: (validator != null)
              ? validator
              : (isRequired == true)
                  ? (String? val) {
                      if (val?.isEmpty == true) {
                        return "${titleText ?? 'Field'} can't empty";
                      } else {
                        return null;
                      }
                    }
                  : null,
        ),
        SizedBox(height: 2.5.h),
      ],
    );
  }
}

/*
class MultiLineTextField extends StatelessWidget {
  const MultiLineTextField(
      {Key? key,
      this.hint,
      required this.controller,
      required this.keyboardType,
      this.errorText,
      this.titleText,
      this.onEditingComplete,
      required this.readOnly,
      this.onTap,
      this.inputFormatters,
      this.validator,
      this.isRequired,
      required this.obscureText,
      this.suffixWidget})
      : super(key: key);

  final String? hint;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String? errorText;
  final String? titleText;
  final Function()? onEditingComplete;
  final bool readOnly;
  final bool obscureText;
  final Function()? onTap;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String? val)? validator;
  final bool? isRequired;
  final Widget? suffixWidget;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       */
/* if (titleText != null) ...[
          Text(titleText ?? "", style: CustomTextStyle.labelFontText),
          const SizedBox(height: 10),
        ],*//*

        TextFormField(
          controller: controller,
          style: TextStyle(color: AppColors.blackColor),
          textCapitalization: TextCapitalization.sentences,
          inputFormatters: inputFormatters,
          textInputAction: TextInputAction.next,
          maxLines: 4,
          readOnly: readOnly,
          onTap: onTap,
          obscureText: obscureText,
          onEditingComplete: onEditingComplete,
          keyboardType: keyboardType,
          cursorColor: AppColors.blackColor,
          decoration: InputDecoration(
              suffixIcon: suffixWidget,
              */
/*border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(width: 2, color: AppColors.primaryColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(width: 2, color: AppColors.primaryColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(width: 2, color: AppColors.primaryColor),
              ),*//*

              border: UnderlineInputBorder(
                  borderSide: BorderSide(
                      width: 1, color: AppColors.primaryColor)
              ),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      width: 1, color: AppColors.primaryColor)
              ),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      width: 1, color: AppColors.primaryColor)
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding:
                  EdgeInsets.only(left: 12.sp, top: 14.sp, right: 12),
              hintText: hint,
              hintStyle: CustomTextStyle.labelFontHintText,
              counterText: "",
              labelStyle: CustomTextStyle.labelFontHintText,
              labelText: titleText!),
          validator: (validator != null)
              ? validator
              : (isRequired == true)
                  ? (String? val) {
                      if (val?.isEmpty == true) {
                        return "${titleText ?? 'Field'} can't empty";
                      } else {
                        return null;
                      }
                    }
                  : null,
        ),
        SizedBox(height: 2.5.h),
      ],
    );
  }
}
*/
