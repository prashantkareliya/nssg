import 'package:flutter/material.dart';
import 'package:nssg/utils/app_colors.dart';
// import 'package:sizer/sizer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  Color? backgroundColor;
  String? title;
  AppBar? appBar;
  bool? isBack = true;
  Widget? searchWidget;
  TextStyle? titleTextStyle;
  double? elevation;

  BaseAppBar(
      {super.key,
      this.title,
      this.appBar,
      this.isBack,
      this.backgroundColor,
      this.searchWidget,
      this.titleTextStyle,
      this.elevation = 0});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title!, style: titleTextStyle),
      backgroundColor: backgroundColor,
      centerTitle: true,
      elevation: elevation,
      automaticallyImplyLeading: false,
      actions: [searchWidget!],
      leading: isBack!
          ? IconButton(
              highlightColor: AppColors.transparent,
              splashColor: AppColors.transparent,
              onPressed: () {
                /*showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (ctx) => ValidationDialog(
                    Message.quoteExit,

                    //Yes button
                    () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    //No   button
                    () => Navigator.pop(context), //No button
                  ),
                );*/
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios_outlined,
                  color: AppColors.blackColor, size: 16.sp),
            )
          : Container(),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar!.preferredSize.height);
}
