import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nssg/components/global_api_call.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:sizer/sizer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../components/custom_appbar.dart';
import '../../components/custom_text_styles.dart';
import '../../constants/constants.dart';
import '../../constants/strings.dart';
import '../../httpl_actions/app_http.dart';
import '../../httpl_actions/handle_api_error.dart';
import '../../utils/app_colors.dart';
import '../../utils/widgetChange.dart';
import '../../utils/widgets.dart';
import 'quote_type_selection_screen.dart';

class ContractListScreen extends StatefulWidget {
  const ContractListScreen({Key? key}) : super(key: key);

  @override
  State<ContractListScreen> createState() => _ContractListScreenState();
}

class _ContractListScreenState extends State<ContractListScreen> {
  Future<dynamic>? getDetail;

  List contractList = [];
  List searchItemList = [];
  String searchKey = "";

  @override
  Widget build(BuildContext context) {
    getDetail = getData();
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backWhiteColor,
        body: FutureBuilder<dynamic>(
            future: getDetail,
            builder: (context, snapshot) {
              return Column(
                children: [
                  buildAppbar(context),
                  buildSearchBar(context, snapshot.data),
                  if (snapshot.hasData)
                    buildJobList(context, snapshot.data)
                  else if (snapshot.hasError)
                    Text(HandleAPI.handleAPIError(snapshot.error))
                  else
                    SizedBox(height: 70.h, child: loadingView())
                ],
              );
            }),
      ),
    );
  }

  //Design appbar field
  AnimatedOpacity buildAppbar(BuildContext context) {
    return AnimatedOpacity(
      opacity:
          Provider.of<WidgetChange>(context, listen: true).isAppbarShow ? 0 : 0,
      duration: const Duration(milliseconds: 500),
      // child: Visibility(
      //   visible: Provider.of<WidgetChange>(context, listen: true).isAppbarShow,
      //   child: BaseAppBar(
      //     appBar: AppBar(),
      //     title: "",
      //     titleTextStyle: CustomTextStyle.labelFontText,
      //     isBack: false,
      //     searchWidget: Padding(
      //       padding: EdgeInsets.only(right: 12.sp),
      //       child: IconButton(
      //           onPressed: () =>
      //               Provider.of<WidgetChange>(context, listen: false)
      //                   .appbarVisibility(),
      //           icon: Icon(Icons.search, color: AppColors.blackColor)),
      //     ),
      //     backgroundColor: AppColors.backWhiteColor,
      //   ),
      // ),
    );
  }

  //Design search field
  AnimatedOpacity buildSearchBar(BuildContext context, contractData) {
    return AnimatedOpacity(
      opacity:
          Provider.of<WidgetChange>(context, listen: true).isAppbarShow ? 1 : 1,
      duration: const Duration(milliseconds: 500),
      child: Visibility(
        visible: Provider.of<WidgetChange>(context, listen: true).isAppbarShow
            ? true
            : true,
        child: Padding(
          padding:
              EdgeInsets.only(right: 18.sp, top: 9.sp, left: 18.sp, bottom: 7),
          child: Padding(
            padding: EdgeInsets.only(bottom: 0.sp),
            child: Row(
              children: [
                // InkWell(
                //     onTap: () => closeSearchBar(),
                //     child: Icon(Icons.arrow_back_ios_rounded,
                //         color: AppColors.blackColor)),
                // SizedBox(width: 5.w),
                Expanded(
                  child: Consumer<WidgetChange>(
                    builder: (context, updateKey, search) {
                      return TextField(
                          onChanged: (value) {
                            Provider.of<WidgetChange>(context, listen: false)
                                .updateSearch(value);
                            searchKey = updateKey.updateSearchText.toString();
                            searchItemList = [];

                            for (var element in contractList) {
                              if (element["subject"]!
                                  .toLowerCase()
                                  .contains(searchKey.toLowerCase())) {
                                searchItemList.add(element);
                              } else if (element["contract_no"]!
                                  .toLowerCase()
                                  .contains(searchKey)) {
                                searchItemList.add(element);
                              } else if (element["email"]
                                  .toLowerCase()
                                  .contains(searchKey)) {
                                searchItemList.add(element);
                              } else if (element["ser_con_inv_address"]
                                  .toLowerCase()
                                  .contains(searchKey)) {
                                searchItemList.add(element);
                              } else if (element["ser_con_inv_city"]
                                  .toLowerCase()
                                  .contains(searchKey)) {
                                searchItemList.add(element);
                              } else if (element["ser_con_inv_country"]
                                  .toLowerCase()
                                  .contains(searchKey)) {
                                searchItemList.add(element);
                              } else if (element["ser_con_inv_postcode"]
                                  .toLowerCase()
                                  .contains(searchKey)) {
                                searchItemList.add(element);
                              }
                            }
                          },
                          style: TextStyle(fontSize: 16.sp),
                          keyboardType: TextInputType.text,
                          autofocus: false,
                          decoration: InputDecoration(
                              hintText: LabelString.lblSearch,
                              hintStyle: TextStyle(fontSize: 16.sp),
                              suffixIcon: Container(
                                  decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(5),
                                          bottomRight: Radius.circular(5))),
                                  child: Icon(Icons.search,
                                      color: AppColors.whiteColor,
                                      size: 20.sp)),
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
                              contentPadding: EdgeInsets.only(
                                  left: 10.sp, top: 0, bottom: 0)));
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

  AnimationLimiter buildJobList(BuildContext context, contractData) {
    contractList = contractData["result"];
    return AnimationLimiter(
        child: Expanded(
            child: ListView.separated(
                padding: EdgeInsets.only(top: 10.sp),
                physics: const BouncingScrollPhysics(),
                itemCount: searchKey.isNotEmpty
                    ? searchItemList.length
                    : contractList.length,
                itemBuilder: (context, index) {
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    child: SlideAnimation(
                      verticalOffset: 50.0,
                      curve: Curves.decelerate,
                      child: FadeInAnimation(
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 19.sp, right: 19.sp, bottom: 5.sp),
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.circular(12.sp),
                                  ),
                                ),
                              ),
                              Slidable(
                                enabled: false,
                                endActionPane: ActionPane(
                                  extentRatio: 0.15,
                                  motion: const ScrollMotion(),
                                  children: [
                                    CustomSlidableAction(
                                      borderRadius: const BorderRadius.only(
                                          bottomRight: Radius.circular(20.0),
                                          topRight: Radius.circular(20.0)),
                                      padding: EdgeInsets.zero,
                                      autoClose: true,
                                      onPressed: (value) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    QuoteTypeSelection(
                                                        contractList: searchKey
                                                                .isNotEmpty
                                                            ? searchItemList[
                                                                index]
                                                            : contractList[
                                                                index])));
                                      },
                                      backgroundColor: AppColors.primaryColor,
                                      foregroundColor: AppColors.redColor,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          RotatedBox(
                                              quarterTurns: -1,
                                              child: Text(
                                                  textAlign: TextAlign.center,
                                                  ButtonString.btnCreateQuote,
                                                  style: GoogleFonts.roboto(
                                                      textStyle:
                                                          const TextStyle(
                                                              color: Colors
                                                                  .white)))),
                                          SizedBox(height: 0.8.h),
                                          const Icon(Icons.add_circle_outline,
                                              color: Colors.white),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(12.sp)),
                                  margin: EdgeInsets.zero,
                                  elevation: 2,
                                  child: InkWell(
                                    onTap: () {},
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          color: AppColors.whiteColor,
                                          borderRadius:
                                              BorderRadius.circular(12.sp)),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8.sp, horizontal: 15.sp),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 1.0.h),
                                            //if Contact name of quote is null then we set subject from the list and remove text after the "-"
                                            InkWell(
                                              onTap: () {},
                                              child: Text.rich(
                                                TextSpan(
                                                  text: "",
                                                  style: GoogleFonts.roboto(
                                                      textStyle: TextStyle(
                                                          fontSize: 18.sp,
                                                          color: AppColors
                                                              .fontColor,
                                                          fontWeight:
                                                              FontWeight.w500)),
                                                  children: [
                                                    TextSpan(
                                                      text: searchKey.isNotEmpty
                                                          ? searchItemList[
                                                              index]["subject"]
                                                          : contractList[index]
                                                              ["subject"],
                                                      style: GoogleFonts.roboto(
                                                          textStyle: TextStyle(
                                                              fontSize: 18.sp,
                                                              color: AppColors
                                                                  .fontColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),

                                            SizedBox(height: 10.h),
                                            Text(
                                                searchKey.isNotEmpty
                                                    ? searchItemList[index]
                                                        ["contract_no"]
                                                    : contractList[index]
                                                        ["contract_no"],
                                                style:
                                                    CustomTextStyle.labelText),
                                            SizedBox(height: 10.h),
                                            Text.rich(
                                              TextSpan(
                                                text: searchKey.isNotEmpty
                                                    ? searchItemList[index]
                                                        ["ser_con_inv_address"]
                                                    : contractList[index][
                                                            "ser_con_inv_address"] ??
                                                        "",
                                                style:
                                                    CustomTextStyle.labelText,
                                                children: [
                                                  if (contractList[index][
                                                              "ser_con_inv_address"] !=
                                                          "" &&
                                                      contractList[index][
                                                              "ser_con_inv_address"] !=
                                                          null)
                                                    const TextSpan(text: ", "),
                                                  TextSpan(
                                                      text: searchKey.isNotEmpty
                                                          ? searchItemList[
                                                                  index][
                                                              "ser_con_inv_city"]
                                                          : contractList[index][
                                                                  "ser_con_inv_city"] ??
                                                              "",
                                                      style: CustomTextStyle
                                                          .labelText),
                                                  if (contractList[index][
                                                              "ser_con_inv_city"] !=
                                                          "" &&
                                                      contractList[index][
                                                              "ser_con_inv_city"] !=
                                                          null)
                                                    const TextSpan(text: ", "),
                                                  TextSpan(
                                                      text: searchKey.isNotEmpty
                                                          ? searchItemList[
                                                                  index][
                                                              "ser_con_inv_country"]
                                                          : contractList[index][
                                                                  "ser_con_inv_country"] ??
                                                              "",
                                                      style: CustomTextStyle
                                                          .labelText),
                                                  if (contractList[index][
                                                              "ser_con_inv_country"] !=
                                                          "" &&
                                                      contractList[index][
                                                              "ser_con_inv_country"] !=
                                                          null)
                                                    const TextSpan(text: ", "),
                                                  TextSpan(
                                                      text: searchKey.isNotEmpty
                                                          ? searchItemList[
                                                                  index][
                                                              "ser_con_inv_postcode"]
                                                          : contractList[index][
                                                                  "ser_con_inv_postcode"] ??
                                                              "",
                                                      style: CustomTextStyle
                                                          .labelText)
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 0.5.h),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Container(height: 10.sp);
                })));
  }

  void closeSearchBar() {
    Provider.of<WidgetChange>(context, listen: false).appbarVisibility();
    searchKey = "";
  }
}
