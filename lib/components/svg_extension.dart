import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/constants.dart';
import '../utils/widgets.dart';

class SvgExtension extends StatelessWidget {
  String? itemName;
  Color? iconColor;

  SvgExtension({Key? key, required this.itemName, required this.iconColor}) : super(key: key);

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
      "${ImageBaseUrl.imageBase}${itemName?.toLowerCase().replaceAll(" ", "")}.svg",
      color: iconColor,
      placeholderBuilder: (BuildContext context) => loadingView(),
    );
  }
}
