import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nssg/utils/helpers.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_radio_button.dart';
import '../../../components/custom_text_styles.dart';
import '../../../components/global_api_call.dart';
import '../../../constants/strings.dart';
import '../../../httpl_actions/handle_api_error.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/widgetChange.dart';
import '../../../utils/widgets.dart';


class QuoteEstimation extends StatefulWidget {
  var dataQuote;

  String? type;

  QuoteEstimation(this.type, {this.dataQuote});


  @override
  State<QuoteEstimation> createState() => _QuoteEstimationState();
}

class _QuoteEstimationState extends State<QuoteEstimation> {
  Future<dynamic>? getFields;

  List<RadioModel> numbersOfEng = <RadioModel>[]; //step 1
  List<RadioModel> installationTiming = <RadioModel>[]; //step 1

  String? engineerNumbers;
  String? eAmount = "0.0";
  String? timeType;

  get productsList => null;

  @override
  void initState() {
    super.initState();
    if(widget.dataQuote != null){
      if(widget.dataQuote["quote_no_of_engineer"].toString() != ""){
        engineerNumbers = widget.dataQuote["quote_no_of_engineer"].toString();
      }

      if(widget.dataQuote["quote_req_to_complete_work"].toString() != ""){
        timeType = widget.dataQuote["quote_req_to_complete_work"].toString();
      }
      calculation();
    }
  }
  @override
  Widget build(BuildContext context) {
    getFields = getQuoteFields("Quotes", context);

    return FutureBuilder<dynamic>(
        future: getFields,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var fieldsData = snapshot.data["result"];
            return Padding(
              padding:  EdgeInsets.symmetric(horizontal: 12.sp),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 2.0.h),
                  Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                          highlightColor: AppColors.transparent,
                          splashColor: AppColors.transparent,
                          onTap: () => Navigator.pop(context),
                          child: Icon(Icons.close_rounded,
                              color: AppColors.blackColor))),
                  Text(LabelString.lblNumberOfEngineer,
                      style: CustomTextStyle.labelFontText),
                  SizedBox(height: 1.0.h),
                  Wrap(
                    spacing: 5,
                    children: List.generate(
                      fieldsData["quote_no_of_engineer"].length,
                          (index) {
                        if(widget.dataQuote != null){
                          numbersOfEng.add(RadioModel(
                              widget.dataQuote["quote_no_of_engineer"].toString().contains(fieldsData["quote_no_of_engineer"][index]["label"]) ?
                              true : false,
                              fieldsData["quote_no_of_engineer"][index]["label"]));
                        }else{
                          numbersOfEng.add(RadioModel(false, fieldsData["quote_no_of_engineer"][index]["label"]));
                        }
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
                              Provider.of<WidgetChange>(context, listen: false).isSelectEngineers();
                              numbersOfEng[index].isSelected = true;
                              Provider.of<WidgetChange>(context, listen: false).isSetEngineer;

                              engineerNumbers = fieldsData["quote_no_of_engineer"][index]["label"].toString();
                              calculation();
                            },
                            child: RadioItem(numbersOfEng[index]),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(LabelString.lblInstallationHours,
                      style: CustomTextStyle.labelFontText),
                  SizedBox(height: 1.0.h),
                  //Installation Hours,
                  Wrap(
                    spacing: 5,
                    children: List.generate(
                      fieldsData["quote_req_to_complete_work"].length,
                          (index) {
                            if(widget.dataQuote != null){
                              installationTiming.add(RadioModel(
                                  widget.dataQuote["quote_req_to_complete_work"].toString().contains(fieldsData["quote_req_to_complete_work"][index]["label"]) ?
                                  true : false,
                                  fieldsData["quote_req_to_complete_work"][index]["label"]));
                            }else{
                              installationTiming.add(RadioModel(false, fieldsData["quote_req_to_complete_work"][index]["label"]));
                            }
                        return SizedBox(
                          height: 6.h,
                          child: InkWell(
                            splashColor: AppColors.transparent,
                            highlightColor: AppColors.transparent,
                            onTap: () {
                              for (var element in installationTiming) {
                                element.isSelected = false;
                              }

                              Provider.of<WidgetChange>(context, listen: false).isSelectTime();
                              installationTiming[index].isSelected = true;
                              Provider.of<WidgetChange>(context, listen: false).isSetTime;

                              if (fieldsData["quote_req_to_complete_work"][index]["label"].toString().endsWith("Hours")) {
                                timeType = fieldsData["quote_req_to_complete_work"][index]["label"].toString();
                                calculation();
                              } else {
                                timeType = fieldsData["quote_req_to_complete_work"][index]["label"].toString();
                                calculation();
                              }
                            },
                            child: RadioItem(installationTiming[index]),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 2.0.h),
                  Visibility(
                    visible: false,
                    child: Row(
                      children: [
                        SizedBox(
                          child: Checkbox(
                              onChanged: (value) => Provider.of<WidgetChange>(context, listen: false).isReminder(),
                              value: Provider.of<WidgetChange>(context, listen: true).isReminderCheck),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10.sp),
                          child: Text("",
                              style: CustomTextStyle.labelFontText),
                        )
                      ],
                    ),
                  ),
                  //Estimated installation amount text
                  widget.type == "job" ? Container() : RichText(
                    text: TextSpan(
                        text: "${LabelString.lblEstimationAmount} : ",
                        style: CustomTextStyle.labelText,
                        children: [
                          TextSpan(
                              text: "£$eAmount",
                              style: GoogleFonts.roboto(textStyle: TextStyle(
                                  fontSize: 18.sp,
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.bold)))
                        ]),
                  ),

                  SizedBox(height: 3.0.h),

                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.06,
                    child: CustomButton(
                      //next button
                        title: ButtonString.btnSubmit,
                        onClick: widget.type == "job" ?  (){
                          if(eAmount != "0.0"){
                            final data = {"keyEngineerNumbers" : engineerNumbers, "keyTimeType" : timeType};
                            Navigator.pop(context, data);
                          }else{
                            showToast("Please select required fields");
                          }
                        } :
                        () {
                          if(eAmount != "0.0"){
                            final data = { "keyAmount" : eAmount, "keyEngineerNumbers" : engineerNumbers, "keyTimeType" : timeType};
                            Navigator.pop(context, data);
                          }else{
                            showToast("Please select required fields");
                          }
                        },
                        buttonColor: AppColors.primaryColor),
                  ),
                  SizedBox(height: 2.0.h),
                ],

              ),
            );
          }  else if (snapshot.hasError) {
            final message = HandleAPI.handleAPIError(snapshot.error);
            return Text(message);
          }
          return SizedBox(height: 70.h, child: loadingView());
        }

    );
  }

  //Estimated Amount calculation method
  void calculation() {
    //Check number of engineers are null or not
    if (engineerNumbers != null && timeType != null) {
      if (timeType!.endsWith("Hours")) {
        var timeCalculate = (int.parse(engineerNumbers!) *
            int.parse(timeType!.substring(0, 1)) * 35);
        var vatAdd = (int.parse(timeCalculate.toString()) * (0.20)) + timeCalculate;
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
}
