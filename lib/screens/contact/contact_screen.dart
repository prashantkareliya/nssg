import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:nssg/components/custom_text_styles.dart';
import 'package:nssg/screens/contact/add_contact_basic_information.dart';
import 'package:nssg/utils/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../components/custom_appbar.dart';
import '../../constants/navigation.dart';
import '../../constants/strings.dart';
import '../../utils/widgetChange.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  TextEditingController textController = TextEditingController();

  /*List<bool> showQty = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 12; i++) {
      showQty.add(false);
    }
  }

  void showHide(int i) {
    setState(() {
      showQty[i] = !showQty[i];
    });
    //  Provider.of<WidgetChange>(context, listen: true).isVisibleText;
  }
*/

  /*@override
  void initState() {
    super.initState();
    for (int i = 0; i < 12; i++) {
      Provider.of<WidgetChange>(context, listen: false).showQty.add(false);
    }
  }*/

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backWhiteColor,
        appBar: BaseAppBar(
          appBar: AppBar(),
          title: LabelString.lblContact,
          titleTextStyle: CustomTextStyle.labelFontText,
          isBack: false,
          searchWidget: buildSearchField(query),
          backgroundColor: AppColors.backWhiteColor,
        ),
        body: buildContactList(query),
        floatingActionButton: buildAddContactButton(context),
      ),
    );
  }

  ListView buildContactList(Size query) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.sp, vertical: 6.sp),
          child: GestureDetector(
            onTap: () {
              //showHide(index);
              Provider.of<WidgetChange>(context, listen: false)
                  .buttonVisibility(index);
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              elevation: 5,
              child: Container(
                width: query.width,
                decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius:
                        const BorderRadius.all(Radius.circular(12.0))),
                child: buildTileTextFields(index),
              ),
            ),
          ),
        );
      },
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
        onSubmitted: (String) {
          print("${String} ");
        },
        style: CustomTextStyle.commonText,
      ),
    );
  }

  Column buildTileTextFields(int index) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 1.5.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 6.sp),
          child: Row(
            children: [
              Expanded(
                child: Text("${LabelString.lblFullName}: ",
                    style: CustomTextStyle.labelFontHintText),
              ),
              Expanded(
                child:
                    Text("Prashant Kareliya", style: CustomTextStyle.labelText),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 6.sp),
          child: Row(
            children: [
              Expanded(
                child: Text("${LabelString.lblCompany}: ",
                    style: CustomTextStyle.labelFontHintText),
              ),
              Expanded(
                child: Text("IIH-Global", style: CustomTextStyle.labelText),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 6.sp),
          child: Row(
            children: [
              Expanded(
                child: Text("${LabelString.lblMobilePhone}: ",
                    style: CustomTextStyle.labelFontHintText),
              ),
              Expanded(
                child:
                    Text("+91 00000 00000", style: CustomTextStyle.labelText),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 6.sp),
          child: Row(
            children: [
              Expanded(
                child: Text("${LabelString.lblPrimaryEmail}: ",
                    style: CustomTextStyle.labelFontHintText),
              ),
              Expanded(
                child: Text("abcd@gmail.com", style: CustomTextStyle.labelText),
              ),
            ],
          ),
        ),
        SizedBox(height: 1.h),
        buildAnimatedOpacity(index),
      ],
    );
  }

  AnimatedOpacity buildAnimatedOpacity(int index) {
    return AnimatedOpacity(
      opacity: Provider.of<WidgetChange>(context, listen: false).showQty[index]
          ? 1
          : 0,
      duration: const Duration(milliseconds: 500),
      child: Visibility(
        visible:
            Provider.of<WidgetChange>(context, listen: true).showQty[index],
        child: Row(
          children: [
            Expanded(
                child: Container(
              height: 5.5.h,
              decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(12.0))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.edit, color: AppColors.whiteColor),
                  SizedBox(width: 1.w),
                  Text(ButtonString.btnEdit, style: CustomTextStyle.buttonText),
                ],
              ),
            )),
            Expanded(
                child: Container(
              height: 5.5.h,
              decoration: BoxDecoration(
                  color: AppColors.redColor,
                  borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(12.0))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.delete, color: AppColors.whiteColor),
                  SizedBox(width: 1.w),
                  Text(ButtonString.btnDelete,
                      style: CustomTextStyle.buttonText),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  Padding buildAddContactButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10.sp, bottom: 8.sp),
      child: FloatingActionButton(
          onPressed: () {
            callNextScreen(context, const AddContactBasicInformationPage());
          },
          child: const Icon(Icons.add)),
    );
  }
}
