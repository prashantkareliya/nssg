import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../components/custom_appbar.dart';
import '../../components/custom_text_styles.dart';
import '../../constants/strings.dart';
import '../../utils/app_colors.dart';
import '../../utils/widgetChange.dart';


class JobListScreen extends StatefulWidget {
  const JobListScreen({Key? key}) : super(key: key);

  @override
  State<JobListScreen> createState() => _JobListScreenState();
}

class _JobListScreenState extends State<JobListScreen> {

  String searchKey = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backWhiteColor,
        body: Column(
          children: [
            buildAppbar(context),
            buildSearchBar(context),
            buildJobList(context)
          ],
        ),
      ),
    );
  }

  //Design appbar field
  AnimatedOpacity buildAppbar(BuildContext context) {
    return AnimatedOpacity(
      opacity:
      Provider.of<WidgetChange>(context, listen: true).isAppbarShow ? 1 : 0,
      duration: const Duration(milliseconds: 500),
      child: Visibility(
        visible: Provider.of<WidgetChange>(context, listen: true).isAppbarShow,
        child: BaseAppBar(
          appBar: AppBar(),
          title: LabelString.lblJobs,
          titleTextStyle: CustomTextStyle.labelFontText,
          isBack: false,
          searchWidget: Padding(
            padding: EdgeInsets.only(right: 12.sp),
            child: IconButton(
                onPressed: () =>
                    Provider.of<WidgetChange>(context, listen: false)
                        .appbarVisibility(),
                icon: Icon(Icons.search, color: AppColors.blackColor)),
          ),
          backgroundColor: AppColors.backWhiteColor,
        ),
      ),
    );
  }

  //Design search field
  AnimatedOpacity buildSearchBar(BuildContext context) {
    return AnimatedOpacity(
      opacity:
      Provider.of<WidgetChange>(context, listen: true).isAppbarShow ? 0 : 1,
      duration: const Duration(milliseconds: 500),
      child: Visibility(
        visible: Provider.of<WidgetChange>(context, listen: true).isAppbarShow
            ? false
            : true,
        child: Padding(
          padding:
          EdgeInsets.only(right: 24.sp, top: 8.sp, left: 15.sp, bottom: 0),
          child: Padding(
            padding: EdgeInsets.only(bottom: 0.sp),
            child: Row(
              children: [
                InkWell(
                    onTap: () => closeSearchBar(),
                    child: Icon(Icons.arrow_back_ios_rounded,
                        color: AppColors.blackColor)),
                SizedBox(width: 5.w),
                Expanded(
                  child: Consumer<WidgetChange>(
                    builder: (context, updateKey, search){
                      return TextField(
                          onChanged: (value) {
                            Provider.of<WidgetChange>(context, listen: false).updateSearch(value);
                            searchKey = updateKey.updateSearchText.toString();

                            //searchItemList = [];
                            /*for (var element in quoteItems!) {
                              if (element.subject!.toLowerCase().contains(searchKey)) {
                                searchItemList!.add(element);
                              } else if (element.quotesCompany!.toLowerCase().contains(searchKey)) {
                                searchItemList!.add(element);
                              } else if (element.shipStreet!.toLowerCase().contains(searchKey)) {
                                searchItemList!.add(element);
                              } else if (element.shipCode!.toLowerCase().contains(searchKey)) {
                                searchItemList!.add(element);
                              }else if(element.quoteNo!.toLowerCase().contains(searchKey)){
                                searchItemList!.add(element);
                              }else if(element.quotesEmail!.toLowerCase().contains(searchKey)){
                                searchItemList!.add(element);
                              }
                            }*/
                          },
                          keyboardType: TextInputType.text,
                          autofocus: true,
                          decoration: InputDecoration(
                              hintText: LabelString.lblSearch,
                              suffixIcon: Container(
                                  decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(5),
                                          bottomRight: Radius.circular(5))),
                                  child: Icon(Icons.search,
                                      color: AppColors.whiteColor, size: 15.sp)),
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
                              contentPadding:
                              EdgeInsets.only(left: 10.sp, top: 0, bottom: 0)));
                    },

                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AnimationLimiter buildJobList(BuildContext context) {
    return AnimationLimiter(
      child: Expanded(
        child: ListView.separated(
          padding: EdgeInsets.only(top: 10.sp),
          physics: const BouncingScrollPhysics(),
          itemCount: 10,
          itemBuilder: (context, index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              child: SlideAnimation(
                verticalOffset: 50.0,
                curve: Curves.decelerate,
                child: FadeInAnimation(
                  child: Padding(
                    padding: EdgeInsets.only(left: 12.sp, right: 12.sp),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.sp)),
                      elevation: 2,
                      child: InkWell(
                        onTap: () { },
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(12.sp)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 8.sp,
                                horizontal: 15.sp),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 1.0.h),
                                //if Contact name of quote is null then we set subject from the list and remove text after the "-"
                                InkWell(
                                  onTap: (){ },
                                  child: Text.rich(
                                    TextSpan(
                                      text: "Job Title",
                                      style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                              fontSize: 15.sp,
                                              color: AppColors.fontColor,
                                              fontWeight: FontWeight.bold)),
                                      children: [
                                        TextSpan(
                                            text: "",
                                            style: GoogleFonts.roboto(
                                                textStyle: TextStyle(
                                                    fontSize: 13.sp,
                                                    color: AppColors.fontColor,
                                                    fontWeight: FontWeight.bold)))
                                      ],
                                    ),
                                  ),
                                ),

                                SizedBox(height: 2.0.h),
                                Text("Sunrise Enterprise",
                                    style: CustomTextStyle.labelText),
                                SizedBox(height: 0.5.h),
                                Text("1324 N Federal Hwy, Delray Beach, \nFlorida, 33483",
                                    style: CustomTextStyle.labelText),
                                SizedBox(height: 0.5.h),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },

          separatorBuilder: (BuildContext context, int index) {
            return Container(height: 10.sp);
          },
        ),
      ),
    );
  }

  void closeSearchBar() {
    Provider.of<WidgetChange>(context, listen: false).appbarVisibility();
    searchKey = "";
  }


}
