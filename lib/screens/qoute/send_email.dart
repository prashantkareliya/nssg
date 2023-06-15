import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nssg/utils/extention_text.dart';
import 'package:nssg/utils/helpers.dart';
import 'package:nssg/utils/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:sizer/sizer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../components/custom_button.dart';
import '../../components/custom_text_styles.dart';
import '../../components/custom_textfield.dart';
import '../../constants/constants.dart';
import '../../constants/navigation.dart';
import '../../constants/strings.dart';
import '../../httpl_actions/app_http.dart';
import '../../utils/app_colors.dart';
import '../dashboard/root_screen.dart';

class SendEmail extends StatefulWidget {
  List<String> contactList;
  String? quoteId;
  String? contactEmail;

  String? create;

  SendEmail(this.contactList, this.quoteId, this.contactEmail, this.create,
      {Key? key})
      : super(key: key);
  @override
  State<SendEmail> createState() =>
      _SendEmailState(contactList, quoteId, contactEmail);
}

class _SendEmailState extends State<SendEmail> {
  TextEditingController emailController = TextEditingController();

  List<String> contactList = <String>[];
  String? quoteId;
  String? contactEmail;

  bool isLoading = false;
  _SendEmailState(this.contactList, this.quoteId, this.contactEmail);
  final emailFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    emailController.text = contactEmail.toString();
  }

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return SizedBox(
        width: query.width / 1.1,
        child: Form(
          key: emailFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 12.sp),
                    child: Text(LabelString.lblQuoteEmail,
                        style: CustomTextStyle.labelMediumBoldFontText),
                  ),
                  IconButton(
                    onPressed: null,
                    icon:
                        Icon(Icons.close_rounded, color: AppColors.transparent),
                    splashColor: AppColors.transparent,
                    highlightColor: AppColors.transparent,
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 11.sp),
                child: Text(
                    "Please add comma separated email addresses to send the quote to multiple people.",
                    textAlign: TextAlign.center,
                    style: CustomTextStyle.labelFontHintText),
              ),
              SizedBox(height: 20.h),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.sp),
                  child: CustomTextField(
                      keyboardType: TextInputType.emailAddress,
                      readOnly: false,
                      controller: emailController,
                      obscureText: false,
                      hint: LabelString.lblEmailAddress,
                      titleText: LabelString.lblEmailAddress,
                      maxLines: 2,
                      minLines: 1,
                      textInputAction: TextInputAction.done,
                      onEditingComplete: () {},
                      isRequired: true)),
              SizedBox(height: 20.h),
              isLoading
                  ? Lottie.asset('assets/lottie/sending.json',
                      height: 60.h, animate: true)
                  : SizedBox(
                      width: query.width * 0.4,
                      height: query.height * 0.06,
                      child: CustomButton(
                          title: ButtonString.btnSubmit,
                          onClick: () {
                            if (emailFormKey.currentState!.validate()) {
                              sendEmail();
                            }
                          })),
              SizedBox(height: 20.h)
            ],
          ),
        ));
  }

  sendEmail() async {
    if (contactList.isEmpty) {
      contactList = emailController.text.split(", ");
    }

    FocusScope.of(context).unfocus();
    setState(() {
      isLoading = true;
    });
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map<String, dynamic> queryParameters = {
      'operation': "mail_send_with_attch",
      'sessionName':
          preferences.getString(PreferenceString.sessionName).toString(),
      'id': quoteId.toString(),
      'toEmail': /*contactList*/
          contactList
              .toString()
              .replaceAll("[", '["')
              .replaceAll("]", '"]')
              .replaceAll(",", '", "')
              .replaceAll(" ", "")
    };

    final response = await HttpActions()
        .getMethod(ApiEndPoint.mainApiEnd, queryParams: queryParameters);

    debugPrint("send email response  --- $response");
    if (response["success"] == true) {
      isLoading = false;
      Navigator.pop(context);
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 0,
                insetAnimationCurve: Curves.decelerate,
                insetPadding: EdgeInsets.symmetric(horizontal: 8.sp),
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.15,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: Colors.white),
                  child: Padding(
                    padding: EdgeInsets.all(12.sp),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Lottie.asset('assets/lottie/done.json',
                            height: 60.h, reverse: false, repeat: false),
                        SizedBox(height: 10.h),
                        Text(
                            "${Message.quoteEmailSentMessage}:\n\n${contactList.join(",\n")}",
                            textAlign: TextAlign.center,
                            style: CustomTextStyle.labelMediumBoldFontText),
                        SizedBox(height: 20.h),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.06,
                            width: MediaQuery.of(context).size.width,
                            child: CustomButton(
                                title: LabelString.lblOk,
                                buttonColor: AppColors.primaryColor,
                                onClick: () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);

                                  if (widget.create == "create") {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  }
                                  //removeAndCallNextScreen(context, const RootScreen());
                                })),
                        SizedBox(height: 10.h),
                      ],
                    ),
                  ),
                ));
          });
    }
    return response;
  }
}
