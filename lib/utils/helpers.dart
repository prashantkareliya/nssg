import 'package:flutter/material.dart';

import 'app_colors.dart';

class Helpers {
  static PageRoute pageRouteBuilder(widget) {
    return MaterialPageRoute(builder: (context) => widget);
  }

  static void showSnackBar(BuildContext context, String msg,
      {bool isError = false}) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          duration: const Duration(milliseconds: 800),
          backgroundColor: isError ? Colors.red : Colors.green,
          content: Text(
            msg,
            style: TextStyle(color: AppColors.whiteColor),
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }
}
