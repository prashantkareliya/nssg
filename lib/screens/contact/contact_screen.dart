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
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            elevation: 5,
            child: Container(
              width: query.width,
              decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: const BorderRadius.all(Radius.circular(12.0))),
              child: buildTileTextFields(index),
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
        SizedBox(height: 1.0.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 3.sp),
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
              Container(
                height: 3.h,
                width: 6.w,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(80.0)),
                    border: Border.all(width: 1, color: AppColors.redColor)),
                child: Center(
                    child: Icon(
                  Icons.delete_rounded,
                  size: 12.sp,
                  color: AppColors.redColor,
                )),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 3.sp),
          child: Row(
            children: [
              Expanded(
                child: Text("${LabelString.lblCompany}: ",
                    style: CustomTextStyle.labelFontHintText),
              ),
              Expanded(
                child: Text("IIH-Global", style: CustomTextStyle.labelText),
              ),
              Container(
                height: 3.h,
                width: 6.w,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(80.0)),
                    border: Border.all(width: 1, color: AppColors.blackColor)),
                child: Center(
                    child: Icon(
                  Icons.edit_rounded,
                  size: 12.sp,
                  color: AppColors.blackColor,
                )),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 3.sp),
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
              SizedBox(height: 3.h, width: 6.w)
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 3.sp),
          child: Row(
            children: [
              Expanded(
                child: Text("${LabelString.lblPrimaryEmail}: ",
                    style: CustomTextStyle.labelFontHintText),
              ),
              Expanded(
                child: Text("abcd@gmail.com", style: CustomTextStyle.labelText),
              ),
              SizedBox(height: 3.h, width: 6.w)
            ],
          ),
        ),
        SizedBox(height: 1.0.h),
      ],
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
