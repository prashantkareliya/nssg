import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nssg/components/custom_text_styles.dart';
import 'package:nssg/constants/strings.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../utils/app_colors.dart';
import '../create_job.dart';


class JobSchedule extends StatefulWidget {
  const JobSchedule({Key? key}) : super(key: key);

  @override
  State<JobSchedule> createState() => _JobScheduleState();
}

class _JobScheduleState extends State<JobSchedule> {
  int currentPage = 0;
  final controller = PageController(viewportFraction: 1.0, keepPage: true);

  int count = 0;

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.transparent,
      body: Container(
        height: query.height,
        width: query.width,
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage(ImageString.imgBackground), fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            SizedBox(height: query.height * 0.035),
            Divider(color: AppColors.whiteColor, thickness: 1.0),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.sp),
              child: Text(EngineerString.lblJobSchedule, style: GoogleFonts.roboto(
                  textStyle: TextStyle(fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.whiteColor))),
            ),
            Divider(color: AppColors.whiteColor, thickness: 1.0),
            Container(
              height: query.height * 0.23,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(100),
              ),
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: controller,
                itemCount: 3,
                scrollDirection: Axis.horizontal,
                dragStartBehavior: DragStartBehavior.start,
                itemBuilder: (ctx, index) {
                  return CircleAvatar(
                    backgroundColor: AppColors.transparent,
                      radius: 50,
                      child: ClipOval(child: Container(
                        height: 20.h,
                        width: 40.w,
                        decoration: BoxDecoration(
                          image: const DecorationImage(image: AssetImage(ImageString.imgRound)),
                          borderRadius: BorderRadius.circular(60.0)),
                        child: Center(
                          child: Text(
                            "50", style: GoogleFonts.roboto(
                              textStyle: TextStyle(fontSize: 55.sp,
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.normal,
                                  color: AppColors.whiteColor)),
                          ),
                        ),
                      )));
                },
                onPageChanged: (value) {
                  setState(() { count = value; });
                },
              ),
            ),
            SmoothPageIndicator(
                controller: controller,
                count: 3,
                effect: ScrollingDotsEffect(
                  activeStrokeWidth: 1.0,
                  activeDotScale: 1.0,
                  maxVisibleDots: 9,
                  radius: 5,
                  spacing: 7,
                  dotHeight: 1.5.h,
                  dotColor: AppColors.backWhiteColor,
                  dotWidth: 3.0.w,
                  activeDotColor: AppColors.yellowIndicator)),
            SizedBox(height: 1.5.h),
            if(count == 0)
            Text(EngineerString.lblTodayJobs, style: CustomTextStyle.specialText),
            if(count==1)
              Text(EngineerString.lblPendingJobSheetList, style: CustomTextStyle.specialText),
            if(count==2)
              Text(EngineerString.lblUpcomingJobsList, style: CustomTextStyle.specialText),

            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 5.sp, right: 5.sp, top: 10.sp),
                child: Scrollbar(radius: const Radius.circular(10.0),
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: 10,
                    itemBuilder: (context,index){
                    return InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> const createJobScreen()));
                      },
                      child: Container(
                        color: Colors.white38,
                        width: query.width,
                        child: Padding(
                          padding: EdgeInsets.only(left: 7.sp, right: 7.sp, top: 7.sp, bottom: 0),
                          child: Container(
                            width: query.width,
                            height: query.height * 0.15,
                            decoration: BoxDecoration(
                                color: AppColors.whiteColor,
                                borderRadius: BorderRadius.circular(7.0)
                            ),
                            child: Column(
                              children: [

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(2.sp),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                            color: Color(0xFF0089B3),
                                            borderRadius: BorderRadius.only(
                                                bottomRight: Radius.circular(20.0),
                                                topLeft: Radius.circular(5.0)
                                            )
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 4.sp, vertical: 2.sp),
                                          child: SvgPicture.asset(ImageString.icSetting, height: 1.5.h),
                                        ),
                                      ),
                                    ),

                                    //job number
                                    Padding(
                                      padding: EdgeInsets.only(top: 5.sp),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SvgPicture.asset(ImageString.icProfile, height: 1.5.h),
                                          SizedBox(width: 1.w),
                                          Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(color: Colors.grey, width: 2),
                                                borderRadius: BorderRadius.circular(40.0)
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 4.sp,vertical: 1.sp),
                                              child: Text("21012", style: CustomTextStyle.engineerCommonText),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    //date design
                                    Padding(
                                      padding: EdgeInsets.only(top: 5.sp),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SvgPicture.asset(ImageString.icCalender, height: 2.0.h),
                                          Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 4.sp,vertical: 2.sp),
                                            child: Text("06/06/2023", style: GoogleFonts.roboto(
                                                textStyle: TextStyle(fontSize: 10.sp,
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle: FontStyle.normal,
                                                    letterSpacing: 1,
                                                    color: AppColors.blackIcon))),
                                          )
                                        ],
                                      ),
                                    ),
                                    //time design
                                    Padding(
                                      padding: EdgeInsets.only(top: 5.sp),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SvgPicture.asset(ImageString.icTime, height: 2.0.h),
                                          Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 5.sp,vertical: 2.sp),
                                            child: Text("10:00-13:00", style: GoogleFonts.roboto(
                                                textStyle: TextStyle(fontSize: 10.sp,
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle: FontStyle.normal,
                                                    letterSpacing: 1,
                                                    color: AppColors.blackIcon))),
                                          )
                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 4.sp),
                                  child: Row(
                                    children: [
                                      SizedBox(width: 3.w),
                                      SvgPicture.asset(ImageString.icCompanyName, height: 2.0.h),
                                      SizedBox(width: 2.w),
                                      Text.rich(
                                        TextSpan(text: "Company Name : ",
                                          style: GoogleFonts.roboto(
                                              textStyle: TextStyle(fontSize: 12.sp,
                                                  fontWeight: FontWeight.w500,
                                                  fontStyle: FontStyle.normal,
                                                  letterSpacing: 1,
                                                  color: AppColors.blackIcon)),
                                          children: [
                                            TextSpan(text: "Lorem Ipsum is dummy",
                                                style: GoogleFonts.roboto(
                                                    textStyle: TextStyle(fontSize: 11.sp,
                                                        color: AppColors.blackIcon,
                                                        fontWeight: FontWeight.normal)))
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(

                                  padding: EdgeInsets.symmetric(vertical: 4.sp),
                                  child: Row(
                                    children: [
                                      SizedBox(width: 3.w),
                                      SvgPicture.asset(ImageString.icSubject, height: 2.0.h),
                                      SizedBox(width: 2.w),
                                      Text.rich(
                                        TextSpan(text: "Subject : ",
                                          style: GoogleFonts.roboto(
                                              textStyle: TextStyle(fontSize: 12.sp,
                                                  fontWeight: FontWeight.w500,
                                                  fontStyle: FontStyle.normal,
                                                  letterSpacing: 1,
                                                  color: AppColors.blackIcon)),
                                          children: [
                                            TextSpan(text: "Lorem Ipsum is dummy",
                                                style: GoogleFonts.roboto(
                                                    textStyle: TextStyle(fontSize: 11.sp,
                                                        color: AppColors.blackIcon,
                                                        fontWeight: FontWeight.normal)))
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 4.sp),
                                  child: Row(
                                    children: [
                                      SizedBox(width: 3.w),
                                      SvgPicture.asset(ImageString.icAddressEngineer, height: 2.0.h),
                                      SizedBox(width: 2.w),
                                      Text.rich(
                                        TextSpan(text: "Address : ",
                                          style: GoogleFonts.roboto(
                                              textStyle: TextStyle(fontSize: 12.sp,
                                                  fontWeight: FontWeight.w500,
                                                  fontStyle: FontStyle.normal,
                                                  letterSpacing: 1,
                                                  color: AppColors.blackIcon)),
                                          children: [
                                            TextSpan(text: "Lorem Ipsum is dummy",
                                                style: GoogleFonts.roboto(
                                                    textStyle: TextStyle(fontSize: 11.sp,
                                                        color: AppColors.blackIcon,
                                                        fontWeight: FontWeight.normal)))
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },),
                ),
              ),
            ),

            SizedBox(height: query.height * 0.09)
          ],
        ),
      ),
    );
  }
}
