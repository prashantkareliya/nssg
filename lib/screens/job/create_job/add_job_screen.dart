import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nssg/screens/qoute/get_quote/quote_model_dir/get_quote_response_model.dart';
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
import '../../../constants/constants.dart';
import '../../../constants/strings.dart';
import '../../../httpl_actions/app_http.dart';
import '../../../httpl_actions/handle_api_error.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/widgetChange.dart';
import '../../../utils/widgets.dart';


class AddJobPage extends StatefulWidget {
  Result quoteItem;
  AddJobPage(this.quoteItem);

  @override
  State<AddJobPage> createState() => _AddJobPageState();
}

class _AddJobPageState extends State<AddJobPage> {
  Future<dynamic>? getJobFields;


  PageController pageController = PageController();

  StreamController<int> streamController = StreamController<int>.broadcast();

  TextEditingController officeNoteController = TextEditingController();
  TextEditingController officeNote2Controller = TextEditingController();
  TextEditingController engineerNoteController = TextEditingController();
  TextEditingController engineerInstructionController = TextEditingController();
  TextEditingController specialInstructionController = TextEditingController();


  bool isLoading = false;


  List<RadioModel> priorityLevel = <RadioModel>[];
  List<RadioModel> worksSchedule = <RadioModel>[];
  List<RadioModel> paymentMethod = <RadioModel>[];
  List<RadioModel> paymentInstructions = <RadioModel>[];
  List<RadioModel> instructionsToProceed = <RadioModel>[];
  List<RadioModel> installationTimeRequired = <RadioModel>[];
  String page = "0";


  @override
  void initState() {
    super.initState();
    getContractNumber();
  }

  //Calling API for fetch detail of single contact
  Future<dynamic> getContractNumber() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    Map<String, dynamic> queryParameters = {
      'operation': "retrive_contract_number_by_id",
      'sessionName': preferences.getString(PreferenceString.sessionName),
      'id': widget.quoteItem.id,
      'quotes_contract_id': "",
      'quotes_system_type': widget.quoteItem.systemType,
      'quotes_ship_street': widget.quoteItem.shipStreet,
      'quotes_ship_city': widget.quoteItem.shipCity,
      'quotes_ship_country': widget.quoteItem.shipCountry,
      'quotes_ship_code': widget.quoteItem.shipCode,
      'quotes_quote_type': "Installation",
      'contact_id': widget.quoteItem.contactId,
    };
    final response = await HttpActions() .getMethod(ApiEndPoint.mainApiEnd, queryParams: queryParameters);

    debugPrint("getContractNumberAPI --- $response");
    return response;
  }

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    getJobFields = getQuoteFields("SalesOrder", context);

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 1,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leadingWidth: 12.w,
        leading: InkWell(
          highlightColor: AppColors.transparent,
          splashColor: AppColors.transparent,
          onTap: () {
            if(page == "0"){
              Navigator.pop(context);
            } else {
              pageController.previousPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.decelerate);
            }
          },
          child: Icon(Icons.arrow_back_ios_outlined,
              color: AppColors.blackColor, size: 14.sp),
        ),
        title: Text(LabelString.lblCreateJob,
            style: CustomTextStyle.labelBoldFontText),
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
                    //step design
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        snapshot.data! == 0
                            ? RoundedContainer(
                                containerText: (snapshot.data! + 1).toString(),
                                stepText: (snapshot.data! + 1).toString(),
                                isEnable: true,
                                isDone: false)
                            : RoundedContainer(
                                containerText: (snapshot.data! + 1).toString(),
                                stepText: (snapshot.data!).toString(),
                                isEnable: false,
                                isDone: true),
                        snapshot.data! == 1
                            ? RoundedContainer(
                                containerText: (snapshot.data! + 1).toString(),
                                stepText: (snapshot.data! + 1).toString(),
                                isEnable: true,
                                isDone: false)
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
                      totalSteps: 2,
                      size: 2.sp,
                      currentStep: snapshot.data!,
                      selectedColor: AppColors.primaryColor,
                      unselectedColor: AppColors.transparent,
                      customColor: (index) {
                        if (index == snapshot.data) {
                          return AppColors.primaryColor;
                        } else {
                          return index == 5
                              ? AppColors.redColor
                              : Colors.transparent;
                        }
                      },
                    ),

                    Padding(
                      padding: EdgeInsets.only(left: 10.sp, right: 10.sp, top : 8.sp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(snapshot.data == 1 ? LabelString.lblJobInstructions
                              :LabelString.lblQuestionsForProjectManagers,
                              style: CustomTextStyle.labelBoldFontTextSmall),
                          Row(
                            children: [
                              Text(LabelString.lblStep, style: CustomTextStyle.commonText),
                              Text(" ${snapshot.data! + 1}/2", style: CustomTextStyle.commonTextBlue),
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
          //bloc for update and create contact
          FutureBuilder<dynamic>(
              future: getJobFields,
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  var jobFieldsData = snapshot.data["result"];
                  return Expanded(
                    child: PageView(
                      pageSnapping: true,
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      controller: pageController,
                      onPageChanged: (number) {
                        streamController.add(number);
                        Provider.of<WidgetChange>(context, listen: false).pageNumber(number.toString());
                        page = Provider.of<WidgetChange>(context, listen: false).pageNo;

                      },
                      children: [buildStepOne(query, jobFieldsData), buildStepTwo(query, jobFieldsData)],
                    ),
                  );
                }else if (snapshot.hasError) {
                  final message = HandleAPI.handleAPIError(snapshot.error);
                  return Text(message);
                }
                return SizedBox(height: 70.h, child: loadingView());
              }
          )
        ],
      ),
    );
  }

  //stepOne design
  Padding buildStepOne(Size query, jobFieldsData) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.sp),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 1.h),
            Text(LabelString.lblPriorityLevel,
                style: CustomTextStyle.labelText),
            SizedBox(height: 1.0.h),
            Wrap(
              spacing: 8.sp,
              direction: Axis.horizontal,
              runSpacing: 8.sp,
              children: List.generate(
                jobFieldsData["priority_level"].length,
                    (index) {
                  String priorityLevelLabel = jobFieldsData["priority_level"][index]["label"].toString();
                  priorityLevel.add(RadioModel(false, jobFieldsData["priority_level"][index]["label"]));

                  return InkWell(
                    splashColor: AppColors.transparent,
                    highlightColor: AppColors.transparent,
                    onTap: () {
                      for (var element in priorityLevel) {
                        element.isSelected = false;
                      }
                      //  Provider.of<WidgetChange>(context, listen: false).isSelectSystemType();
                      priorityLevel[index].isSelected = true;
                      setState(() {});
                    },
                    child: Container(width: query.width * 0.29,
                      decoration: BoxDecoration(
                          color: priorityLevel[index].isSelected
                              ? AppColors.primaryColorLawOpacity
                              : AppColors.whiteColor,
                          border: Border.all(
                              color: priorityLevel[index].isSelected
                                  ? AppColors.primaryColor
                                  : AppColors.borderColor,
                              width: 1),
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.sp),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if(jobFieldsData["priority_level"][index]["label"].toString() == "High")
                            Container(
                              height: 2.h, width: 4.w,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFC1C1),
                                borderRadius: BorderRadius.circular(50.0),
                                border: Border.all(color: const Color(0xFFFF5757))
                              ),
                            ) else
                              if(jobFieldsData["priority_level"][index]["label"].toString() == "Medium")
                              Container(
                                  height: 2.h, width: 4.w,
                                  decoration: BoxDecoration(
                                  color: const Color(0xFFFEF0A6),
                                  borderRadius: BorderRadius.circular(50.0),
                                  border: Border.all(color: const Color(0xFFFFC93D))
                                  ),
                                ) else
                                  Container(
                                    height: 2.h, width: 4.w,
                                    decoration: BoxDecoration(
                                        color: const Color(0xFFCBDAEA),
                                        borderRadius: BorderRadius.circular(50.0),
                                        border: Border.all(color: const Color(0xFF58A8FE))
                                ),
                              ),
                            SizedBox(width: 2.w),
                            Text(priorityLevelLabel,
                                textAlign: TextAlign.center,
                                style: priorityLevel[index].isSelected
                                    ? CustomTextStyle.commonTextBlue
                                    : CustomTextStyle.labelText),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 2.5.h),
            Text(LabelString.lblWorkSchedule,
                style: CustomTextStyle.labelText),
            SizedBox(height: 1.0.h),
            Wrap(
              spacing: 8.sp,
              direction: Axis.horizontal,
              alignment: WrapAlignment.start,
              runSpacing: 8.sp,
              children: List.generate(
                jobFieldsData["works_schedule"].length,
                    (index) {
                  String worksScheduleLabel = jobFieldsData["works_schedule"][index]["label"].toString();
                  worksSchedule.add(RadioModel(false, jobFieldsData["works_schedule"][index]["label"]));

                  return InkWell(
                    splashColor: AppColors.transparent,
                    highlightColor: AppColors.transparent,
                    onTap: () {
                      for (var element in worksSchedule) {
                        element.isSelected = false;
                      }
                      //  Provider.of<WidgetChange>(context, listen: false).isSelectSystemType();
                      worksSchedule[index].isSelected = true;
                      setState(() {});
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: worksSchedule[index].isSelected
                              ? AppColors.primaryColorLawOpacity
                              : AppColors.whiteColor,
                          border: Border.all(
                              color: worksSchedule[index].isSelected
                                  ? AppColors.primaryColor
                                  : AppColors.borderColor,
                              width: 1),
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 10.sp),
                        child:  Text(worksScheduleLabel,
                            textAlign: TextAlign.center,
                            style: worksSchedule[index].isSelected
                                ? CustomTextStyle.commonTextBlue
                                : CustomTextStyle.labelText),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 2.5.h),
            Text(LabelString.lblPaymentMethod,
                style: CustomTextStyle.labelText),
            SizedBox(height: 1.0.h),
            Wrap(
              spacing: 8.sp,
              direction: Axis.horizontal,
              alignment: WrapAlignment.start,
              runSpacing: 8.sp,
              children: List.generate(
                jobFieldsData["payment_method"].length,
                    (index) {
                  String paymentMethodLabel = jobFieldsData["payment_method"][index]["label"].toString();
                  paymentMethod.add(RadioModel(false, jobFieldsData["payment_method"][index]["label"]));
                  return InkWell(
                    splashColor: AppColors.transparent,
                    highlightColor: AppColors.transparent,
                    onTap: () {
                      for (var element in paymentMethod) {
                        element.isSelected = false;
                      }
                      //  Provider.of<WidgetChange>(context, listen: false).isSelectSystemType();
                      paymentMethod[index].isSelected = true;
                      setState(() {});
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: paymentMethod[index].isSelected
                              ? AppColors.primaryColorLawOpacity
                              : AppColors.whiteColor,
                          border: Border.all(
                              color: paymentMethod[index].isSelected
                                  ? AppColors.primaryColor
                                  : AppColors.borderColor,
                              width: 1),
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 10.sp),
                        child:  Text(paymentMethodLabel,
                            textAlign: TextAlign.center,
                            style: paymentMethod[index].isSelected
                                ? CustomTextStyle.commonTextBlue
                                : CustomTextStyle.labelText),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 2.5.h),
            Text(LabelString.lblPaymentInstructions,
                style: CustomTextStyle.labelText),
            SizedBox(height: 1.0.h),
            Wrap(
              spacing: 8.sp,
              direction: Axis.horizontal,
              alignment: WrapAlignment.start,
              runSpacing: 8.sp,
              children: List.generate(
                jobFieldsData["payment_instructions"].length,
                    (index) {
                  String paymentInstructionsLabel = jobFieldsData["payment_instructions"][index]["label"].toString();
                  paymentInstructions.add(RadioModel(false, jobFieldsData["payment_instructions"][index]["label"]));
                  return InkWell(
                    splashColor: AppColors.transparent,
                    highlightColor: AppColors.transparent,
                    onTap: () {
                      for (var element in paymentInstructions) {
                        element.isSelected = false;
                      }
                      paymentInstructions[index].isSelected = true;
                      setState(() {});
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: paymentInstructions[index].isSelected
                              ? AppColors.primaryColorLawOpacity
                              : AppColors.whiteColor,
                          border: Border.all(
                              color: paymentInstructions[index].isSelected
                                  ? AppColors.primaryColor
                                  : AppColors.borderColor,
                              width: 1),
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 5.sp),
                        child:  Text(paymentInstructionsLabel,
                            textAlign: TextAlign.center,
                            style: paymentInstructions[index].isSelected
                                ? CustomTextStyle.commonTextBlue
                                : CustomTextStyle.labelText),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 2.h),
            CustomTextField(
                keyboardType: TextInputType.text,
                readOnly: false,
                controller: officeNoteController,
                obscureText: false,
                hint: LabelString.lblOfficeNote,
                titleText: LabelString.lblOfficeNote,
                maxLines: 3,
                minLines: 1,
                textInputAction: TextInputAction.next,
                isRequired: false),
            CustomTextField(
                keyboardType: TextInputType.text,
                readOnly: false,
                controller: engineerNoteController,
                obscureText: false,
                hint: LabelString.lblEngineerNote,
                titleText: LabelString.lblEngineerNote,
                maxLines: 3,
                minLines: 1,
                textInputAction: TextInputAction.next,
                isRequired: false),
            SizedBox(height: 2.0.h),
            Text(LabelString.lblInstructionsToProceed,
                style: CustomTextStyle.labelText),
            SizedBox(height: 1.0.h),
            Wrap(
              spacing: 8.sp,
              direction: Axis.horizontal,
              runSpacing: 8.sp,
              children: List.generate(
                jobFieldsData["instructions_to_proceed"].length,
                    (index) {
                  String instructionsToProceedLabel = jobFieldsData["instructions_to_proceed"][index]["label"].toString();
                  instructionsToProceed.add(RadioModel(false, jobFieldsData["instructions_to_proceed"][index]["label"]));
                  return InkWell(
                    splashColor: AppColors.transparent,
                    highlightColor: AppColors.transparent,
                    onTap: () {
                      for (var element in instructionsToProceed) {
                        element.isSelected = false;
                      }
                      instructionsToProceed[index].isSelected = true;
                      setState(() {});
                    },
                    child: Container(
                      width: query.width,
                      decoration: BoxDecoration(
                          color: instructionsToProceed[index].isSelected
                              ? AppColors.primaryColorLawOpacity
                              : AppColors.whiteColor,
                          border: Border.all(
                              color: instructionsToProceed[index].isSelected
                                  ? AppColors.primaryColor
                                  : AppColors.borderColor,
                              width: 1),
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 5.sp),
                        child:  Text(instructionsToProceedLabel,
                            textAlign: TextAlign.center,
                            style: instructionsToProceed[index].isSelected
                                ? CustomTextStyle.commonTextBlue
                                : CustomTextStyle.labelText),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(vertical: 15.sp, horizontal: 2.0.sp),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  //cancel button
                  SizedBox(
                    width: query.width * 0.4,
                    height: query.height * 0.06,
                    child: CustomButton(
                        buttonColor: AppColors.redColor,
                        onClick: () => Navigator.pop(context),
                        title: ButtonString.btnCancel),
                  ),
                  //next button
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
            )
          ],
        ),
      ),
    );
  }

  //stepTwo design
  buildStepTwo(Size query, jobFieldsData) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.sp),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /*SizedBox(height: 2.0.h),
            Text(LabelString.lblInstallationTimeRequired,
                style: CustomTextStyle.labelText),
            SizedBox(height: 1.0.h),
            Wrap(
              spacing: 4.sp,
              direction: Axis.horizontal,
              alignment: WrapAlignment.start,
              runSpacing: 8.sp,
              children: List.generate(
                jobFieldsData["installation_time_required"].length,
                    (index) {
                  String installationTimeRequiredLabel = jobFieldsData["installation_time_required"][index]["label"].toString();
                installationTimeRequired.add(RadioModel(false, jobFieldsData["installation_time_required"][index]["label"]));
                  return InkWell(
                    splashColor: AppColors.transparent,
                    highlightColor: AppColors.transparent,
                    onTap: () {
                      for (var element in installationTimeRequired) {
                        element.isSelected = false;
                      }
                      installationTimeRequired[index].isSelected = true;
                      setState(() {});
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: installationTimeRequired[index].isSelected
                              ? AppColors.primaryColorLawOpacity
                              : AppColors.whiteColor,
                          border: Border.all(
                              color: installationTimeRequired[index].isSelected
                                  ? AppColors.primaryColor
                                  : AppColors.borderColor,
                              width: 1),
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 10.sp),
                        child:  Text(installationTimeRequiredLabel,
                            textAlign: TextAlign.center,
                            style: installationTimeRequired[index].isSelected
                                ? CustomTextStyle.commonTextBlue
                                : CustomTextStyle.labelText),
                      ),
                    ),
                  );
                },
              ),
            ),*/
            CustomTextField(
              keyboardType: TextInputType.text,
              readOnly: false,
              controller: officeNote2Controller,
              obscureText: false,
              hint: LabelString.lblOfficeNote,
              titleText: LabelString.lblOfficeNote,
              textInputAction: TextInputAction.next,
              maxLines: 3,

              minLines: 1,
              isRequired: true,
            ),
            CustomTextField(
              keyboardType: TextInputType.text,
              readOnly: false,
              controller: engineerInstructionController,
              obscureText: false,
              hint: LabelString.lblEngineerInstruction,
              titleText: LabelString.lblEngineerInstruction,
              textInputAction: TextInputAction.next,
              maxLines: 3,
              minLines: 1,
              isRequired: true,
            ),
            CustomTextField(
              keyboardType: TextInputType.text,
              readOnly: false,
              controller: specialInstructionController,
              obscureText: false,
              hint: LabelString.lblSpecialInstruction,
              titleText: LabelString.lblSpecialInstruction,
              textInputAction: TextInputAction.next,
              maxLines: 3,
              minLines: 1,
              isRequired: true,
            ),
            buildButtons(query),
          ],
        ),
      ),
    );
  }

  //previous and submit button
  Padding buildButtons(Size query) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.sp, horizontal: 2.0.sp),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          //previous button
          SizedBox(
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
                    buttonColor: AppColors.primaryColor,
                    onClick: () { },
                    title: ButtonString.btnSubmit)
          )
        ],
      ),
    );
  }


}
