import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nssg/components/svg_extension.dart';
import 'package:nssg/constants/navigation.dart';
import 'package:nssg/constants/strings.dart';
import 'package:nssg/screens/contact/contact_screen.dart';
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
import '../../../httpl_actions/handle_api_error.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/helpers.dart';
import '../../../utils/widgets.dart';
import '../item_detail.dart';
import 'package:nssg/httpl_actions/app_http.dart';
import 'package:http/http.dart' as http;

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
  Future<dynamic>? getFields;

  @override
  void initState() {
    super.initState();
    getList();
  }

  getList() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? contact = preferences.getString(PreferenceString.contactList);
    contactData = jsonDecode(contact!);
    print("contactData $contactData");
  }

  TextEditingController invoiceSearchController = TextEditingController();

  //Address information's textField controllers(invoice Address)
  TextEditingController invoiceAddressController = TextEditingController();
  TextEditingController invoiceCityController = TextEditingController();
  TextEditingController invoiceCountryController = TextEditingController();
  TextEditingController invoicePostalController = TextEditingController();

  //Address information's textField controllers(installation Address)
  TextEditingController installationAddressController = TextEditingController();
  TextEditingController installationCityController = TextEditingController();
  TextEditingController installationCountryController = TextEditingController();
  TextEditingController installationPostalController = TextEditingController();

  List addressList = [];

  //This lists for add quote dropdown fields
  List<RadioModel> numbersOfEng = <RadioModel>[]; //step 1
  List<RadioModel> installationTiming = <RadioModel>[]; //step 1
  List<RadioModel> premisesType = <RadioModel>[]; //step 2
  List<RadioModel> systemType = <RadioModel>[]; //step 3
  List<RadioModel> gradeNumber = <RadioModel>[]; //step 4
  List<RadioModel> fireNumber = <RadioModel>[]; //step 4
  List<RadioModel> signallingType = <RadioModel>[]; //step 4
  List<RadioModel> quotePayment = <RadioModel>[]; //step 5
  List<RadioModel> termsList = <RadioModel>[]; //step 5

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    getFields = getQuoteFields();
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
                        snapshot.data! >= 5
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
          FutureBuilder<dynamic>(
              future: getFields,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var fieldsData = snapshot.data["result"];
                  return Expanded(
                    child: PageView(
                      scrollDirection: Axis.horizontal,
                      pageSnapping: true,
                      physics: const BouncingScrollPhysics(),
                      controller: pageController,
                      onPageChanged: (number) {
                        streamController.add(number);
                      },
                      children: [
                        buildStepOne(context, query, fieldsData),
                        buildStepTwo(context, query, fieldsData),
                        buildStepThree(context, query, fieldsData),
                        buildStepFour(context, query, fieldsData),
                        buildStepFive(context, query, fieldsData),
                        buildStepSix(context, query),
                      ],
                    ),
                  );
                } else if (snapshot.hasError) {
                  final message = HandleAPI.handleAPIError(snapshot.error);
                  return Text(message);
                }
                return SizedBox(height: 70.h, child: loadingView());
              }),
        ],
      ),
    );
  }

  ///step 1
  Padding buildStepOne(BuildContext context, Size query, stepOneData) {
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

                  //When select contact, set address in fields
                  invoiceAddressController.text =
                      contactData[i]["mailingstreet"];
                  invoiceCityController.text = contactData[i]["mailingcity"];
                  invoiceCountryController.text =
                      contactData[i]["mailingcountry"];
                  invoicePostalController.text = contactData[i]["mailingzip"];

                  installationAddressController.text =
                      contactData[i]["otherstreet"];
                  installationCityController.text = contactData[i]["othercity"];
                  installationCountryController.text =
                      contactData[i]["othercountry"];
                  installationPostalController.text =
                      contactData[i]["otherzip"];
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
              stepOneData["quote_no_of_engineer"].length,
              (index) {
                numbersOfEng.add(RadioModel(false,
                    stepOneData["quote_no_of_engineer"][index]["label"]));
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
              stepOneData["quote_req_to_complete_work"].length,
              (index) {
                installationTiming.add(RadioModel(false,
                    stepOneData["quote_req_to_complete_work"][index]["label"]));
                return SizedBox(
                  height: 6.h,
                  width: 20.w,
                  child: InkWell(
                    splashColor: AppColors.transparent,
                    highlightColor: AppColors.transparent,
                    onTap: () {
                      for (var element in installationTiming) {
                        element.isSelected = false;
                      }
                      print(installationTiming[index].buttonText);
                      Provider.of<WidgetChange>(context, listen: false)
                          .isSelectTime();
                      installationTiming[index].isSelected = true;
                      Provider.of<WidgetChange>(context, listen: false)
                          .isSetTime;
                    },
                    child: RadioItem(installationTiming[index]),
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
  Padding buildStepTwo(BuildContext context, Size query, stepTwoData) {
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
                  stepTwoData["premises_type"].length,
                  (index) {
                    premisesType.add(RadioModel(
                        false, stepTwoData["premises_type"][index]["label"]));
                    return InkWell(
                        splashColor: AppColors.transparent,
                        highlightColor: AppColors.transparent,
                        onTap: () {
                          for (var element in premisesType) {
                            element.isSelected = false;
                          }
                          print(
                              "${ImageBaseUrl.imageBase} ${premisesType[index].buttonText.toLowerCase().replaceAll(" ", "")}");
                          Provider.of<WidgetChange>(context, listen: false)
                              .isSelectPremisesType();
                          premisesType[index].isSelected = true;
                          Provider.of<WidgetChange>(context, listen: false)
                              .isSetPremises;
                        },
                        child: Container(
                          height: 15.h,
                          width: 42.w,
                          decoration: BoxDecoration(
                              color: premisesType[index].isSelected
                                  ? AppColors.primaryColorLawOpacity
                                  : AppColors.whiteColor,
                              border: Border.all(
                                  color: premisesType[index].isSelected
                                      ? AppColors.primaryColor
                                      : AppColors.borderColor,
                                  width: 1),
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgExtension(
                                        iconColor:
                                            premisesType[index].isSelected
                                                ? AppColors.primaryColor
                                                : AppColors.blackColor,
                                        itemName:
                                            premisesType[index].buttonText),
                                    SizedBox(height: 1.h),
                                    Text(premisesType[index].buttonText,
                                        style: premisesType[index].isSelected
                                            ? CustomTextStyle.commonTextBlue
                                            : CustomTextStyle.commonText)
                                  ]),
                              Visibility(
                                visible: premisesType[index].isSelected
                                    ? true
                                    : false,
                                child: Positioned(
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
                                ),
                              )
                            ],
                          ),
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
  ListView buildStepThree(BuildContext context, Size query, stepThreeData) {
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
            stepThreeData["system_type"].length - 9,
            (index) {
              systemType.add(RadioModel(
                  false, stepThreeData["system_type"][index]["label"]));
              return Container(
                height: 16.h,
                width: query.width / 1.13,
                decoration: BoxDecoration(
                    color: systemType[index].isSelected
                        ? AppColors.primaryColorLawOpacity
                        : AppColors.whiteColor,
                    border: Border.all(
                        color: systemType[index].isSelected
                            ? AppColors.primaryColor
                            : AppColors.borderColor,
                        width: 1),
                    borderRadius: BorderRadius.circular(10.0)),
                child: InkWell(
                  splashColor: AppColors.transparent,
                  highlightColor: AppColors.transparent,
                  onTap: () {
                    for (var element in systemType) {
                      element.isSelected = false;
                    }

                    Provider.of<WidgetChange>(context, listen: false)
                        .isSelectSystemType();
                    systemType[index].isSelected = true;
                    Provider.of<WidgetChange>(context, listen: false)
                        .isSetSystem;
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgExtension(
                                itemName: stepThreeData["system_type"][index]
                                    ["label"],
                                iconColor: systemType[index].isSelected
                                    ? AppColors.primaryColor
                                    : AppColors.blackColor),
                            SizedBox(height: 1.h),
                            SizedBox(
                              width: query.width * 0.7,
                              child: Text(
                                  stepThreeData["system_type"][index]["label"],
                                  textAlign: TextAlign.center,
                                  style: systemType[index].isSelected
                                      ? CustomTextStyle.commonTextBlue
                                      : CustomTextStyle.commonText),
                            )
                          ]),
                      Visibility(
                        visible: systemType[index].isSelected ? true : false,
                        child: Positioned(
                          right: 10,
                          top: 5,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(80.0),
                                color: AppColors.greenColor),
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Icon(Icons.done,
                                  color: AppColors.whiteColor, size: 14.sp),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
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
  ListView buildStepFour(BuildContext context, Size query, stepFourData) {
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
              gradeNumber.add(RadioModel(
                  false, stepFourData["system_type"][index]["label"]));
              return Container(
                height: 15.h,
                width: 42.w,
                decoration: BoxDecoration(
                    color: gradeNumber[index].isSelected
                        ? AppColors.primaryColorLawOpacity
                        : AppColors.whiteColor,
                    border: Border.all(
                        color: gradeNumber[index].isSelected
                            ? AppColors.primaryColor
                            : AppColors.borderColor,
                        width: 1),
                    borderRadius: BorderRadius.circular(10.0)),
                child: InkWell(
                  splashColor: AppColors.transparent,
                  highlightColor: AppColors.transparent,
                  onTap: () {
                    for (var element in gradeNumber) {
                      element.isSelected = false;
                    }

                    Provider.of<WidgetChange>(context, listen: false)
                        .isSelectGrade();
                    gradeNumber[index].isSelected = true;
                    Provider.of<WidgetChange>(context, listen: false)
                        .isSetGrade;
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgExtension(
                                itemName: stepFourData["grade_number"][index]
                                    ["label"],
                                iconColor: gradeNumber[index].isSelected
                                    ? AppColors.primaryColor
                                    : AppColors.blackColor),
                            SizedBox(height: 1.h),
                            Text(stepFourData["grade_number"][index]["label"],
                                style: gradeNumber[index].isSelected
                                    ? CustomTextStyle.commonTextBlue
                                    : CustomTextStyle.commonText)
                          ]),
                      Visibility(
                        visible: gradeNumber[index].isSelected ? true : false,
                        child: Positioned(
                          right: 10,
                          top: 5,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(80.0),
                                color: AppColors.greenColor),
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Icon(Icons.done,
                                  color: AppColors.whiteColor, size: 14.sp),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
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
            // stepFourData["signalling_type"].length
            12,
            (index) {
              signallingType.add(RadioModel(
                  false, stepFourData["signalling_type"][index]["label"]));
              return Container(
                height: 16.h,
                width: query.width / 1.13,
                decoration: BoxDecoration(
                    color: signallingType[index].isSelected
                        ? AppColors.primaryColorLawOpacity
                        : AppColors.whiteColor,
                    border: Border.all(
                        color: signallingType[index].isSelected
                            ? AppColors.primaryColor
                            : AppColors.borderColor,
                        width: 1),
                    borderRadius: BorderRadius.circular(10.0)),
                child: InkWell(
                  splashColor: AppColors.transparent,
                  highlightColor: AppColors.transparent,
                  onTap: () {
                    for (var element in signallingType) {
                      element.isSelected = false;
                    }

                    Provider.of<WidgetChange>(context, listen: false)
                        .isSelectSignallingType();
                    signallingType[index].isSelected = true;
                    Provider.of<WidgetChange>(context, listen: false)
                        .isSetSignallingType;
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgExtension(
                                itemName: stepFourData["signalling_type"][index]
                                    ["label"],
                                iconColor: signallingType[index].isSelected
                                    ? AppColors.primaryColor
                                    : AppColors.blackColor),
                            SizedBox(height: 1.h),
                            Text(
                                stepFourData["signalling_type"][index]["label"],
                                style: signallingType[index].isSelected
                                    ? CustomTextStyle.commonTextBlue
                                    : CustomTextStyle.commonText)
                          ]),
                      Visibility(
                        visible:
                            signallingType[index].isSelected ? true : false,
                        child: Positioned(
                          right: 10,
                          top: 5,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(80.0),
                                color: AppColors.greenColor),
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Icon(Icons.done,
                                  color: AppColors.whiteColor, size: 14.sp),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
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
  ListView buildStepFive(BuildContext context, Size query, stepFiveData) {
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
            stepFiveData["quotes_payment"].length,
            (index) {
              quotePayment.add(RadioModel(
                  false, stepFiveData["quotes_payment"][index]["label"]));
              return Container(
                height: 15.h,
                width: 42.w,
                decoration: BoxDecoration(
                    color: quotePayment[index].isSelected
                        ? AppColors.primaryColorLawOpacity
                        : AppColors.whiteColor,
                    border: Border.all(
                        color: quotePayment[index].isSelected
                            ? AppColors.primaryColor
                            : AppColors.borderColor,
                        width: 1),
                    borderRadius: BorderRadius.circular(10.0)),
                child: InkWell(
                  splashColor: AppColors.transparent,
                  highlightColor: AppColors.transparent,
                  onTap: () {
                    for (var element in quotePayment) {
                      element.isSelected = false;
                    }

                    Provider.of<WidgetChange>(context, listen: false)
                        .isSelectQuotePayment();
                    quotePayment[index].isSelected = true;
                    Provider.of<WidgetChange>(context, listen: false)
                        .isQuotePayment;
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgExtension(
                                itemName: stepFiveData["quotes_payment"][index]
                                    ["label"],
                                iconColor: quotePayment[index].isSelected
                                    ? AppColors.primaryColor
                                    : AppColors.blackColor),
                            SizedBox(height: 1.h),
                            Text(stepFiveData["quotes_payment"][index]["label"],
                                style: quotePayment[index].isSelected
                                    ? CustomTextStyle.commonTextBlue
                                    : CustomTextStyle.commonText)
                          ]),
                      Visibility(
                        visible: quotePayment[index].isSelected ? true : false,
                        child: Positioned(
                          right: 10,
                          top: 5,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(80.0),
                                color: AppColors.greenColor),
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Icon(Icons.done,
                                  color: AppColors.whiteColor, size: 14.sp),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
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
            stepFiveData["quotes_terms"].length,
            (index) {
              termsList.add(RadioModel(
                  false, stepFiveData["quotes_terms"][index]["label"]));
              return Container(
                height: 16.h,
                width: query.width / 1.13,
                decoration: BoxDecoration(
                    color: termsList[index].isSelected
                        ? AppColors.primaryColorLawOpacity
                        : AppColors.whiteColor,
                    border: Border.all(
                        color: termsList[index].isSelected
                            ? AppColors.primaryColor
                            : AppColors.borderColor,
                        width: 1),
                    borderRadius: BorderRadius.circular(10.0)),
                child: InkWell(
                  splashColor: AppColors.transparent,
                  highlightColor: AppColors.transparent,
                  onTap: () {
                    for (var element in termsList) {
                      element.isSelected = false;
                    }

                    Provider.of<WidgetChange>(context, listen: false)
                        .isSelectTerms();
                    termsList[index].isSelected = true;
                    Provider.of<WidgetChange>(context, listen: false).isTerms;
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgExtension(
                                itemName: stepFiveData["quotes_terms"][index]
                                    ["label"],
                                iconColor: termsList[index].isSelected
                                    ? AppColors.primaryColor
                                    : AppColors.blackColor),
                            SizedBox(height: 1.h),
                            SizedBox(
                              width: query.width * 0.7,
                              child: Text(
                                  stepFiveData["quotes_terms"][index]["label"],
                                  style: termsList[index].isSelected
                                      ? CustomTextStyle.commonTextBlue
                                      : CustomTextStyle.commonText,
                                  textAlign: TextAlign.center),
                            )
                          ]),
                      Visibility(
                        visible: termsList[index].isSelected ? true : false,
                        child: Positioned(
                          right: 10,
                          top: 5,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(80.0),
                                color: AppColors.greenColor),
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Icon(Icons.done,
                                  color: AppColors.whiteColor, size: 14.sp),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
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
  Padding buildStepSix(BuildContext context, Size query) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.sp),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Center(
                child: Text(LabelString.lblInvoiceAddressDetails,
                    style: CustomTextStyle.labelBoldFontTextBlue)),
            SizedBox(height: 2.0.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(LabelString.lblAddressSearch,
                    style: CustomTextStyle.labelFontText),
                SizedBox(height: 1.h),
                autoComplete("invoice"),
              ],
            ),
            SizedBox(height: 2.h),
            MultiLineTextField(
              keyboardType: TextInputType.name,
              readOnly: false,
              controller: invoiceAddressController,
              obscureText: false,
              hint: LabelString.lblTypeAddress,
              titleText: LabelString.lblInvoiceAddress,
              isRequired: true,
            ),
            CustomTextField(
              keyboardType: TextInputType.name,
              readOnly: false,
              controller: invoiceCityController,
              obscureText: false,
              hint: LabelString.lblInvoiceCity,
              titleText: LabelString.lblInvoiceCity,
              isRequired: true,
            ),
            CustomTextField(
              keyboardType: TextInputType.name,
              readOnly: false,
              controller: invoiceCountryController,
              obscureText: false,
              hint: LabelString.lblInvoiceCountry,
              titleText: LabelString.lblInvoiceCountry,
              isRequired: true,
            ),
            CustomTextField(
              keyboardType: TextInputType.name,
              readOnly: false,
              controller: invoicePostalController,
              obscureText: false,
              hint: LabelString.lblInvoicePostalCode,
              titleText: LabelString.lblInvoicePostalCode,
              isRequired: true,
            ),
            SizedBox(height: 1.0.h),
            Center(
              child: Text(LabelString.lblInstallationAddressDetails,
                  style: CustomTextStyle.labelBoldFontTextBlue),
            ),
            SizedBox(height: 2.0.h),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(LabelString.lblAddressSearch,
                        style: CustomTextStyle.labelFontText),
                    InkWell(
                      onTap: () {
                        copyAddressFields();
                      },
                      child: Image.asset(ImageString.icCopy, height: 2.8.h),
                    ),
                  ],
                ),
                SizedBox(height: 1.h),
                autoComplete("installation"),
                SizedBox(height: 2.h),
              ],
            ),
            MultiLineTextField(
              keyboardType: TextInputType.name,
              readOnly: false,
              controller: installationAddressController,
              obscureText: false,
              hint: LabelString.lblTypeAddress,
              titleText: LabelString.lblInstallationAddress,
              isRequired: true,
            ),
            CustomTextField(
              keyboardType: TextInputType.name,
              readOnly: false,
              controller: installationCityController,
              obscureText: false,
              hint: LabelString.lblInstallationCity,
              titleText: LabelString.lblInstallationCity,
              isRequired: true,
            ),
            CustomTextField(
              keyboardType: TextInputType.name,
              readOnly: false,
              controller: installationCountryController,
              obscureText: false,
              hint: LabelString.lblInstallationCountry,
              titleText: LabelString.lblInstallationCountry,
              isRequired: true,
            ),
            CustomTextField(
              keyboardType: TextInputType.name,
              readOnly: false,
              controller: installationPostalController,
              obscureText: false,
              hint: LabelString.lblInstallationPostalCode,
              titleText: LabelString.lblInstallationPostalCode,
              isRequired: true,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15.sp),
              child: BottomButton(pageController, "Previous"),
            )
          ],
        ),
      ),
    );
  }

  //Autocomplete textField for fill address fields
  Widget autoComplete(String autoCompleteType) {
    return Autocomplete(
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
                  borderSide:
                      BorderSide(width: 2, color: AppColors.primaryColor)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide:
                      BorderSide(width: 2, color: AppColors.primaryColor)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide:
                      BorderSide(width: 2, color: AppColors.primaryColor)),
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.only(left: 12.sp),
              hintText: LabelString.lblTypeToSearch,
              hintStyle: CustomTextStyle.labelFontHintText,
              counterText: ""),
          controller: textEditingController,
          focusNode: focusNode,
          onEditingComplete: () => textEditingController.clear(),
          onSubmitted: (String value) {},
        );
      },
      optionsBuilder: (TextEditingValue textEditingValue) async {
        if (textEditingValue.text.length <= 3) {
          return const Iterable<String>.empty();
        } else {
          //API call for get ID
          var url =
              "https://api.getAddress.io/autocomplete/${textEditingValue.text.toString()}?api-key=S9VYw_n6IE6VlQkZktafRA37641";

          final response = await http.get(Uri.parse(url),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8'
              });
          final responseJson = json.decode(response.body);
          addressList = responseJson["suggestions"];
          List<String> matchesAddress = <String>[];
          matchesAddress
              .addAll(addressList.map((e) => e["address"].toString()));
          return matchesAddress;
        }
      },
      onSelected: (selection) async {
        //For get address ID
        for (int i = 0; i < addressList.length; i++) {
          if (addressList[i]["address"] == selection) {
            String addressId = addressList[i]["id"].toString();

            //Call API for get address detail
            var url =
                "https://api.getAddress.io/get/$addressId?api-key=S9VYw_n6IE6VlQkZktafRA37641";

            final response = await http.get(Uri.parse(url));
            final responseJson = json.decode(response.body);

            //set address detail in field
            if (response.statusCode == 200) {
              if (autoCompleteType == "invoice") {
                invoiceAddressController.text =
                    "${responseJson["line_1"]}  ${responseJson["line_2"]}";
                invoiceCityController.text = "${responseJson["town_or_city"]}";
                invoiceCountryController.text = "${responseJson["county"]}";
                invoicePostalController.text = "${responseJson["postcode"]}";
              } else {
                installationAddressController.text =
                    "${responseJson["line_1"]}  ${responseJson["line_2"]}";
                installationCityController.text =
                    "${responseJson["town_or_city"]}";
                installationCountryController.text =
                    "${responseJson["county"]}";
                installationPostalController.text =
                    "${responseJson["postcode"]}";
              }
            } else {
              Helpers.showSnackBar(context, responseJson["Message"].toString());
            }
          }
        }
      },
    );
  }

  //Method for copy - paste address fields
  void copyAddressFields() {
    Clipboard.setData(ClipboardData(text: invoiceAddressController.text))
        .then((value) => Clipboard.getData(Clipboard.kTextPlain).then(
              (value) {
                installationAddressController.text =
                    invoiceAddressController.text;
              },
            ));

    Clipboard.setData(ClipboardData(text: invoiceCityController.text)).then(
      (value) => Clipboard.getData(Clipboard.kTextPlain).then(
        (value) {
          installationCityController.text = invoiceCityController.text;
        },
      ),
    );

    Clipboard.setData(ClipboardData(text: invoiceCountryController.text)).then(
      (value) => Clipboard.getData(Clipboard.kTextPlain).then(
        (value) {
          installationCountryController.text = invoiceCountryController.text;
        },
      ),
    );

    Clipboard.setData(ClipboardData(text: invoicePostalController.text)).then(
      (value) => Clipboard.getData(Clipboard.kTextPlain).then(
        (value) {
          installationPostalController.text = invoicePostalController.text;
        },
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

//Calling API for fetch detail of single contact
Future<dynamic> getQuoteFields() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();

  Map<String, dynamic> queryParameters = {
    'operation': "describe",
    'sessionName':
        preferences.getString(PreferenceString.sessionName).toString(),
    'elementType': "Quotes",
    'appversion': Constants.of().appversion
  };
  final response = await HttpActions()
      .getMethod(ApiEndPoint.getQuoteListApi, queryParams: queryParameters);
  debugPrint("getQuoteFieldsAPI --- $response");
  return response;
}
