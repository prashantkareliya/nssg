import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nssg/constants/strings.dart';
// import 'package:sizer/sizer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/constants.dart';

// ignore: must_be_immutable
class SvgExtension extends StatelessWidget {
  String? itemName;
  Color? iconColor;

  SvgExtension({Key? key, required this.itemName, required this.iconColor})
      : super(key: key);

  String itemNameText(String str) {
    str = str.replaceAll(" ", "");
    str = str.replaceAll("/", "");
    str = str.replaceAll(" / ", "");
    str = str.replaceAll("%", "");
    return str;
  }

  @override
  Widget build(BuildContext context) {
    itemName = itemNameText(itemName!);
    return SvgPicture.network(
        "${ImageBaseUrl.imageBaseUrl}${itemName?.toLowerCase()}.svg",
        height: 32.h,
        width: 36.w,
        color: iconColor,
        placeholderBuilder: (BuildContext context) =>
            SvgPicture.asset(ImageString.imgPlaceHolder, height: 5.5.h));
  }
}
