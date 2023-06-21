import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nssg/screens/job/create_job/models/add_job_request_model.dart';
import 'package:nssg/screens/job/job_datasource.dart';
import 'package:nssg/screens/job/job_repository.dart';
import 'package:nssg/screens/qoute/get_quote/quote_model_dir/get_quote_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:sizer/sizer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../components/custom_button.dart';
import '../../../components/custom_radio_button.dart';
import '../../../components/custom_text_styles.dart';
import '../../../components/custom_textfield.dart';
import '../../../components/global_api_call.dart';
import '../../../constants/constants.dart';
import '../../../constants/strings.dart';
import '../../../httpl_actions/app_http.dart';
import '../../../httpl_actions/handle_api_error.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/helpers.dart';
import '../../../utils/widgets.dart';
import '../../qoute/add_quote/quote_estimation_dialog.dart';
import 'create_job_bloc_dir/create_job_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class AddJobPage extends StatefulWidget {
  Result? quoteItem;
  AddJobPage({this.quoteItem});

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
  //TextEditingController engineerInstructionController = TextEditingController();
  TextEditingController specialInstructionController = TextEditingController();
  TextEditingController specialInstructionController1 = TextEditingController();
  TextEditingController contractNumberController = TextEditingController();

  bool isLoading = false;

  List<RadioModel> priorityLevel = <RadioModel>[];
  List<RadioModel> worksSchedule = <RadioModel>[];
  List<RadioModel> paymentMethod = <RadioModel>[];
  List<RadioModel> paymentInstructions = <RadioModel>[];
  List<RadioModel> instructionsToProceed = <RadioModel>[];
  List<RadioModel> installationTimeRequired = <RadioModel>[];
  String page = "0";

  String priorityLevelSelect = "Medium";
  String workScheduleSelect = "";
  String paymentMethodSelect = "";
  String paymentInstructionSelect = "";
  String instructionToProceedSelect = "";
  String contractNumberPass = "";

  String numberOfEngineer = "";
  String installationTime = "";

  Future<dynamic>? getDetail;

  CreateJobBloc createJobBloc =
      CreateJobBloc(JobRepository(jobDataSource: JobDataSource()));
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
      'id': widget.quoteItem?.id,
      'quotes_contract_id': "",
      'quotes_system_type': widget.quoteItem?.systemType,
      'quotes_ship_street': widget.quoteItem?.shipStreet,
      'quotes_ship_city': widget.quoteItem?.shipCity,
      'quotes_ship_country': widget.quoteItem?.shipCountry,
      'quotes_ship_code': widget.quoteItem?.shipCode,
      'quotes_quote_type': "Installation",
      'contact_id': widget.quoteItem?.contactId
    };

    final response = await HttpActions()
        .getMethod(ApiEndPoint.mainApiEnd, queryParams: queryParameters);

    setState(() {
      contractNumberPass = response["result"].toString();
      contractNumberController.text = contractNumberPass;
    });
    debugPrint("getContractNumberAPI --- $response");
    return response;
  }

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    getJobFields = getQuoteFields("SalesOrder", context);
    getDetail = getContactDetail(widget.quoteItem?.id, context);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 1,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leadingWidth: 55.w,
        leading: InkWell(
          highlightColor: AppColors.transparent,
          splashColor: AppColors.transparent,
          onTap: () {
            Navigator.pop(context, "no");
          },
          child: Icon(Icons.arrow_back_ios_outlined,
              color: AppColors.blackColor, size: 16.sp),
        ),
        title: Text(LabelString.lblCreateJob,
            style: GoogleFonts.roboto(
                textStyle: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black))),
      ),
      body: BlocListener<CreateJobBloc, CreateJobState>(
        bloc: createJobBloc,
        listener: (context, state) {
          if (state is FailCreateJob) {
            Helpers.showSnackBar(context, ErrorString.somethingWentWrong);
          }
          if (state is LoadedCreateJob) {
            Helpers.showSnackBar(context, "Job Created Successfully");
            Navigator.pop(context);
          }
          if (state is LoadingCreateJob) {
            //Navigator.pop(context, "yes");
          }
        },
        child: BlocBuilder<CreateJobBloc, CreateJobState>(
          bloc: createJobBloc,
          builder: (context, state) {
            if (state is LoadingCreateJob) {
              isLoading = state.isBusy;
              FocusScope.of(context).unfocus();
            }
            if (state is LoadedCreateJob) {
              isLoading = false;
            }
            if (state is FailCreateJob) {
              isLoading = false;
            }
            return FutureBuilder<dynamic>(
                future: getJobFields,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var jobFieldsData = snapshot.data["result"];
                    return FutureBuilder<dynamic>(
                        future: getDetail,
                        builder: (context, snapshot1) {
                          if (snapshot1.hasData) {
                            installationTime = snapshot1.data["result"]
                                    ["quote_req_to_complete_work"] ??
                                "";
                            numberOfEngineer = snapshot1.data["result"]
                                    ["quote_no_of_engineer"] ??
                                "";

                            return snapshot1.data["result"]
                                        ["quote_quote_type"] ==
                                    "Installation"
                                ? buildStepOne(query, jobFieldsData,
                                    snapshot1.data["result"])
                                : buildStepTwo(query, jobFieldsData,
                                    snapshot1.data["result"]);
                          } else if (snapshot1.hasError) {
                            final message =
                                HandleAPI.handleAPIError(snapshot.error);
                            return Text(message);
                          }
                          return SizedBox(height: 70.h, child: loadingView());
                        });
                  } else if (snapshot.hasError) {
                    final message = HandleAPI.handleAPIError(snapshot.error);
                    return Text(message);
                  }
                  return SizedBox(height: 70.h, child: loadingView());
                });
          },
        ),
      ),
    );
  }

  //stepOne design
  Widget buildStepOne(Size query, jobFieldsData, dataForCreateJob) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.h),
            Text(LabelString.lblContractNumber,
                style: GoogleFonts.roboto(
                    fontSize: 14.sp, fontWeight: FontWeight.w700)),
            SizedBox(height: 5.h),
            TextFormField(
              controller: contractNumberController,
              decoration: InputDecoration(
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
                  hintText: LabelString.lblContractNumber,
                  hintStyle: CustomTextStyle.labelFontHintText,
                  counterText: "",
                  labelStyle: CustomTextStyle.labelFontHintText),
            ),
            SizedBox(height: 10.h),
            Text(LabelString.lblPriorityLevel,
                style: GoogleFonts.roboto(
                    fontSize: 14.sp, fontWeight: FontWeight.w700)),
            SizedBox(height: 5.h),
            Wrap(
              spacing: 8.sp,
              direction: Axis.horizontal,
              runSpacing: 8.sp,
              children: List.generate(
                jobFieldsData["priority_level"].length,
                (index) {
                  String priorityLevelLabel = jobFieldsData["priority_level"]
                          [index]["label"]
                      .toString();
                  priorityLevel.add(RadioModel(
                      priorityLevelLabel == "Medium" ? true : false,
                      jobFieldsData["priority_level"][index]["label"]));

                  return InkWell(
                    splashColor: AppColors.transparent,
                    highlightColor: AppColors.transparent,
                    onTap: () {
                      for (var element in priorityLevel) {
                        element.isSelected = false;
                      }
                      //  Provider.of<WidgetChange>(context, listen: false).isSelectSystemType();
                      priorityLevel[index].isSelected = true;
                      priorityLevelSelect =
                          jobFieldsData["priority_level"][index]["label"];
                      setState(() {});
                    },
                    child: Container(
                      width: query.width * 0.29,
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
                            if (jobFieldsData["priority_level"][index]["label"]
                                    .toString() ==
                                "High")
                              Container(
                                height: 16.h,
                                width: 17.w,
                                decoration: BoxDecoration(
                                    color: const Color(0xFFFFC1C1),
                                    borderRadius: BorderRadius.circular(50.0),
                                    border: Border.all(
                                        color: const Color(0xFFFF5757))),
                              )
                            else if (jobFieldsData["priority_level"][index]
                                        ["label"]
                                    .toString() ==
                                "Medium")
                              Container(
                                height: 16.h,
                                width: 17.w,
                                decoration: BoxDecoration(
                                    color: const Color(0xFFFEF0A6),
                                    borderRadius: BorderRadius.circular(50.0),
                                    border: Border.all(
                                        color: const Color(0xFFFFC93D))),
                              )
                            else
                              Container(
                                height: 16.h,
                                width: 17.w,
                                decoration: BoxDecoration(
                                    color: const Color(0xFFCBDAEA),
                                    borderRadius: BorderRadius.circular(50.0),
                                    border: Border.all(
                                        color: const Color(0xFF58A8FE))),
                              ),
                            SizedBox(width: 2.w),
                            Text(priorityLevelLabel,
                                textAlign: TextAlign.center,
                                style: priorityLevel[index].isSelected
                                    ? CustomTextStyle.commonTextBlue
                                    : CustomTextStyle.labelText)
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10.h),
            Text(LabelString.lblWorkSchedule,
                style: GoogleFonts.roboto(
                    fontSize: 14.sp, fontWeight: FontWeight.w700)),
            SizedBox(height: 5.h),
            Wrap(
              spacing: 8.sp,
              direction: Axis.horizontal,
              alignment: WrapAlignment.start,
              runSpacing: 8.sp,
              children: List.generate(
                jobFieldsData["works_schedule"].length,
                (index) {
                  String worksScheduleLabel = jobFieldsData["works_schedule"]
                          [index]["label"]
                      .toString();
                  worksSchedule.add(RadioModel(
                      false, jobFieldsData["works_schedule"][index]["label"]));

                  return InkWell(
                    splashColor: AppColors.transparent,
                    highlightColor: AppColors.transparent,
                    onTap: () {
                      for (var element in worksSchedule) {
                        element.isSelected = false;
                      }
                      //  Provider.of<WidgetChange>(context, listen: false).isSelectSystemType();
                      worksSchedule[index].isSelected = true;
                      workScheduleSelect =
                          jobFieldsData["works_schedule"][index]["label"];
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
                        padding: EdgeInsets.symmetric(
                            vertical: 10.sp, horizontal: 10.sp),
                        child: Text(worksScheduleLabel,
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
            SizedBox(height: 10.h),
            Text(LabelString.lblPaymentMethod,
                style: GoogleFonts.roboto(
                    fontSize: 14.sp, fontWeight: FontWeight.w700)),
            SizedBox(height: 5.h),
            Wrap(
              spacing: 8.sp,
              direction: Axis.horizontal,
              alignment: WrapAlignment.start,
              runSpacing: 8.sp,
              children: List.generate(
                jobFieldsData["payment_method"].length,
                (index) {
                  String paymentMethodLabel = jobFieldsData["payment_method"]
                          [index]["label"]
                      .toString();
                  paymentMethod.add(RadioModel(
                      false, jobFieldsData["payment_method"][index]["label"]));
                  return InkWell(
                    splashColor: AppColors.transparent,
                    highlightColor: AppColors.transparent,
                    onTap: () {
                      for (var element in paymentMethod) {
                        element.isSelected = false;
                      }
                      //  Provider.of<WidgetChange>(context, listen: false).isSelectSystemType();
                      paymentMethod[index].isSelected = true;
                      paymentMethodSelect =
                          jobFieldsData["payment_method"][index]["label"];
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
                        padding: EdgeInsets.symmetric(
                            vertical: 10.sp, horizontal: 10.sp),
                        child: Text(paymentMethodLabel,
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
            SizedBox(height: 10.h),
            Text(LabelString.lblPaymentInstructions,
                style: GoogleFonts.roboto(
                    fontSize: 14.sp, fontWeight: FontWeight.w700)),
            SizedBox(height: 5.h),
            Wrap(
              spacing: 8.sp,
              direction: Axis.horizontal,
              alignment: WrapAlignment.start,
              runSpacing: 8.sp,
              children: List.generate(
                jobFieldsData["payment_instructions"].length,
                (index) {
                  String paymentInstructionsLabel =
                      jobFieldsData["payment_instructions"][index]["label"]
                          .toString();
                  paymentInstructions.add(RadioModel(false,
                      jobFieldsData["payment_instructions"][index]["label"]));
                  return InkWell(
                    splashColor: AppColors.transparent,
                    highlightColor: AppColors.transparent,
                    onTap: () {
                      for (var element in paymentInstructions) {
                        element.isSelected = false;
                      }
                      paymentInstructions[index].isSelected = true;
                      paymentInstructionSelect =
                          jobFieldsData["payment_instructions"][index]["label"];
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
                        padding: EdgeInsets.symmetric(
                            vertical: 10.sp, horizontal: 5.sp),
                        child: Text(paymentInstructionsLabel,
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
            SizedBox(height: 10.h),
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
            CustomTextField(
              keyboardType: TextInputType.text,
              readOnly: false,
              controller: specialInstructionController1,
              obscureText: false,
              hint: LabelString.lblSpecialInstruction,
              titleText: LabelString.lblSpecialInstruction,
              textInputAction: TextInputAction.next,
              maxLines: 3,
              minLines: 1,
              isRequired: true,
            ),
            SizedBox(height: 10.h),
            Text(LabelString.lblInstructionsToProceed,
                style: GoogleFonts.roboto(
                    fontSize: 14.sp, fontWeight: FontWeight.w700)),
            SizedBox(height: 5.h),
            Wrap(
              spacing: 8.sp,
              direction: Axis.horizontal,
              runSpacing: 8.sp,
              children: List.generate(
                jobFieldsData["instructions_to_proceed"].length,
                (index) {
                  String instructionsToProceedLabel =
                      jobFieldsData["instructions_to_proceed"][index]["label"]
                          .toString();
                  instructionsToProceed.add(RadioModel(
                      false,
                      jobFieldsData["instructions_to_proceed"][index]
                          ["label"]));
                  return InkWell(
                    splashColor: AppColors.transparent,
                    highlightColor: AppColors.transparent,
                    onTap: () {
                      for (var element in instructionsToProceed) {
                        element.isSelected = false;
                      }
                      instructionsToProceed[index].isSelected = true;
                      instructionToProceedSelect =
                          jobFieldsData["instructions_to_proceed"][index]
                              ["label"];
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
                        padding: EdgeInsets.symmetric(
                            vertical: 10.sp, horizontal: 5.sp),
                        child: Text(instructionsToProceedLabel,
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
                child: SizedBox(
                  width: query.width,
                  height: query.height * 0.06,
                  child: CustomButton(
                    buttonColor: AppColors.primaryColor,
                    onClick: () {
                      if (priorityLevelSelect == "") {
                        Helpers.showSnackBar(
                            context, ErrorString.selectPriorityLevel,
                            isError: true);
                      } else if (workScheduleSelect == "") {
                        Helpers.showSnackBar(
                            context, ErrorString.selectWorkSchedule,
                            isError: true);
                      } else if (paymentMethodSelect == "") {
                        Helpers.showSnackBar(
                            context, ErrorString.selectPaymentMethod,
                            isError: true);
                      } else if (instructionToProceedSelect == "") {
                        Helpers.showSnackBar(
                            context, ErrorString.selectInstructionToProceed,
                            isError: true);
                      } else if (paymentInstructionSelect == "") {
                        Helpers.showSnackBar(
                            context, ErrorString.selectPaymentInstruction,
                            isError: true);
                      } else if (engineerNoteController.text.isEmpty) {
                        Helpers.showSnackBar(
                            context, ErrorString.selectEngineerNote,
                            isError: true);
                      } else {
                        if (installationTime == "" || numberOfEngineer == "") {
                          showDialog(
                              context: context,
                              builder: (context) {
                                ///Make new class for dialog
                                return Dialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    elevation: 0,
                                    insetAnimationCurve: Curves.decelerate,
                                    insetPadding:
                                        EdgeInsets.symmetric(horizontal: 12.sp),
                                    child: QuoteEstimation(
                                        dataQuote: dataForCreateJob, "job"));
                              }).then((value) {
                            print(value);
                            setState(() {
                              installationTime = value["keyTimeType"];
                              numberOfEngineer = value["keyEngineerNumbers"];
                              Navigator.pop(context, "yes");
                              createJob(dataForCreateJob);
                            });
                          });
                        } else {
                          createJob(dataForCreateJob);
                        }
                      }
                    },
                    title: ButtonString.btnSubmit,
                  ),
                ))
          ],
        ),
      ),
    );
  }

  //stepTwo design
  Widget buildStepTwo(Size query, jobFieldsData, dataForCreateJob) {
    return AbsorbPointer(
      absorbing: isLoading,
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 2.h),
                  Text(LabelString.lblContractNumber,
                      style: GoogleFonts.roboto(
                          fontSize: 13.sp, fontWeight: FontWeight.w700)),
                  SizedBox(height: 1.h),
                  TextFormField(
                    controller: contractNumberController,
                    decoration: InputDecoration(
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
                        hintText: LabelString.lblContractNumber,
                        hintStyle: CustomTextStyle.labelFontHintText,
                        counterText: "",
                        labelStyle: CustomTextStyle.labelFontHintText),
                  ),
                  SizedBox(height: 1.h),
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
                    controller: specialInstructionController,
                    obscureText: false,
                    hint: LabelString.lblSpecialInstruction,
                    titleText: LabelString.lblSpecialInstruction,
                    textInputAction: TextInputAction.next,
                    maxLines: 3,
                    minLines: 1,
                    isRequired: true,
                  ),
                  CustomTextField(
                    keyboardType: TextInputType.text,
                    readOnly: false,
                    controller: engineerNoteController,
                    obscureText: false,
                    hint: LabelString.lblEngineerNote,
                    titleText: LabelString.lblEngineerNote,
                    textInputAction: TextInputAction.next,
                    maxLines: 3,
                    minLines: 1,
                    isRequired: true,
                  ),
                  SizedBox(
                      width: query.width,
                      height: query.height * 0.06,
                      child: CustomButton(
                          buttonColor: AppColors.primaryColor,
                          onClick: () {
                            if (engineerNoteController.text.isEmpty) {
                              Helpers.showSnackBar(
                                  context, ErrorString.selectPaymentInstruction,
                                  isError: true);
                            } else {
                              if (installationTime == "") {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      ///Make new class for dialog
                                      return Dialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          elevation: 0,
                                          insetAnimationCurve:
                                              Curves.decelerate,
                                          insetPadding: EdgeInsets.symmetric(
                                              horizontal: 12.sp),
                                          child: QuoteEstimation(
                                              dataQuote: dataForCreateJob,
                                              "job"));
                                    }).then((value) {
                                  print(value);
                                  setState(() {
                                    installationTime = value["keyTimeType"];
                                    Navigator.pop(context, "yes");
                                    createJob(dataForCreateJob);
                                  });
                                });
                              } else {
                                createJob(dataForCreateJob);
                              }
                            }
                          },
                          title: ButtonString.btnSubmit)),
                ],
              ),
            ),
          ),
          Visibility(
            visible: isLoading,
            child: Align(
                alignment: Alignment.center,
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: loadingView(),
                  ),
                )),
          ),
        ],
      ),
    );
  }

  Future<void> createJob(dataForCreateJob) async {
    String jsonStringMap;

    if (dataForCreateJob["quote_quote_type"] == "Installation") {
      var testData = {
        "job_checklist_booked": "",
        "job_checklist_raise_invoice": "",
        "job_checklist_pick_list_stock": "",
        "job_checklist_obt_cust_feedback": "",
        "job_checklist_payment_on_complet": "",
        "job_checklist_extra_stock_allocate": "",
        "job_checklist_extra_stock_return_faulty": "",
        "job_checklist_comms_allocated": "",
        "job_checklist_order_comms": "",
        "job_checklist_urn_sent_client": "",
        "job_checklist_urn_received_client": "",
        "job_checklist_urn_appli_police_force": "",
        "job_checklist_urn_received_police_force": "",
        "job_checklist_mainten_sent_client": "",
        "job_checklist_mainten_received": "",
        "job_checklist_keyholder_sent_client": "",
        "job_checklist_keyholder_received": "",
        "job_checklist_cs_digi_check": "",
        "job_checklist_issue_nsi_cert_check": "",
        "job_checklist_dd_rec_sub_setup": "",
        "job_checklist_ready_to_close": ""
      };
      jsonStringMap = json.encode(testData);
    } else {
      var testData = {
        "job_checklist_booked": "",
        "job_checklist_raise_invoice": "",
        "job_checklist_pick_list_stock": "",
        "job_checklist_payment_on_complet": "",
        "job_checklist_extra_stock_allocate": "",
        "job_checklist_extra_stock_return_faulty": "",
        "job_checklist_stock_require": "",
        "job_checklist_pay_recived": "",
        "job_checklist_ready_to_close": ""
      };
      jsonStringMap = json.encode(testData);
    }

    SharedPreferences preferences = await SharedPreferences.getInstance();
    CreateJobRequest createJobRequest = CreateJobRequest(
        subject: dataForCreateJob["subject"] ?? " ",
        quoteId: dataForCreateJob["id"] ?? " ",
        contactId: dataForCreateJob["contact_id"] ?? " ",
        sostatus: "Created",
        hdnGrandTotal: dataForCreateJob["hdnGrandTotal"] ?? " ",
        hdnSubTotal: dataForCreateJob["hdnSubTotal"] ?? " ",
        hdnTaxType: dataForCreateJob["hdnTaxType"] ?? " ",
        hdnDiscountPercent: dataForCreateJob["hdnDiscountPercent"] ?? " ",
        hdnDiscountAmount: dataForCreateJob["hdnDiscountAmount"] ?? " ",
        hdnSHAmount: dataForCreateJob["hdnS_H_Amount"] ?? " ",
        assignedUserId: dataForCreateJob["assigned_user_id"] ?? " ",
        currencyId: dataForCreateJob["currency_id"] ?? " ",
        conversionRate: dataForCreateJob["conversion_rate"] ?? " ",
        billStreet: dataForCreateJob["bill_street"] ?? " ",
        shipStreet: dataForCreateJob["ship_street"] ?? " ",
        billCity: dataForCreateJob["bill_city"] ?? " ",
        shipCity: dataForCreateJob["ship_city"] ?? " ",
        billCountry: dataForCreateJob["bill_country"] ?? " ",
        shipCountry: dataForCreateJob["ship_country"] ?? " ",
        billCode: dataForCreateJob["bill_code"] ?? " ",
        shipCode: dataForCreateJob["ship_code"] ?? " ",
        startPeriod: " ",
        endPeriod: " ",
        paymentDuration: " ",
        invoicestatus: "Created",
        preTaxTotal: dataForCreateJob["pre_tax_total"] ?? "  ",
        hdnSHPercent: dataForCreateJob["hdnS_H_Percent"] ?? "  ",
        jobCompany: dataForCreateJob["quotes_company"] ?? "  ",
        contractNumber: contractNumberPass ?? "  ",
        jobsSystemType: dataForCreateJob["system_type"] ?? "  ",
        jobsTerms: dataForCreateJob["terms_conditions"] ?? "  ",
        jobsGradeNumber: dataForCreateJob["grade_number"] ?? "  ",
        jobsSignallingType: dataForCreateJob["signalling_type"] ?? "  ",
        jobsProjectManager: dataForCreateJob["project_manager"] ?? "  ",
        installation: dataForCreateJob["installation"] ?? "  ",
        email: dataForCreateJob["quotes_email"] ?? "  ",
        telephoneNumber: dataForCreateJob["quote_telephone_number"] ?? "  ",
        mobileNumber: dataForCreateJob["quote_mobile_number"] ?? "  ",
        priorityLevel: priorityLevelSelect ?? "  ",
        engineersNote: engineerNoteController.text ?? "  ",
        officeNote: officeNoteController.text ?? "  ",
        specialInstructions: specialInstructionController.text ?? "  ",
        installationTimeRequired: installationTime,
        preferredInstallationTeam: dataForCreateJob["quote_quote_type"] == "Installation"
            ? numberOfEngineer
            : " ",
        worksSchedule: dataForCreateJob["quote_quote_type"] == "Installation"
            ? workScheduleSelect
            : " ",
        instructionsToProceed: dataForCreateJob["quote_quote_type"] == "Installation"
            ? instructionToProceedSelect
            : " ",
        paymentInstructions: dataForCreateJob["quote_quote_type"] == "Installation"
            ? paymentInstructionSelect
            : " ",
        paymentMethod: dataForCreateJob["quote_quote_type"] == "Installation"
            ? paymentMethodSelect
            : " ",
        isConfirm: "0",
        contractNotesJob: "",
        invoiceNumber: "",
        jobPremisesType: dataForCreateJob["premises_type"] ?? "",
        jobTaskTimestamp: "",
        hdnprofitTotal: dataForCreateJob["hdnprofitTotal"] ?? "",
        jobType: dataForCreateJob["quote_quote_type"] ?? "",
        soJobStatus: "",
        isscheduledjob: "0 ",
        isJobScheduleMailSent: "0 ",
        jobServiServiceMonth: " ",
        jobServiPerAnnum: "",
        jobServiServiceYear: " ",
        jobServiServiceType: " ",
        salesorderRelatedId: "0 ",
        isCustomerConfirm: "0 ",
        jobSchDateByCustomer: "",
        jobSchAltDateByCustomer: "",
        jobSchCustomerNotes: "",
        isProjectTaskCreatedAsana: "0 ",
        asanaCreatedProjectId: "",
        jobPartStatus: "",
        jotformWorkCarryOut: "",
        jotformOutStandWork: "",
        jotformPartReqNextVisit: "",
        jotformAddWorkToQuote: "",
        jotformPartUsed: "",
        jobChecklistBooked: "",
        jobChecklistRaiseInvoice: "",
        jobChecklistRaiseInvoiceNumber: "",
        jobChecklistPickListStock: "",
        jobChecklistObtCustFeedback:
            dataForCreateJob["quote_quote_type"] != "Installation"
                ? "Not select"
                : "",
        jobChecklistPaymentOnComplet: "",
        jobChecklistExtraStockAllocate: "",
        jobChecklistExtraStockReturnFaulty: "",
        jobChecklistCommsAllocated:
            dataForCreateJob["quote_quote_type"] != "Installation"
                ? "Not select"
                : "",
        jobChecklistCreateContract:
            dataForCreateJob["quote_quote_type"] != "Installation"
                ? "Not select"
                : "",
        jobChecklistOrderComms: dataForCreateJob["quote_quote_type"] != "Installation"
            ? "Not select"
            : "",
        jobChecklistUrnSentClient: dataForCreateJob["quote_quote_type"] != "Installation"
            ? "Not select"
            : "",
        jobChecklistUrnReceivedClient:
            dataForCreateJob["quote_quote_type"] != "Installation"
                ? "Not select"
                : "",
        jobChecklistUrnAppliPoliceForce:
            dataForCreateJob["quote_quote_type"] != "Installation"
                ? "Not select"
                : "",
        jobChecklistUrnReceivedPoliceForce:
            dataForCreateJob["quote_quote_type"] != "Installation" ? "Not select" : "",
        jobChecklistMaintenSentClient: dataForCreateJob["quote_quote_type"] != "Installation" ? "Not select" : "",
        jobChecklistMaintenReceived: dataForCreateJob["quote_quote_type"] != "Installation" ? "Not select" : "",
        jobChecklistKeyholderSentClient: dataForCreateJob["quote_quote_type"] != "Installation" ? "Not select" : "",
        jobChecklistKeyholderReceived: dataForCreateJob["quote_quote_type"] != "Installation" ? "Not select" : "",
        jobChecklistCsDigiCheck: "",
        jobChecklistCsDigiNumber: "",
        jobChecklistIssueNsiCertCheck: "",
        jobChecklistIssueNsiCertNumber: "",
        jobChecklistReadyToClose: "",
        jobChecklistPayRecived: dataForCreateJob["quote_quote_type"] == "Installation" ? "Not select" : "",
        jobChecklistStockRequire: dataForCreateJob["quote_quote_type"] == "Installation" ? "Not select" : "",
        jobChecklistDdRecSubSetup: dataForCreateJob["quote_quote_type"] != "Installation" ? "Not select" : "",
        lineItems: dataForCreateJob["LineItems"].map((e) {
          return LineItems(
            productid: e["productid"].toString().replaceAll("14x", ""),
            sequenceNo: e["sequence_no"],
            quantity: e["quantity"],
            listprice: e["listprice"],
            discountPercent: e["discount_percent"],
            discountAmount: e["discount_amount"],
            comment: e["comment"],
            description: e["description"],
            incrementondel: e["incrementonde"],
            tax1: e["tax1"],
            tax2: e["tax2"],
            tax3: e["tax3"],
            productLocation: e["product_location"],
            productLocationTitle: e["product_location_title"],
            costprice: e["costprice"],
            extQty: e["ext_qty"],
            requiredDocument: e["required_document"],
            proShortDescription: e["pro_short_description"],
          );
        }).toList());

    String jsonJobDetail = jsonEncode(createJobRequest);

    debugPrint(" jsonQuoteDetail add ----- $jsonJobDetail");

    Map<String, String> bodyData = {
      'operation': "create",
      'sessionName':
          preferences.getString(PreferenceString.sessionName).toString(),
      'element': jsonEncode(createJobRequest),
      'elementType': "SalesOrder",
      'appversion': Constants.of().appversion.toString(),
      'contract_number': dataForCreateJob["quote_quote_type"] == "Installation"
          ? contractNumberController.text.toString()
          : contractNumberPass,
      'job_type': dataForCreateJob["quote_quote_type"].toString(),
      'contact_id_display': dataForCreateJob["contact_name"].toString(),
      'jobs_system_type': dataForCreateJob["system_type"].toString(),
      'jobs_project_manager_display':
          dataForCreateJob["project_manager_name"].toString(),
      'sourceModule': "ServiceContracts",
      'quotes_contract_id': contractNumberPass,
      'is_item_available':
          dataForCreateJob["LineItems"].length >= 1 ? "1" : "0",
      'field_tick_date_time': jsonStringMap
    };
    print(bodyData);
    createJobBloc.add(CreateJobDetailEvent(bodyData));
  }
}
