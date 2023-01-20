import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:nssg/constants/navigation.dart';
import 'package:nssg/constants/strings.dart';
import 'package:nssg/httpl_actions/handle_api_error.dart';
import 'package:nssg/screens/contact/contact_screen.dart';
import 'package:nssg/utils/preferences.dart';
import 'package:nssg/utils/widgetChange.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../components/custom_appbar.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_rounded_container.dart';
import '../../../components/custom_text_styles.dart';
import '../../../components/custom_textfield.dart';
import '../../../constants/constants.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/helpers.dart';
import '../../contact/add_contact/add_contact_model_dir/add_contact_response_model.dart';
import '../item_detail.dart';

class AddQuotePage extends StatefulWidget {
  bool isBack;

  AddQuotePage(this.isBack, {Key? key}) : super(key: key);

  @override
  State<AddQuotePage> createState() => _AddQuotePageState();
}

class _AddQuotePageState extends State<AddQuotePage> {
  PageController pageController = PageController();
  StreamController<int> streamController = StreamController<int>.broadcast();
  List contactData = [];

  String? contactId;

  @override
  void initState() {
    super.initState();
    addInstallationTime();
    addPremisesType();
    addNumberOfEngineer();
    getList();
  }

  getList() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? contact = preferences.getString(PreferenceString.contactList);
    contactData = jsonDecode(contact!);
    print("contactData $contactData");
  }

  //Add data for step one
  addInstallationTime() {
    sampleDataForStepOne.add(RadioModel(false, '2 hr'));
    sampleDataForStepOne.add(RadioModel(false, '4 hr'));
    sampleDataForStepOne.add(RadioModel(false, '6 hr'));
    sampleDataForStepOne.add(RadioModel(false, '8 hr'));
    sampleDataForStepOne.add(RadioModel(false, '1 Day'));
    sampleDataForStepOne.add(RadioModel(false, '2 Day'));
    sampleDataForStepOne.add(RadioModel(false, '3 Day'));
    sampleDataForStepOne.add(RadioModel(false, '4 Day'));
    sampleDataForStepOne.add(RadioModel(false, '5 Day'));
  }

  //Add data for step one
  addNumberOfEngineer() {
    numbersOfEng.add(RadioModel(false, '1'));
    numbersOfEng.add(RadioModel(false, '2'));
    numbersOfEng.add(RadioModel(false, '3'));
    numbersOfEng.add(RadioModel(false, '4'));
    numbersOfEng.add(RadioModel(false, '5'));
  }

  //Add data for step two
  addPremisesType() {
    sampleDataForStepTwo.add(RadioModel(false, "Banking"));
    sampleDataForStepTwo.add(RadioModel(false, "Commercial"));
    sampleDataForStepTwo.add(RadioModel(false, "Residential"));
    sampleDataForStepTwo.add(RadioModel(false, "Retail Store"));
    sampleDataForStepTwo.add(RadioModel(false, "School"));
  }

  TextEditingController invoiceSearchController = TextEditingController();

  List<RadioModel> sampleDataForStepOne = <RadioModel>[];
  List<RadioModel> sampleDataForStepTwo = <RadioModel>[];
  List<RadioModel> numbersOfEng = <RadioModel>[];

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: BaseAppBar(
        appBar: AppBar(),
        title: LabelString.lblAddNewQuote,
        isBack: widget.isBack,
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
              builder: (context, snapshot) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        snapshot.data! <= 0
                            ? Container(width: 19.5.w)
                            : RoundedContainer(
                                containerText: "",
                                stepText: snapshot.data.toString(),
                                isEnable: false,
                                isDone: true),
                        RoundedContainer(
                            containerText: (snapshot.data! + 1).toString(),
                            stepText: (snapshot.data! + 1).toString(),
                            isEnable: true,
                            isDone: false),
                        snapshot.data! >= 6
                            ? Container()
                            : RoundedContainer(
                                containerText: (snapshot.data! + 2).toString(),
                                stepText: (snapshot.data! + 2).toString(),
                                isEnable: false,
                                isDone: false)
                      ],
                    ),
                    SizedBox(height: 2.h),
                    StepProgressIndicator(
                      padding: 0.0,
                      totalSteps: 6,
                      size: 2.sp,
                      currentStep: snapshot.data!,
                      selectedColor: AppColors.primaryColor,
                      unselectedColor: AppColors.transparent,
                      customColor: (index) {
                        if (index + 1 == snapshot.data) {
                          return AppColors.primaryColor;
                        } else {
                          return index == 7
                              ? AppColors.redColor
                              : Colors.transparent;
                        }
                      },
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: 10.sp, right: 10.sp, top: 8.sp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          snapshot.data! == 5
                              ? Text(LabelString.lblAddressInformation,
                                  style: CustomTextStyle.labelBoldFontTextSmall)
                              : Text(LabelString.lblQuoteDetails,
                                  style:
                                      CustomTextStyle.labelBoldFontTextSmall),
                          Row(
                            children: [
                              Text(LabelString.lblStep,
                                  style: CustomTextStyle.commonText),
                              Text("${snapshot.data! + 1}/6",
                                  style: CustomTextStyle.commonTextBlue),
                            ],
                          )
                        ],
                      ),
                    )
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
                buildStepTwo(context, query),
                buildStepThree(context, query),
                buildStepFour(context, query),
                buildStepFive(context, query),
                buildStepSix(context, query),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ///step 1
  Padding buildStepOne(BuildContext context, Size query) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 12.sp),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Autocomplete(
            fieldViewBuilder: (context, textEditingController, focusNode,
                VoidCallback onFieldSubmitted) {
              return TextField(
                style: TextStyle(color: AppColors.blackColor),
                textCapitalization: TextCapitalization.none,
                textInputAction: TextInputAction.next,
                maxLines: 1,
                cursorColor: AppColors.blackColor,
                decoration: InputDecoration(
                    suffixIcon: Icon(Icons.search, color: AppColors.blackColor),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                            width: 2, color: AppColors.primaryColor)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                            width: 2, color: AppColors.primaryColor)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                            width: 2, color: AppColors.primaryColor)),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.only(left: 12.sp),
                    hintText: LabelString.lblTypeToSearch,
                    hintStyle: CustomTextStyle.labelFontHintText,
                    counterText: ""),
                controller: textEditingController,
                focusNode: focusNode,
                onEditingComplete: () {},
                onSubmitted: (String value) {},
              );
            },
            optionsBuilder: (TextEditingValue textEditingValue) async {
              if (textEditingValue.text.length <= 2) {
                return const Iterable<String>.empty();
              } else {
                List<String> matchesContact = <String>[];

                matchesContact.addAll(contactData.map((e) {
                  return "${e["firstname"]} ${e["lastname"]}";
                }));

                matchesContact = matchesContact
                    .where((element) => element.contains(textEditingValue.text))
                    .toList();
                return matchesContact;
              }
            },
            onSelected: (selection) async {
              for (int i = 0; i < contactData.length; i++) {
                if (selection ==
                    "${contactData[i]["firstname"]} ${contactData[i]["lastname"]}") {
                  contactId = contactData[i]["id"];
                }
              }
            },
          ),

          //View Contact Button
          Align(
            alignment: Alignment.topRight,
            child: InkWell(
              highlightColor: AppColors.transparent,
              splashColor: AppColors.transparent,
              onTap: () {
                if (contactId != null) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 0,
                          insetPadding: EdgeInsets.symmetric(horizontal: 12.sp),
                          child: ContactDetail(contactId));
                    },
                  );
                } else {
                  Helpers.showSnackBar(context, ErrorString.selectOneContact,
                      isError: true);
                }
              },
              child: Padding(
                padding: EdgeInsets.only(top: 10.sp),
                child: Text(LabelString.lblViewContacts,
                    style: CustomTextStyle.commonTextBlue),
              ),
            ),
          ),
          SizedBox(height: 3.h),
          Text(LabelString.lblNumberOfEngineer,
              style: CustomTextStyle.labelFontText),
          SizedBox(height: 1.5.h),
          Wrap(
            spacing: 5,
            children: List.generate(
              numbersOfEng.length,
              (index) {
                return SizedBox(
                  height: 6.h,
                  width: 12.w,
                  child: InkWell(
                    splashColor: AppColors.transparent,
                    highlightColor: AppColors.transparent,
                    onTap: () {
                      for (var element in numbersOfEng) {
                        element.isSelected = false;
                      }

                      Provider.of<WidgetChange>(context, listen: false)
                          .isSelectEngineers();
                      numbersOfEng[index].isSelected = true;
                      Provider.of<WidgetChange>(context, listen: false)
                          .isSetEngineer;
                    },
                    child: RadioItem(numbersOfEng[index]),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 2.h),
          Text(LabelString.lblInstallationHours,
              style: CustomTextStyle.labelFontText),
          SizedBox(height: 1.5.h),
          Wrap(
            spacing: 5,
            children: List.generate(
              sampleDataForStepOne.length,
              (index) {
                return SizedBox(
                  height: 6.h,
                  width: sampleDataForStepOne[index].buttonText.endsWith("Day")
                      ? 17.w
                      : 18.w,
                  child: InkWell(
                    splashColor: AppColors.transparent,
                    highlightColor: AppColors.transparent,
                    onTap: () {
                      for (var element in sampleDataForStepOne) {
                        element.isSelected = false;
                      }
                      //setState(() {});
                      Provider.of<WidgetChange>(context, listen: false)
                          .isSelectTime();
                      sampleDataForStepOne[index].isSelected = true;
                      Provider.of<WidgetChange>(context, listen: false)
                          .isSetTime;
                    },
                    child: RadioItem(sampleDataForStepOne[index]),
                  ),
                );
              },
            ),
          ),
          Row(
            children: [
              Checkbox(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0)),
                  activeColor: AppColors.primaryColor,
                  onChanged: (value) =>
                      Provider.of<WidgetChange>(context, listen: false)
                          .isReminder(),
                  value: Provider.of<WidgetChange>(context, listen: true)
                      .isReminderCheck),
              Text(LabelString.lblQuoteEmailReminder,
                  style: CustomTextStyle.labelFontText)
            ],
          ),
          SizedBox(height: query.height * 0.075),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.sp, horizontal: 2.sp),
            child: BottomButton(pageController, "Cancel"),
          )
        ],
      ),
    );
  }

  ///step 2
  Padding buildStepTwo(BuildContext context, Size query) {
    return Padding(
      padding: EdgeInsets.only(right: 12.sp, left: 12.sp, bottom: 12.sp),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(LabelString.lblPremisesType,
                  style: CustomTextStyle.labelBoldFontTextSmall),
              SizedBox(height: 4.h),
              Wrap(
                spacing: 15.sp,
                direction: Axis.horizontal,
                alignment: WrapAlignment.spaceBetween,
                runSpacing: 15.sp,
                children: List.generate(
                  sampleDataForStepTwo.length,
                  (index) {
                    return InkWell(
                        splashColor: AppColors.transparent,
                        highlightColor: AppColors.transparent,
                        onTap: () {
                          for (var element in sampleDataForStepTwo) {
                            element.isSelected = false;
                          }
                          Provider.of<WidgetChange>(context, listen: false)
                              .isSelectPremisesType();
                          sampleDataForStepTwo[index].isSelected = true;
                          Provider.of<WidgetChange>(context, listen: false)
                              .isSetPremises;
                        },
                        child: sampleDataForStepTwo[index].isSelected
                            ? Container(
                                height: 15.h,
                                width: 42.w,
                                decoration: BoxDecoration(
                                    color: AppColors.primaryColor
                                        .withOpacity(0.15),
                                    border: Border.all(
                                        color: AppColors.primaryColor,
                                        width: 1),
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(Icons.account_balance_outlined,
                                              color: AppColors.primaryColor,
                                              size: 35.sp),
                                          SizedBox(height: 1.h),
                                          Text(
                                              sampleDataForStepTwo[index]
                                                  .buttonText,
                                              style: CustomTextStyle
                                                  .commonTextBlue)
                                        ]),
                                    Positioned(
                                      right: 10,
                                      top: 5,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(80.0),
                                            color: AppColors.greenColor),
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Icon(Icons.done,
                                              color: AppColors.whiteColor,
                                              size: 14.sp),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : Container(
                                height: 15.h,
                                width: 42.w,
                                decoration: BoxDecoration(
                                    color: AppColors.whiteColor,
                                    border: Border.all(
                                        color: AppColors.borderColor, width: 2),
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(Icons.account_balance_outlined,
                                          color: AppColors.blackColor,
                                          size: 35.sp),
                                      SizedBox(height: 1.h),
                                      Text(
                                          sampleDataForStepTwo[index]
                                              .buttonText,
                                          style: CustomTextStyle.commonText)
                                    ]),
                              ));
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.sp, vertical: 12.sp),
            child: BottomButton(pageController, "Previous"),
          )
        ],
      ),
    );
  }

  ///step 3
  ListView buildStepThree(BuildContext context, Size query) {
    return ListView(
      children: [
        SizedBox(height: 1.h),
        Text(LabelString.lblSystemType,
            textAlign: TextAlign.center,
            style: CustomTextStyle.labelBoldFontTextSmall),
        SizedBox(height: 2.h),
        Wrap(
          spacing: 15.sp,
          direction: Axis.horizontal,
          alignment: WrapAlignment.center,
          runSpacing: 14.sp,
          children: List.generate(
            7,
            (index) {
              return Container(
                height: 16.h,
                width: query.width / 1.13,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.borderColor, width: 2),
                    borderRadius: BorderRadius.circular(10.0)),
                child: InkWell(
                  splashColor: AppColors.transparent,
                  highlightColor: AppColors.transparent,
                  onTap: () {},
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.watch_later_outlined,
                            color: AppColors.primaryColor, size: 30.sp),
                        SizedBox(height: 1.h),
                        Text("Intruder & Hold Up Alarm:\n PD6662:2017",
                            textAlign: TextAlign.center,
                            style: CustomTextStyle.labelFontText)
                      ]),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.sp, vertical: 15.sp),
          child: BottomButton(pageController, "Previous"),
        )
      ],
    );
  }

  ///step 4
  ListView buildStepFour(BuildContext context, Size query) {
    return ListView(
      children: [
        SizedBox(height: 1.h),
        Text(LabelString.lblGradeNumber,
            textAlign: TextAlign.center,
            style: CustomTextStyle.labelBoldFontTextSmall),
        SizedBox(height: 2.h),
        Wrap(
          spacing: 10.sp,
          direction: Axis.horizontal,
          alignment: WrapAlignment.center,
          runSpacing: 10.sp,
          children: List.generate(
            2,
            (index) {
              return Container(
                height: 15.h,
                width: 42.w,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.borderColor, width: 2),
                    borderRadius: BorderRadius.circular(10.0)),
                child: InkWell(
                  splashColor: AppColors.transparent,
                  highlightColor: AppColors.transparent,
                  onTap: () {},
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.star_border_sharp,
                            color: AppColors.primaryColor, size: 30.sp),
                        SizedBox(height: 1.h),
                        Text("Grade ${index + 2}",
                            style: CustomTextStyle.labelFontText)
                      ]),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 2.h),
        Text(LabelString.lblSignallingType,
            textAlign: TextAlign.center,
            style: CustomTextStyle.labelBoldFontTextSmall),
        SizedBox(height: 2.h),
        Wrap(
          spacing: 15.sp,
          direction: Axis.horizontal,
          alignment: WrapAlignment.center,
          runSpacing: 14.sp,
          children: List.generate(
            7,
            (index) {
              return Container(
                height: 16.h,
                width: query.width / 1.13,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.borderColor, width: 2),
                    borderRadius: BorderRadius.circular(10.0)),
                child: InkWell(
                  splashColor: AppColors.transparent,
                  highlightColor: AppColors.transparent,
                  onTap: () {},
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.settings,
                            color: AppColors.primaryColor, size: 30.sp),
                        SizedBox(height: 1.h),
                        Text("Access Controll System",
                            style: CustomTextStyle.labelFontText)
                      ]),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.sp, vertical: 15.sp),
          child: BottomButton(pageController, "Previous"),
        )
      ],
    );
  }

  ///step 5
  ListView buildStepFive(BuildContext context, Size query) {
    return ListView(
      children: [
        SizedBox(height: 1.h),
        Text(LabelString.lblQuotePayment,
            textAlign: TextAlign.center,
            style: CustomTextStyle.labelBoldFontTextSmall),
        SizedBox(height: 2.h),
        Wrap(
          spacing: 10.sp,
          direction: Axis.horizontal,
          alignment: WrapAlignment.center,
          runSpacing: 10.sp,
          children: List.generate(
            2,
            (index) {
              return Container(
                height: 15.h,
                width: 42.w,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.borderColor, width: 2),
                    borderRadius: BorderRadius.circular(10.0)),
                child: InkWell(
                  splashColor: AppColors.transparent,
                  highlightColor: AppColors.transparent,
                  onTap: () {},
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.cases_outlined,
                            color: AppColors.primaryColor, size: 30.sp),
                        SizedBox(height: 1.h),
                        Text("Deposite", style: CustomTextStyle.labelFontText)
                      ]),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 2.h),
        Text(LabelString.lblTerms,
            textAlign: TextAlign.center,
            style: CustomTextStyle.labelBoldFontTextSmall),
        SizedBox(height: 2.h),
        Wrap(
          spacing: 15.sp,
          direction: Axis.horizontal,
          alignment: WrapAlignment.center,
          runSpacing: 14.sp,
          children: List.generate(
            7,
            (index) {
              return Container(
                height: 16.h,
                width: query.width / 1.13,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.borderColor, width: 2),
                    borderRadius: BorderRadius.circular(10.0)),
                child: InkWell(
                  splashColor: AppColors.transparent,
                  highlightColor: AppColors.transparent,
                  onTap: () {},
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.watch_later_outlined,
                            color: AppColors.primaryColor, size: 30.sp),
                        SizedBox(height: 1.h),
                        Text("Banking", style: CustomTextStyle.labelFontText)
                      ]),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.sp, vertical: 15.sp),
          child: BottomButton(pageController, "Previous"),
        )
      ],
    );
  }

  ///step 6
  ListView buildStepSix(BuildContext context, Size query) {
    return ListView(
      children: [
        SizedBox(height: 1.h),
        Text(LabelString.lblInstallationAddressDetails,
            textAlign: TextAlign.center,
            style: CustomTextStyle.labelBoldFontTextSmall),
        SizedBox(height: 2.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.sp, vertical: 15.sp),
          child: BottomButton(pageController, "Previous"),
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

class BottomButton extends StatelessWidget {
  PageController pageController;
  String buttonString;

  BottomButton(this.pageController, this.buttonString, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          //previous button
          buttonString == "Cancel"
              ? SizedBox(
                  width: query.width * 0.4,
                  height: query.height * 0.06,
                  child: CustomButton(
                      //update button
                      title: ButtonString.btnCancel,
                      onClick: () => Navigator.of(context).pop(),
                      buttonColor: AppColors.redColor),
                )
              : SizedBox(
                  width: query.width * 0.4,
                  height: query.height * 0.06,
                  child: BorderButton(
                      btnString: ButtonString.btnPrevious,
                      onClick: () => pageController.previousPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.decelerate))),
          //submit or update button
          SizedBox(
              width: query.width * 0.4,
              height: query.height * 0.06,
              child: CustomButton(
                  //update button
                  title: ButtonString.btnNext,
                  onClick: () {
                    debugPrint(pageController.page.toString());
                    if (pageController.page == 5.0) {
                      callNextScreen(context, const BuildItemDetail());
                    } else {
                      return pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.decelerate);
                    }
                  },
                  buttonColor: AppColors.primaryColor))
        ]);
  }
}
