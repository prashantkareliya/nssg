import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

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

  ThankYouScreen(this.quoteId, this.contactEmail, {Key? key}) : super(key: key);

  @override
  State<ThankYouScreen> createState() => _ThankYouScreenState(quoteId, contactEmail);
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
          SizedBox(height: 3.h),
          Column(
            children: [
              Lottie.asset('assets/lottie/created.json', height: 15.h,  reverse: false, repeat: false),
              Text(LabelString.lblThankYou, style: CustomTextStyle.labelMediumBoldFontText),
              Text(Message.quoteCreateSuccessfully, style: CustomTextStyle.commonText),
            ],
          ),
          SizedBox(height: 3.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.sp),
            child:  isLoading ? SizedBox(
                height: query.height * 0.12,
                width: query.width * 0.8,
                child: loadingView()) :
            Column(
              children: [
                SizedBox(
                    width: query.width * 0.8,
                    height: query.height * 0.06,
                    child: CustomButton(
                        title: ButtonString.btnQuoteDetail,
                        buttonColor: AppColors.primaryColor,
                        onClick: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.pop(context);
                          removeAndCallNextScreen(context, QuoteDetail(quoteId));
                        })),
                SizedBox(height: 1.h),
                SizedBox(
                    width: query.width * 0.8,
                    height: query.height * 0.06,
                    child: ElevatedButton(
                      onPressed: (){
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
                                child: SendEmail(contactList, quoteId, contactEmail, "create"),
                              );
                            });
                        //sendEmail(contactList, context);
                      },
                      clipBehavior: Clip.hardEdge,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor.withOpacity(0.20),
                        foregroundColor: AppColors.primaryColor.withOpacity(0.20),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0))),
                      ),
                      child: Text(ButtonString.btnEmailShare,
                          style:  GoogleFonts.roboto(
                            textStyle: TextStyle(fontSize: 12.sp, color: AppColors.primaryColor),
                          )),
                    )),],
            ),
          ),
          SizedBox(height: 2.h),
        ],
      ),
    );
  }
}