import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nssg/components/custom_text_styles.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../components/custom_button.dart';
import '../../../constants/strings.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/widgetChange.dart';

class createJobScreen extends StatefulWidget {
  const createJobScreen({Key? key}) : super(key: key);

  @override
  State<createJobScreen> createState() => _createJobScreenState();
}

class _createJobScreenState extends State<createJobScreen> {
  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.backWhiteColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              color: AppColors.whiteColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: query.height * 0.035),
                  const Divider(color: Color(0xFFD9D9D9), thickness: 1.0),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.sp, horizontal: 5.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.arrow_back_ios_rounded,
                            color: AppColors.blackColor),
                        Text(EngineerString.lblCreateJob,
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.blackColor))),
                        Icon(Icons.arrow_back_ios_rounded,
                            color: AppColors.transparent),
                      ],
                    ),
                  ),
                  const Divider(color: Color(0xFFD9D9D9), thickness: 1.0),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.sp, vertical: 6.sp),
                    child: Text("Vince Naran - Intruder & Hold",
                        style: CustomTextStyle.labelMediumBoldFontText),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.sp, vertical: 8.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: query.width * 0.22,
                          decoration: BoxDecoration(
                              color: const Color(0xFF46AB44),
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.sp),
                            child: Column(
                              children: [
                                SvgPicture.asset(ImageString.icJobSpec,
                                    height: 25.h),
                                SizedBox(height: 5.h),
                                Text("Job Spec",
                                    style: GoogleFonts.roboto(
                                        textStyle: TextStyle(
                                            fontSize: 12.sp,
                                            fontStyle: FontStyle.normal,
                                            color: AppColors.whiteColor)))
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: query.width * 0.22,
                          decoration: BoxDecoration(
                              color: const Color(0xFFDF5858),
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.sp),
                            child: Column(
                              children: [
                                SvgPicture.asset(ImageString.icReject,
                                    height: 25.h),
                                SizedBox(height: 5.h),
                                Text("Rejected",
                                    style: GoogleFonts.roboto(
                                        textStyle: TextStyle(
                                            fontSize: 12.sp,
                                            fontStyle: FontStyle.normal,
                                            color: AppColors.whiteColor)))
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: query.width * 0.22,
                          decoration: BoxDecoration(
                              color: const Color(0xFF489CFE),
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.sp),
                            child: Column(
                              children: [
                                SvgPicture.asset(ImageString.icArrived,
                                    height: 25.h),
                                SizedBox(height: 5.h),
                                Text("Arrived",
                                    style: GoogleFonts.roboto(
                                        textStyle: TextStyle(
                                            fontSize: 12.sp,
                                            fontStyle: FontStyle.normal,
                                            color: AppColors.whiteColor)))
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: query.width * 0.22,
                          decoration: BoxDecoration(
                              color: const Color(0xFFFF9559),
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.sp),
                            child: Column(
                              children: [
                                SvgPicture.asset(ImageString.icDeparted,
                                    height: 25.h),
                                SizedBox(height: 5.h),
                                Text("Departed",
                                    style: GoogleFonts.roboto(
                                        textStyle: TextStyle(
                                            fontSize: 12.sp,
                                            fontStyle: FontStyle.normal,
                                            color: AppColors.whiteColor)))
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 1.h)
                ],
              )),
          SizedBox(height: 3.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.sp),
            child: Column(
              children: [
                Card(
                  elevation: 1,
                  child: ExpansionTile(
                    initiallyExpanded: false,
                    iconColor: AppColors.blackColor,
                    onExpansionChanged: (value) {
                      Provider.of<WidgetChange>(context, listen: false)
                          .isExpansionTileFirst(value);
                    },
                    textColor: AppColors.blackColor,
                    collapsedBackgroundColor: AppColors.whiteColor,
                    title: Text(EngineerString.lblJobDetail,
                        style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                                fontSize: 14.sp,
                                color: AppColors.fontColor,
                                fontWeight: FontWeight.w500))),
                    trailing: SvgPicture.asset(
                        Provider.of<WidgetChange>(context, listen: true)
                                .isExpansionOne
                            ? ImageString.icArrowDown
                            : ImageString.icArrowRight),
                    backgroundColor: AppColors.whiteColor,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("\u2022  Contract Number",
                                  style: CustomTextStyle.labelTextBig),
                              SizedBox(height: 1.h),
                              Text("\u2022  System Type",
                                  style: CustomTextStyle.labelTextBig),
                              SizedBox(height: 1.h),
                              Text("\u2022  Primary signal Type",
                                  style: CustomTextStyle.labelTextBig),
                              SizedBox(height: 1.h),
                              Text("\u2022  Contact Name",
                                  style: CustomTextStyle.labelTextBig),
                              SizedBox(height: 1.h),
                              Text("\u2022  Installation Address Details",
                                  style: CustomTextStyle.labelTextBig),
                              SizedBox(height: 1.h),
                              Text("\u2022  Office phone",
                                  style: CustomTextStyle.labelTextBig),
                              SizedBox(height: 1.h),
                              Text("\u2022  Mobile phone",
                                  style: CustomTextStyle.labelTextBig),
                              SizedBox(height: 1.h),
                              Text("\u2022  Project manager",
                                  style: CustomTextStyle.labelTextBig),
                              SizedBox(height: 1.h),
                              Text("\u2022  CS Digi No. Police",
                                  style: CustomTextStyle.labelTextBig),
                              SizedBox(height: 1.h),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 1.h),
                Card(
                  elevation: 1,
                  child: ExpansionTile(
                    initiallyExpanded: false,
                    iconColor: AppColors.blackColor,
                    onExpansionChanged: (value) {
                      Provider.of<WidgetChange>(context, listen: false)
                          .isExpansionTileFirst(value);
                    },
                    textColor: AppColors.blackColor,
                    collapsedBackgroundColor: AppColors.whiteColor,
                    title: Text(EngineerString.lblEngineerGeneralTaskDetails,
                        style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                                fontSize: 14.sp,
                                color: AppColors.fontColor,
                                fontWeight: FontWeight.w500))),
                    trailing: SvgPicture.asset(
                        Provider.of<WidgetChange>(context, listen: true)
                                .isExpansionOne
                            ? ImageString.icArrowDown
                            : ImageString.icArrowRight),
                    backgroundColor: AppColors.whiteColor,
                    children: [
                      Text("Data", style: CustomTextStyle.labelTextBig),
                    ],
                  ),
                ),
                SizedBox(height: 0.2.sh),
                SizedBox(
                  width: query.width * 0.55,
                  height: query.height * 0.06,
                  child: CustomButton(
                    //update button
                      title: "Start Job Sheet",
                      onClick: () { },
                      buttonColor: AppColors.primaryColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
