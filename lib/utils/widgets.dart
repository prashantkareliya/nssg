import 'package:flutter/material.dart';
import 'package:nssg/utils/app_colors.dart';

double buildResponsiveWidth(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  if (size.width > 720) {
    return 800;
  } else if (size.width < 720) {
    return size.width;
  } else {
    return size.width;
  }
}

Widget loadingView() {
  return Center(
      child: CircularProgressIndicator(color: AppColors.primaryColor));
}
