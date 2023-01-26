import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import '../../../components/custom_radio_button.dart';
import '../../../components/custom_rounded_container.dart';
import '../../../components/custom_text_styles.dart';
import '../../../components/custom_textfield.dart';
import '../../../components/global_api_call.dart';
import '../../../httpl_actions/handle_api_error.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/helpers.dart';
import '../../../utils/widgets.dart';
import '../item_detail.dart';
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

  String? eAmount = "0.0";
  String? engineerNumbers;
  String? installationTimeDay;
  String? installationTimeHour;

  String? timeType;

  String premisesTypeSelect = "";
  String systemTypeSelect = "";
  String gradeFireSelect = "";
  String signallingTypeSelect = "";

  String quotePaymentSelection = "";
  String termsItemSelection = "";

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
  List<RadioModel> gradeAndFire = <RadioModel>[]; //step 4
  List<RadioModel> signallingType = <RadioModel>[]; //step 4
  List<RadioModel> quotePayment = <RadioModel>[]; //step 5
  List<RadioModel> termsList = <RadioModel>[]; //step 5

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    getFields = getQuoteFields("Quotes");
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
                    child: InkWell(
                      onTap: () => FocusScope.of(context).unfocus(),
                      highlightColor: AppColors.transparent,
                      splashColor: AppColors.transparent,
                      focusColor: AppColors.transparent,
                      child: PageView(
                        scrollDirection: Axis.horizontal,
                        pageSnapping: true,
                        physics: const NeverScrollableScrollPhysics(),
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
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Autocomplete(
              fieldViewBuilder: (context, textEditingController, focusNode,
                  VoidCallback onFieldSubmitted) {
                return TextField(
                  style: TextStyle(color: AppColors.blackColor),
                  textCapitalization: TextCapitalization.none,
                  textInputAction: TextInputAction.next,
                  maxLines: 1,
                  keyboardType: TextInputType.name,
                  cursorColor: AppColors.blackColor,
                  decoration: InputDecoration(
                      suffixIcon:
                          Icon(Icons.search, color: AppColors.blackColor),
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
                if (textEditingValue.text.isEmpty) {
                  return const Iterable<String>.empty();
                } else {
                  List<String> matchesContact = <String>[];

                  matchesContact.addAll(contactData.map((e) {
                    return "${e["firstname"].toString()} ${e["lastname"].toString()}";
                  }));

                  matchesContact = matchesContact
                      .where((element) => element
                          .toLowerCase()
                          .contains(textEditingValue.text.toLowerCase()))
                      .toList();
                  return matchesContact;
                }
              },
              onSelected: (selection) async {
                FocusScope.of(context).unfocus();
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
                    installationCityController.text =
                        contactData[i]["othercity"];
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
                            insetPadding:
                                EdgeInsets.symmetric(horizontal: 12.sp),
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
                    width: 11.w,
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

                        engineerNumbers = stepOneData["quote_no_of_engineer"]
                                [index]["label"]
                            .toString();
                        calculation();
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
                  installationTiming.add(RadioModel(
                      false,
                      stepOneData["quote_req_to_complete_work"][index]
                          ["label"]));
                  return SizedBox(
                    height: 6.h,
                    child: InkWell(
                      splashColor: AppColors.transparent,
                      highlightColor: AppColors.transparent,
                      onTap: () {
                        for (var element in installationTiming) {
                          element.isSelected = false;
                        }

                        Provider.of<WidgetChange>(context, listen: false)
                            .isSelectTime();
                        installationTiming[index].isSelected = true;
                        Provider.of<WidgetChange>(context, listen: false)
                            .isSetTime;

                        if (stepOneData["quote_req_to_complete_work"][index]
                                ["label"]
                            .toString()
                            .endsWith("Hours")) {
                          timeType = stepOneData["quote_req_to_complete_work"]
                                  [index]["label"]
                              .toString();
                          calculation();
                        } else {
                          timeType = stepOneData["quote_req_to_complete_work"]
                                  [index]["label"]
                              .toString();
                          calculation();
                        }
                      },
                      child: RadioItem(installationTiming[index]),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 2.5.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 20,
                  width: 20,

                  child: Checkbox(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0)),
                      activeColor: AppColors.primaryColor,
                      onChanged: (value) =>
                          Provider.of<WidgetChange>(context, listen: false)
                              .isReminder(),
                      value: Provider.of<WidgetChange>(context, listen: true)
                          .isReminderCheck),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.sp),
                  child: Text(LabelString.lblQuoteEmailReminder,
                      style: CustomTextStyle.labelFontText),
                )
              ],
            ),
            SizedBox(height: 1.5.h),
            InkWell(
              onTap: () {},
              child: RichText(
                text: TextSpan(
                    text: "${LabelString.lblEstimationAmount} : ",
                    style: CustomTextStyle.labelText,
                    children: [
                      TextSpan(
                          text: "£$eAmount",
                          style: CustomTextStyle.labelBoldFontTextBlue)
                    ]),
              ),
            ),
            SizedBox(height: query.height * 0.08),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.sp, horizontal: 2.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: query.width * 0.4,
                    height: query.height * 0.06,
                    child: CustomButton(
                        //update button
                        title: ButtonString.btnCancel,
                        onClick: () => Navigator.of(context).pop(),
                        buttonColor: AppColors.redColor),
                  ),
                  SizedBox(
                    width: query.width * 0.4,
                    height: query.height * 0.06,
                    child: CustomButton(
                        //update button
                        title: ButtonString.btnNext,
                        onClick: () {

                          if (eAmount != "0.0") {
                            FocusScope.of(context).unfocus();
                            pageController.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.decelerate);
                          }
                        },
                        buttonColor: AppColors.primaryColor),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  //Estimated Amount calculation method
  void calculation() {
    //Check number of engineers are null or not
    if (engineerNumbers != null && timeType != null) {
      if (timeType!.endsWith("Hours")) {
        var timeCalculate = (int.parse(engineerNumbers!) *
            int.parse(timeType!.substring(0, 1)) *
            35);
        var vatAdd =
            (int.parse(timeCalculate.toString()) * (0.20)) + timeCalculate;
        eAmount = vatAdd.toString().replaceAll(".0", ".00");
      } else {
        var timeCalculate = (int.parse(engineerNumbers!) *
            int.parse(timeType!.substring(0, 1)) *
            280);
        var vatAdd =
            (int.parse(timeCalculate.toString()) * (0.20)) + timeCalculate;
        eAmount = vatAdd.toString().replaceAll(".0", ".00");
      }
    }
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
                          Provider.of<WidgetChange>(context, listen: false)
                              .isSelectPremisesType();
                          premisesType[index].isSelected = true;
                          Provider.of<WidgetChange>(context, listen: false)
                              .isSetPremises;

                          premisesTypeSelect =
                              stepTwoData["premises_type"][index]["label"];

                          if (premisesTypeSelect.isNotEmpty) {
                            pageController.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.decelerate);
                          }
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
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: query.width * 0.4,
                      height: query.height * 0.06,
                      child: BorderButton(
                          btnString: ButtonString.btnPrevious,
                          onClick: () {
                            pageController.previousPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.decelerate);
                          })),
                  SizedBox(
                    width: query.width * 0.4,
                    height: query.height * 0.06,
                    child: CustomButton(
                        //update button
                        title: ButtonString.btnNext,
                        onClick: () {
                          if (premisesTypeSelect.isNotEmpty) {
                            pageController.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.decelerate);
                          }
                        },
                        buttonColor: AppColors.primaryColor),
                  )
                ]),
          )
        ],
      ),
    );
  }

  ///step 3
  SingleChildScrollView buildStepThree(context, Size query, stepThreeData) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
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

                      systemTypeSelect =
                          stepThreeData["system_type"][index]["label"];

                      print(systemTypeSelect);

                      if (systemTypeSelect ==
                              "CCTV System: BS EN 62676-4:2015" ||
                          systemTypeSelect == "Access Control: BS EN 50133" ||
                          systemTypeSelect == "Keyholding Services") {
                        pageController.jumpToPage(4);
                      } else {
                        pageController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.decelerate);
                      }
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
                                    stepThreeData["system_type"][index]
                                        ["label"],
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
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: query.width * 0.4,
                      height: query.height * 0.06,
                      child: BorderButton(
                          btnString: ButtonString.btnPrevious,
                          onClick: () {
                            pageController.previousPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.decelerate);
                          })),
                  SizedBox(
                    width: query.width * 0.4,
                    height: query.height * 0.06,
                    child: CustomButton(
                        //update button
                        title: ButtonString.btnNext,
                        onClick: () {
                          if (signallingTypeSelect.isNotEmpty) {
                            pageController.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.decelerate);
                          }

                          if (systemTypeSelect ==
                                  "CCTV System: BS EN 62676-4:2015" ||
                              systemTypeSelect ==
                                  "Access Control: BS EN 50133" ||
                              systemTypeSelect == "Keyholding Services") {
                            pageController.jumpToPage(4);
                          } else {
                            pageController.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.decelerate);
                          }
                        },
                        buttonColor: AppColors.primaryColor),
                  )
                ]),
          )
        ],
      ),
    );
  }

  ///step 4
  SingleChildScrollView buildStepFour(context, Size query, stepFourData) {
    List dataGrade = stepFourData["grade_number"];
    //systemTypeSelect == "Fire System: BS 5839-1: 2017 + SP203-1"
    //^This condition for showing fire or grade data(When use select FIRE system type)
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          SizedBox(height: 1.h),
          Text(
              systemTypeSelect == "Fire System: BS 5839-1: 2017 + SP203-1"
                  ? LabelString.lblFireSystem
                  : LabelString.lblGradeNumber,
              textAlign: TextAlign.center,
              style: CustomTextStyle.labelBoldFontTextSmall),
          SizedBox(height: 2.h),
          Wrap(
            spacing: 10.sp,
            direction: Axis.horizontal,
            alignment: WrapAlignment.start,
            runSpacing: 10.sp,
            children: List.generate(
              systemTypeSelect == "Fire System: BS 5839-1: 2017 + SP203-1"
                  ? dataGrade.getRange(2, 7).toList().length
                  : 2,
              (index) {
                gradeAndFire.add(RadioModel(
                    false,
                    systemTypeSelect == "Fire System: BS 5839-1: 2017 + SP203-1"
                        ? dataGrade.getRange(2, 7).toList()[index]["label"]
                        : dataGrade[index]["label"]));
                return Container(
                  height: 15.h,
                  width: 42.w,
                  decoration: BoxDecoration(
                      color: gradeAndFire[index].isSelected
                          ? AppColors.primaryColorLawOpacity
                          : AppColors.whiteColor,
                      border: Border.all(
                          color: gradeAndFire[index].isSelected
                              ? AppColors.primaryColor
                              : AppColors.borderColor,
                          width: 1),
                      borderRadius: BorderRadius.circular(10.0)),
                  child: InkWell(
                    splashColor: AppColors.transparent,
                    highlightColor: AppColors.transparent,
                    onTap: () {
                      for (var element in gradeAndFire) {
                        element.isSelected = false;
                      }
                      Provider.of<WidgetChange>(context, listen: false)
                          .isSelectGrade();
                      gradeAndFire[index].isSelected = true;
                      Provider.of<WidgetChange>(context, listen: false)
                          .isSetGrade;

                      gradeFireSelect = dataGrade[index]["label"];

                      if (signallingTypeSelect.isNotEmpty) {
                        pageController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.decelerate);
                      }
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              //Condition for skip grade and signalling type
                              SvgExtension(
                                  itemName: systemTypeSelect ==
                                          "Fire System: BS 5839-1: 2017 + SP203-1"
                                      ? dataGrade.getRange(2, 7).toList()[index]
                                          ["label"]
                                      : dataGrade[index]["label"],
                                  iconColor: gradeAndFire[index].isSelected
                                      ? AppColors.primaryColor
                                      : AppColors.blackColor),
                              SizedBox(height: 1.h),
                              Text(
                                  systemTypeSelect ==
                                          "Fire System: BS 5839-1: 2017 + SP203-1"
                                      ? dataGrade.getRange(2, 7).toList()[index]
                                          ["label"]
                                      : dataGrade[index]["label"],
                                  style: gradeAndFire[index].isSelected
                                      ? CustomTextStyle.commonTextBlue
                                      : CustomTextStyle.commonText)
                            ]),
                        Visibility(
                          visible:
                              gradeAndFire[index].isSelected ? true : false,
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

                      signallingTypeSelect =
                          stepFourData["signalling_type"][index]["label"];

                      if (gradeFireSelect.isNotEmpty) {
                        pageController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.decelerate);
                      }
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgExtension(
                                  itemName: stepFourData["signalling_type"]
                                      [index]["label"],
                                  iconColor: signallingType[index].isSelected
                                      ? AppColors.primaryColor
                                      : AppColors.blackColor),
                              SizedBox(height: 1.h),
                              Text(
                                  stepFourData["signalling_type"][index]
                                      ["label"],
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
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: query.width * 0.4,
                      height: query.height * 0.06,
                      child: BorderButton(
                          btnString: ButtonString.btnPrevious,
                          onClick: () {
                            pageController.previousPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.decelerate);
                          })),
                  SizedBox(
                    width: query.width * 0.4,
                    height: query.height * 0.06,
                    child: CustomButton(
                        //update button
                        title: ButtonString.btnNext,
                        onClick: () {
                          if (gradeFireSelect.isNotEmpty &&
                              signallingTypeSelect.isNotEmpty) {
                            pageController.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.decelerate);
                          }
                        },
                        buttonColor: AppColors.primaryColor),
                  )
                ]),
          )
        ],
      ),
    );
  }

  ///step 5
  SingleChildScrollView buildStepFive(
      BuildContext context, Size query, stepFiveData) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
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

                      quotePaymentSelection =
                          stepFiveData["quotes_payment"][index]["label"];

                      if (termsItemSelection.isNotEmpty) {
                        pageController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.decelerate);
                      }
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgExtension(
                                  itemName: stepFiveData["quotes_payment"]
                                      [index]["label"],
                                  iconColor: quotePayment[index].isSelected
                                      ? AppColors.primaryColor
                                      : AppColors.blackColor),
                              SizedBox(height: 1.h),
                              Text(
                                  stepFiveData["quotes_payment"][index]
                                      ["label"],
                                  style: quotePayment[index].isSelected
                                      ? CustomTextStyle.commonTextBlue
                                      : CustomTextStyle.commonText)
                            ]),
                        Visibility(
                          visible:
                              quotePayment[index].isSelected ? true : false,
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
                      termsItemSelection =
                          stepFiveData["quotes_terms"][index]["label"];
                      if (quotePaymentSelection.isNotEmpty) {
                        pageController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.decelerate);
                      }
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
                                    stepFiveData["quotes_terms"][index]
                                        ["label"],
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: query.width * 0.4,
                    height: query.height * 0.06,
                    child: BorderButton(
                        btnString: ButtonString.btnPrevious,
                        onClick: () {
                          if (systemTypeSelect ==
                                  "CCTV System: BS EN 62676-4:2015" ||
                              systemTypeSelect ==
                                  "Access Control: BS EN 50133" ||
                              systemTypeSelect == "Keyholding Services") {
                            pageController.jumpToPage(2);
                          } else {
                            pageController.previousPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.decelerate);
                          }
                        })),
                SizedBox(
                  width: query.width * 0.4,
                  height: query.height * 0.06,
                  child: CustomButton(
                      //update button
                      title: ButtonString.btnNext,
                      onClick: () {
                        if (quotePaymentSelection.isNotEmpty &&
                            termsItemSelection.isNotEmpty) {
                          pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.decelerate);
                        }
                      },
                      buttonColor: AppColors.primaryColor),
                )
              ],
            ),
          )
        ],
      ),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: query.width * 0.4,
                      height: query.height * 0.06,
                      child: BorderButton(
                          btnString: ButtonString.btnPrevious,
                          onClick: () {
                            pageController.previousPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.decelerate);
                          })),
                  SizedBox(
                      width: query.width * 0.4,
                      height: query.height * 0.06,
                      child: CustomButton(
                          //update button
                          title: ButtonString.btnNext,
                          onClick: () =>
                              callNextScreen(context, const BuildItemDetail()),
                          buttonColor: AppColors.primaryColor))
                ],
              ),
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
              /*border: OutlineInputBorder(
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
                      BorderSide(width: 2, color: AppColors.primaryColor)),*/
              border: UnderlineInputBorder(
                  borderSide:
                      BorderSide(width: 1, color: AppColors.primaryColor)),
              focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(width: 1, color: AppColors.primaryColor)),
              enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(width: 1, color: AppColors.primaryColor)),
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.only(left: 12.sp),
              hintText: LabelString.lblTypeToSearch,
              hintStyle: CustomTextStyle.labelFontHintText,
              counterText: "",
              labelStyle: CustomTextStyle.labelFontHintText,
              labelText: LabelString.lblAddressSearch),
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
                if (invoiceAddressController.text.isNotEmpty) {
                  installationAddressController.text =
                      invoiceAddressController.text;
                }
              },
            ));

    Clipboard.setData(ClipboardData(text: invoiceCityController.text)).then(
      (value) => Clipboard.getData(Clipboard.kTextPlain).then(
        (value) {
          if (invoiceCityController.text.isNotEmpty) {
            installationCityController.text = invoiceCityController.text;
          }
        },
      ),
    );

    Clipboard.setData(ClipboardData(text: invoiceCountryController.text)).then(
      (value) => Clipboard.getData(Clipboard.kTextPlain).then(
        (value) {
          if (invoiceCountryController.text.isNotEmpty) {
            installationCountryController.text = invoiceCountryController.text;
          }
        },
      ),
    );

    Clipboard.setData(ClipboardData(text: invoicePostalController.text)).then(
      (value) => Clipboard.getData(Clipboard.kTextPlain).then(
        (value) {
          if (invoicePostalController.text.isNotEmpty) {
            installationPostalController.text = invoicePostalController.text;
          }
        },
      ),
    );
  }
}
