import 'package:flutter/material.dart';
import 'package:nssg/constants/strings.dart';

import '../../components/custom_appbar.dart';
import '../../components/custom_text_styles.dart';
import '../../utils/app_colors.dart';

class AddQuotePage extends StatefulWidget {
  const AddQuotePage({Key? key}) : super(key: key);

  @override
  State<AddQuotePage> createState() => _AddQuotePageState();
}

class _AddQuotePageState extends State<AddQuotePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: BaseAppBar(
        appBar: AppBar(),
        title: LabelString.lblAddNewQuote,
        isBack: true,
        elevation: 1,
        backgroundColor: AppColors.whiteColor,
        searchWidget: Container(),
        titleTextStyle: CustomTextStyle.labelBoldFontText,
      ),
      body: Center(
        child: Text("Working on this module"),
      ),
    );
  }
}
