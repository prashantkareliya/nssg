import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nssg/constants/strings.dart';
import 'package:nssg/utils/widgetChange.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../components/custom_appbar.dart';
import '../../components/custom_button.dart';
import '../../components/custom_rounded_container.dart';
import '../../components/custom_text_styles.dart';
import '../../components/custom_textfield.dart';
import '../../utils/app_colors.dart';

class AddQuotePage extends StatefulWidget {
  bool isBack;

  AddQuotePage(this.isBack, {Key? key}) : super(key: key);

  @override
  State<AddQuotePage> createState() => _AddQuotePageState();
}

class _AddQuotePageState extends State<AddQuotePage> {
  PageController pageController = PageController();
  StreamController<int> streamController = StreamController<int>.broadcast();

  @override
  void initState() {
    super.initState();
    sampleData.add(RadioModel(false, '2 hr'));
    sampleData.add(RadioModel(false, '4 hr'));
    sampleData.add(RadioModel(false, '6 hr'));
    sampleData.add(RadioModel(false, '8 hr'));
    sampleData.add(RadioModel(false, '1 Day'));
    sampleData.add(RadioModel(false, '2 Day'));
    sampleData.add(RadioModel(false, '3 Day'));
    sampleData.add(RadioModel(false, '4 Day'));
    sampleData.add(RadioModel(false, '5 Day'));
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
            child: StreamBuilder<int>(
              initialData: 0,
              stream: streamController.stream,
              builder: (context, snapshot1) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        snapshot1.data! <= 0
                            ? Container(width: 19.5.w)
                            : RoundedContainer(
                                containerText: "",
                                stepText: snapshot1.data.toString(),
                                isEnable: false,
                                isDone: true),
                        RoundedContainer(
                            containerText: (snapshot1.data! + 1).toString(),
                            stepText: (snapshot1.data! + 1).toString(),
                            isEnable: true,
                            isDone: false),
                        snapshot1.data! >= 6
                            ? Container()
                            : RoundedContainer(
                                containerText: (snapshot1.data! + 2).toString(),
                                stepText: (snapshot1.data! + 2).toString(),
                                isEnable: false,
                                isDone: false)
                      ],
                    ),
                    SizedBox(height: 2.h),
                    StepProgressIndicator(
                      padding: 0.0,
                      totalSteps: 6,
                      size: 2.sp,
                      currentStep: snapshot1.data!,
                      selectedColor: AppColors.primaryColor,
                      unselectedColor: AppColors.transparent,
                      customColor: (index) {
                        if (index + 1 == snapshot1.data) {
                          return AppColors.primaryColor;
                        } else {
                          return index == 7
                              ? AppColors.redColor
                              : Colors.transparent;
                        }
                      },
                    ),
                  ],
                );
              },
            ),
          ),
          Expanded(
            child: PageView(
              scrollDirection: Axis.horizontal,
              pageSnapping: true,
              physics: const BouncingScrollPhysics(),
              controller: pageController,
              onPageChanged: (number) {
                streamController.add(number);
              },
              children: [
                buildStepOne(context, query),
                buildStepOne(context, query),
                buildStepOne(context, query),
                buildStepOne(context, query),
                buildStepOne(context, query),
                buildStepOne(context, query),
                buildStepOne(context, query),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Column buildStepOne(BuildContext context, Size query) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 10.sp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(LabelString.lblQuoteDetails,
                  style: CustomTextStyle.labelBoldFontTextSmall),
              Row(
                children: [
                  Text(LabelString.lblStep, style: CustomTextStyle.commonText),
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
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.decelerate);
                        },
                        title: ButtonString.btnNext,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        )
      ],
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

  const RadioItem(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 4.sp, bottom: 4.sp, right: 6.sp),
      width: MediaQuery.of(context).size.width * 0.16,
      decoration: BoxDecoration(
          color:
              item.isSelected ? AppColors.primaryColor : AppColors.transparent,
          border: Border.all(width: 1.0, color: AppColors.primaryColor),
          borderRadius: BorderRadius.all(Radius.circular(5.sp))),
      child: Center(
          child: Text(item.buttonText,
              style: item.isSelected
                  ? CustomTextStyle.buttonText
                  : CustomTextStyle.labelFontText)),
    );
  }
}
