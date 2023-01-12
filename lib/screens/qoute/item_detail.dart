import 'package:flutter/material.dart';
import 'package:nssg/components/custom_textfield.dart';
import 'package:nssg/constants/navigation.dart';
import 'package:nssg/constants/strings.dart';

import '../../components/custom_appbar.dart';
import '../../components/custom_button.dart';
import '../../components/custom_text_styles.dart';
import '../../utils/app_colors.dart';
import 'package:sizer/sizer.dart';

class BuildItemDetail extends StatefulWidget {
  const BuildItemDetail({Key? key}) : super(key: key);

  @override
  State<BuildItemDetail> createState() => _BuildItemDetailState();
}

class _BuildItemDetailState extends State<BuildItemDetail> {
  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.backWhiteColor,
      appBar: BaseAppBar(
        appBar: AppBar(),
        title: LabelString.lblItemDetail,
        isBack: true,
        elevation: 1,
        backgroundColor: AppColors.whiteColor,
        searchWidget: Container(),
        titleTextStyle: CustomTextStyle.labelBoldFontText,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 5.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(LabelString.lblTemplateOptions,
                style: CustomTextStyle.labelText),
            SizedBox(height: 1.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton(
                  title: LabelString.lblHideProductPrice,
                  buttonColor: AppColors.primaryColor,
                  onClick: () {},
                ),
                SizedBox(
                  child: TextButton(
                      style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(
                              AppColors.primaryColor),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: BorderSide(
                                          color: AppColors.primaryColor,
                                          width: 2)))),
                      onPressed: () {},
                      child: Text(LabelString.lblHideProduct,
                          style: CustomTextStyle.labelFontText)),
                ),
                SizedBox(
                  child: TextButton(
                      style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(
                              AppColors.primaryColor),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: BorderSide(
                                          color: AppColors.primaryColor,
                                          width: 2)))),
                      onPressed: () {},
                      child: Text(LabelString.lblNone,
                          style: CustomTextStyle.labelFontText)),
                ),
              ],
            ),
            Expanded(
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(left: 12.sp, right: 12.sp),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.sp),
                      ),
                      elevation: 3,
                      child: Container(height: query.height / 3.0),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Container(height: 10.sp);
                },
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        width: query.width,
        height: query.height * 0.15,
        decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(15.sp),
                topLeft: Radius.circular(15.sp))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () => modalBottomSheetMenu(query),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(LabelString.lblShowAmount,
                      style: CustomTextStyle.labelBoldFontText),
                  SizedBox(width: 3.w),
                  Image.asset(
                    ImageString.icShowAmount,
                    height: 2.h,
                  )
                ],
              ),
            ),
            SizedBox(
              width: query.width * 0.8,
              height: query.height * 0.06,
              child: CustomButton(
                title: ButtonString.btnSubmit,
                buttonColor: AppColors.primaryColor,
                onClick: () {},
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            callNextScreen(context, const AddItemDetail());
          },
          child: const Icon(Icons.add)),
    );
  }

  void modalBottomSheetMenu(Size query) {
    showModalBottomSheet(
        backgroundColor: AppColors.transparent,
        enableDrag: false,
        isDismissible: false,
        context: context,
        builder: (builder) {
          return Container(
            height: query.height * 0.45,
            color: Colors.transparent, //could change this to Color(0xFF737373),
            //so you don't have to change MaterialApp canvasColor
            child: Container(
                decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.sp),
                        topRight: Radius.circular(15.sp))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.sp),
                      child: InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(LabelString.lblShowAmount,
                                style: CustomTextStyle.labelBoldFontText),
                            SizedBox(width: 3.w),
                            Image.asset(
                              ImageString.icHideAmount,
                              height: 2.h,
                            )
                          ],
                        ),
                      ),
                    ),
                    BottomSheetData("Discount Amount", "0.00"),
                    BottomSheetData("Sub Total", "0"),
                    BottomSheetData("Items Total", "0"),
                    BottomSheetData("Vat Total", "0.00"),
                    BottomSheetData("Deposit Amount", "0.00"),
                    BottomSheetData("Grand Total", "0"),
                    BottomSheetData("Total Profit", "0"),
                    SizedBox(
                      width: query.width * 0.8,
                      height: query.height * 0.06,
                      child: CustomButton(
                        title: ButtonString.btnSubmit,
                        buttonColor: AppColors.primaryColor,
                        onClick: () => Navigator.pop(context),
                      ),
                    )
                  ],
                )),
          );
        });
  }
}

class BottomSheetData extends StatelessWidget {
  String? keyText;
  String? valueText;

  BottomSheetData(this.keyText, this.valueText, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(keyText!),
          Text(valueText!),
        ],
      ),
    );
  }
}

class AddItemDetail extends StatefulWidget {
  const AddItemDetail({Key? key}) : super(key: key);

  @override
  State<AddItemDetail> createState() => _AddItemDetailState();
}

class _AddItemDetailState extends State<AddItemDetail> {
  PageController pageController = PageController();

  TextEditingController sellingPriceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: BaseAppBar(
        appBar: AppBar(),
        title: LabelString.lblItemDetail,
        isBack: true,
        elevation: 1,
        backgroundColor: AppColors.whiteColor,
        searchWidget: Container(),
        titleTextStyle: CustomTextStyle.labelBoldFontText,
      ),
      body: PageView(
        scrollDirection: Axis.horizontal,
        pageSnapping: true,
        physics: const BouncingScrollPhysics(),
        controller: pageController,
        onPageChanged: (number) {},
        children: [
          buildStepOne(query),
          buildStepTwo(query),
          buildStepThree(query)
        ],
      ),
    );
  }

  Column buildStepOne(Size query) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16.sp),
          child: Text(LabelString.lblCategory,
              style: CustomTextStyle.labelBoldFontText),
        ),
        Wrap(
          spacing: 15.sp,
          direction: Axis.horizontal,
          alignment: WrapAlignment.center,
          runSpacing: 14.sp,
          children: List.generate(
            2,
            (index) {
              return Container(
                height: 16.h,
                width: query.width / 1.13,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.borderColor, width: 2),
                    borderRadius: BorderRadius.circular(10.0)),
                child: InkWell(
                  splashColor: AppColors.transparent,
                  highlightColor: AppColors.transparent,
                  onTap: () {},
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.lock_outline,
                            color: AppColors.primaryColor, size: 30.sp),
                        SizedBox(height: 1.h),
                        Text("Ajax",
                            textAlign: TextAlign.center,
                            style: CustomTextStyle.labelFontText)
                      ]),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Column buildStepTwo(Size query) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16.sp),
          child: Text(LabelString.lblSubCategory,
              style: CustomTextStyle.labelBoldFontText),
        ),
        Wrap(
          spacing: 15.sp,
          direction: Axis.horizontal,
          alignment: WrapAlignment.center,
          runSpacing: 14.sp,
          children: List.generate(
            2,
            (index) {
              return Container(
                height: 16.h,
                width: query.width / 1.13,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.borderColor, width: 2),
                    borderRadius: BorderRadius.circular(10.0)),
                child: InkWell(
                  splashColor: AppColors.transparent,
                  highlightColor: AppColors.transparent,
                  onTap: () {},
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.local_fire_department_outlined,
                            color: AppColors.primaryColor, size: 30.sp),
                        SizedBox(height: 1.h),
                        Text("Fire Detection",
                            textAlign: TextAlign.center,
                            style: CustomTextStyle.labelFontText)
                      ]),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  buildStepThree(Size query) {
    return Column(
      children: [
        SizedBox(height: 3.h),
        Expanded(
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemCount: 5,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(left: 12.sp, right: 12.sp),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.sp),
                      border:
                          Border.all(color: AppColors.borderColor, width: 1),
                      color: AppColors.whiteColor),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: Image.asset("assets/images/demo.png", height: 15.h)),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text("AJAX SMOKE",style: CustomTextStyle.labelBoldFontText),
                                  Text("AJAX SMOKE",style: TextStyle(color: AppColors.transparent)),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(LabelString.lblCostPrice,style: CustomTextStyle.commonText),
                                  Text("\$ 29.50",style: CustomTextStyle.labelBoldFontTextSmall),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                children: [
                                  Text(LabelString.lblSellingPrice,style: CustomTextStyle.commonText),

                                ],
                              ),
                              Text(LabelString.lblDiscPrice,style: CustomTextStyle.commonText),
                              Text(LabelString.lblAmount,style: CustomTextStyle.commonText),
                              Text(LabelString.lblProfit,style: CustomTextStyle.commonText),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.sp,vertical: 5.sp),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(LabelString.lblAttachmentDocument,
                                    style: CustomTextStyle.commonTextBlue),
                                Text(LabelString.lblSelectLocation,
                                    style: CustomTextStyle.commonTextBlue),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.sp,vertical: 5.sp),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    height: query.height * 0.06,
                                    child: CustomButton(
                                        title: "Add to Cart",
                                        buttonColor: AppColors.primaryColor,
                                        onClick: () {}),
                                  ),
                                ),
                                SizedBox(width: 5.w),
                                Expanded(
                                  child: SizedBox(
                                    height: query.height * 0.06,
                                    child: CustomButton(
                                        title: "Add to Cart",
                                        buttonColor: AppColors.primaryColor,
                                        onClick: () {}),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Container(height: 10.sp);
            },
          ),
        ),
      ],
    );
  }
}
