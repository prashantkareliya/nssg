import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:sizer/sizer.dart';

import '../utils/app_colors.dart';

class ToggleSwitch extends StatelessWidget {
  final ValueChanged<bool> onToggle;
  bool valueBool = false;
  ToggleSwitch(this.onToggle, {Key? key, required this.valueBool}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlutterSwitch(
        value: valueBool,
        height: 3.0.h,
        width: 14.w,
        padding: 3.0,
        inactiveColor: AppColors.redColorSwitch,
        activeColor: AppColors.greenColorAccent,
        onToggle: onToggle,
        toggleSize: 18.0,
        toggleColor: AppColors.whiteColor);
  }
}
