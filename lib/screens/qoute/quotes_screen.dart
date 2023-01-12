import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:nssg/constants/navigation.dart';
import 'package:nssg/screens/qoute/add_quote.dart';
import 'package:sizer/sizer.dart';

import '../../components/custom_appbar.dart';
import '../../components/custom_text_styles.dart';
import '../../constants/strings.dart';
import '../../utils/app_colors.dart';

class QuoteScreen extends StatefulWidget {
  const QuoteScreen({Key? key}) : super(key: key);

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backWhiteColor,
        appBar: BaseAppBar(
          appBar: AppBar(),
          title: LabelString.lblQuotes,
          titleTextStyle: CustomTextStyle.labelFontText,
          isBack: false,
          searchWidget: buildSearchField(query),
          backgroundColor: AppColors.backWhiteColor,
        ),
        floatingActionButton: buildAddContactButton(context),
      ),
    );
  }

  Padding buildSearchField(Size query) {
    return Padding(
      padding: EdgeInsets.only(right: 18.sp, top: 8.sp),
      child: AnimSearchBar(
        width: query.width * 0.89,
        textController: textController,
        onSuffixTap: () {
          textController.clear();
        },
        boxShadow: false,
        color: AppColors.backWhiteColor,
        onSubmitted: (string) {
          debugPrint(string);
        },
        style: CustomTextStyle.commonText,
      ),
    );
  }

  FloatingActionButton buildAddContactButton(BuildContext context) {
    return FloatingActionButton(
        onPressed: () {
          callNextScreen(context, AddQuotePage(false));
        },
        child: const Icon(Icons.add));
  }
}
