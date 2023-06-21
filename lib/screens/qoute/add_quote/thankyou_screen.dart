import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
// import 'package:sizer/sizer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../components/custom_button.dart';
import '../../../components/custom_text_styles.dart';
import '../../../constants/navigation.dart';
import '../../../constants/strings.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/widgets.dart';
import '../quotes_screen.dart';
import '../send_email.dart';

class ThankYouScreen extends StatefulWidget {
  String quoteId;

  String contactEmail;

  String? quoteNo;

  ThankYouScreen(this.quoteId, this.contactEmail, this.quoteNo, {Key? key})
      : super(key: key);

  @override
  State<ThankYouScreen> createState() =>
      _ThankYouScreenState(quoteId, contactEmail);
}

class _ThankYouScreenState extends State<ThankYouScreen> {
  String quoteId;

  String? contactEmail;
  List<String> contactList = [];

  bool isLoading = false;

  _ThankYouScreenState(this.quoteId, this.contactEmail);

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return SizedBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(height: 10.h),
          Column(
            children: [
              Lottie.asset('assets/lottie/created.json',
                  height: 50.h, reverse: false, repeat: false),
              Text(LabelString.lblThankYou,
                  style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black))),
              SizedBox(
                height: 5.h,
              ),
              Text(Message.quoteCreateSuccessfully,
                  style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.black))),
            ],
          ),
          SizedBox(height: 10.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.sp),
            child: isLoading
                ? SizedBox(
                    height: query.height * 0.12,
                    width: query.width * 0.8,
                    child: loadingView())
                : Column(
                    children: [
                      SizedBox(
                          height: query.height * 0.06,
                          width: query.width * 0.8,
                          child: CustomButton(
                              title: ButtonString.btnQuoteDetail,
                              buttonColor: AppColors.primaryColor,
                              onClick: () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.pop(context);
                                removeAndCallNextScreen(
                                    context,
                                    QuoteDetail(quoteId,
                                        quoteNo: widget.quoteNo));
                              })),
                      SizedBox(height: 10.h),
                      SizedBox(
                          width: query.width * 0.8,
                          height: query.height * 0.06,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) {
                                    return Dialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      elevation: 0,
                                      insetAnimationCurve: Curves.decelerate,
                                      insetPadding: EdgeInsets.symmetric(
                                          horizontal: 8.sp),
                                      child: SendEmail(contactList, quoteId,
                                          contactEmail, "create"),
                                    );
                                  });
                              //sendEmail(contactList, context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  AppColors.primaryColor.withOpacity(0.20),
                              foregroundColor:
                                  AppColors.primaryColor.withOpacity(0.30),
                              elevation: 0,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                            ),
                            child: Text(ButtonString.btnEmailShare,
                                style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      fontSize: 18.sp,
                                      color: AppColors.primaryColor,
                                      fontWeight: FontWeight.w400),
                                )),
                          )),
                    ],
                  ),
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
