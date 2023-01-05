import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:nssg/constants/strings.dart';
import 'package:nssg/utils/widgetChange.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../components/custom_appbar.dart';
import '../../components/custom_button.dart';
import '../../components/custom_text_styles.dart';
import '../../components/custom_rounded_container.dart';
import '../../components/custom_textfield.dart';
import '../../utils/app_colors.dart';

class AddQuotePage extends StatefulWidget {
  bool isBack;

  AddQuotePage(this.isBack, {Key? key}) : super(key: key);

  @override
  State<AddQuotePage> createState() => _AddQuotePageState();
}

class _AddQuotePageState extends State<AddQuotePage> {
  int currentStep = 0;

  PageController pageController = PageController();
  PageController pageController1 = PageController(initialPage: 2);
  ScrollController scroll = ScrollController();

  @override
  void initState() {
    super.initState();
    initialization();
    sampleData.add(RadioModel(false, '2 hr'));
    sampleData.add(RadioModel(false, '4 hr'));
    sampleData.add(RadioModel(false, '6 hr'));
    sampleData.add(RadioModel(false, '8 hr'));
  }

  //method for remove native splash screen
  void initialization() async {
    await Future.delayed(const Duration(seconds: 1));
    FlutterNativeSplash.remove();
  }

  functionCallback(BuildContext context) {
    Provider.of<WidgetChange>(context, listen: false).isReminder();
  }

  TextEditingController invoiceSearchController = TextEditingController();
  List<RadioModel> sampleData = <RadioModel>[];

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
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
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: pageController,
              onPageChanged: (page) {},
              children: <Widget>[
                buildStepOne(query, context),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10.sp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RoundedContainer(
                              containerText: "1",
                              stepText: "1",
                              isEnable: false,
                              isDone: true),
                          RoundedContainer(
                              containerText: "2",
                              stepText: "1",
                              isEnable: true,
                              isDone: false),
                          RoundedContainer(
                              containerText: "3",
                              stepText: "3",
                              isEnable: false,
                              isDone: false),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        LoaderContainer(lineColor: AppColors.transparent),
                        LoaderContainer(lineColor: AppColors.primaryColor),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 12.sp, vertical: 10.sp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(LabelString.lblQuoteDetails,
                              style: CustomTextStyle.labelBoldFontTextSmall),
                          Row(
                            children: [
                              Text(LabelString.lblStep,
                                  style: CustomTextStyle.commonText),
                              Text(" 2/7",
                                  style: CustomTextStyle.commonTextBlue),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  SingleChildScrollView buildStepOne(Size query, BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(10.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: query.width / 5),
                RoundedContainer(
                    containerText: "1",
                    stepText: "1",
                    isEnable: true,
                    isDone: false),
                RoundedContainer(
                    containerText: "2",
                    stepText: "2",
                    isEnable: false,
                    isDone: false),
              ],
            ),
          ),
          LoaderContainer(lineColor: AppColors.primaryColor),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 10.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(LabelString.lblQuoteDetails,
                    style: CustomTextStyle.labelBoldFontTextSmall),
                Row(
                  children: [
                    Text(LabelString.lblStep,
                        style: CustomTextStyle.commonText),
                    Text(" 1/7", style: CustomTextStyle.commonTextBlue),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 12.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  keyboardType: TextInputType.name,
                  readOnly: false,
                  controller: invoiceSearchController,
                  obscureText: false,
                  hint: LabelString.lblTypeToSearch,
                  titleText: LabelString.lblContactName,
                  isRequired: false,
                  suffixWidget: Icon(Icons.search, color: AppColors.blackColor),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(LabelString.lblViewContacts,
                      style: CustomTextStyle.commonTextBlue),
                ),
                SizedBox(height: 3.h),
                Text(LabelString.lblInstallationHours,
                    style: CustomTextStyle.labelFontText),
                SizedBox(height: 1.5.h),
                SizedBox(
                  height: 7.h,
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: sampleData.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        splashColor: AppColors.transparent,
                        highlightColor: AppColors.transparent,
                        onTap: () {
                          for (var element in sampleData) {
                            element.isSelected = false;
                          }
                          setState(() {});
                          sampleData[index].isSelected = true;
                          debugPrint(sampleData[index].buttonText);
                        },
                        child: RadioItem(sampleData[index]),
                      );
                    },
                    scrollDirection: Axis.horizontal,
                  ),
                ),
                Row(
                  children: [
                    Checkbox(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0)),
                        activeColor: AppColors.primaryColor,
                        onChanged: (value) => functionCallback(context),
                        value: Provider.of<WidgetChange>(context, listen: true)
                            .isReminderCheck),
                    Text(LabelString.lblQuoteEmailReminder,
                        style: CustomTextStyle.labelFontText)
                  ],
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 25.sp, horizontal: 2.0.sp),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(
                        width: query.width * 0.4,
                        height: query.height * 0.06,
                        child: CustomButton(
                            buttonColor: AppColors.redColor,
                            onClick: () {
                              pageController.previousPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.decelerate);
                              pageController1.previousPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.decelerate);
                            },
                            title: ButtonString.btnCancel),
                      ),
                      SizedBox(
                        width: query.width * 0.4,
                        height: query.height * 0.06,
                        child: CustomButton(
                          buttonColor: AppColors.primaryColor,
                          onClick: () {
                            pageController.nextPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.decelerate);
                            pageController1.nextPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.decelerate);
                          },
                          title: ButtonString.btnNext,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class RadioModel {
  bool isSelected;
  final String buttonText;

  RadioModel(this.isSelected, this.buttonText);
}

class RadioItem extends StatelessWidget {
  final RadioModel item;

  const RadioItem(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 4.sp, bottom: 4.sp, right: 6.sp),
      width: MediaQuery.of(context).size.width * 0.16,
      decoration: BoxDecoration(
        color: item.isSelected ? AppColors.primaryColor : AppColors.transparent,
        border: Border.all(width: 1.0, color: AppColors.primaryColor),
        borderRadius: BorderRadius.all(Radius.circular(5.sp)),
      ),
      child: Center(
        child: Text(item.buttonText,
            style: item.isSelected
                ? CustomTextStyle.buttonText
                : CustomTextStyle.labelFontText),
        //buttonText
      ),
    );
  }
}
