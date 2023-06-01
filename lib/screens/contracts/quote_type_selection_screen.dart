import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../components/custom_appbar.dart';
import '../../components/custom_text_styles.dart';
import '../../constants/navigation.dart';
import '../../constants/strings.dart';
import '../../utils/app_colors.dart';
import '../qoute/add_quote/add_quote_screen.dart';

class QuoteTypeSelection extends StatefulWidget {
  var contractList;

  QuoteTypeSelection({Key? key, required this.contractList}) : super(key: key);

  @override
  State<QuoteTypeSelection> createState() => _QuoteTypeSelectionState();
}

class _QuoteTypeSelectionState extends State<QuoteTypeSelection> {
  @override
  void initState() {
    super.initState();
    print(widget.contractList);
  }
  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.backWhiteColor,
      appBar: BaseAppBar(
        appBar: AppBar(),
            title: "Create a Quote",
            titleTextStyle: CustomTextStyle.labelFontText,
            isBack: true,
            searchWidget: const Text(""),
            backgroundColor: AppColors.backWhiteColor,
          ),
      body: SizedBox(
        width: query.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                SizedBox(height: 1.5.h),
                Text(widget.contractList["subject"].toString().substring(0, widget.contractList["subject"].toString().indexOf("-")),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold))),
                SizedBox(height: 1.5.h),
                Text("Contract# ${widget.contractList["ser_con_contract_number"]}", style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold))),
                SizedBox(height: 3.h),
              ],
            ),
            Column(
              children: [
                InkWell(
                  highlightColor: AppColors.transparent,
                  splashColor: AppColors.transparent,
                  onTap: (){
                    callNextScreen(context,
                        AddQuotePage(true, "installation","contract",
                            contactId: widget.contractList["sc_related_to"],
                            contractList: widget.contractList));
                  },
                  child: quoteTypeWidget(query: query, text: ButtonString.btnInstallation,
                      imageString: ImageString.icInstallation2),
                ),

                InkWell(
                  highlightColor: AppColors.transparent,
                  splashColor: AppColors.transparent,
                  onTap: (){
                    callNextScreen(context,
                        AddQuotePage(true, "breakdown", "contract",
                            contactId: widget.contractList["sc_related_to"],
                            contractList: widget.contractList));
                  },
                  child: quoteTypeWidget(query: query, text: ButtonString.btnBreakdown,
                      imageString: ImageString.icBreakdown),
                ),

                InkWell(
                  highlightColor: AppColors.transparent,
                  splashColor: AppColors.transparent,
                  onTap: (){
                    callNextScreen(context,
                        AddQuotePage(true, "service", "contract",
                            contactId: widget.contractList["sc_related_to"],
                            contractList: widget.contractList));
                  },
                  child: quoteTypeWidget(query: query, text: ButtonString.btnService,
                      imageString: ImageString.icService),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class quoteTypeWidget extends StatelessWidget {
  String text;

  String imageString;

  quoteTypeWidget({
    super.key,
    required this.query,
    required this.text,
    required this.imageString,
  });

  final Size query;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.sp,vertical: 8.sp),
      child: Container(width: query.width, height: query.height * 0.18,
        decoration: BoxDecoration(color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(10.sp)),
        child: Padding(padding: EdgeInsets.symmetric(vertical: 12.sp),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SvgPicture.asset(imageString, height: 7.5.h),
              Text(text, style: GoogleFonts.roboto(
                  textStyle: TextStyle(fontSize: 17.sp,
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w500))),
            ],
          ),
        ),
      ),
    );
  }
}
