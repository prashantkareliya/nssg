import 'package:flutter/material.dart';
import 'package:nssg/components/custom_textfield.dart';
import 'package:nssg/constants/navigation.dart';
import 'package:nssg/constants/strings.dart';
import 'package:provider/provider.dart';
import '../../components/custom_appbar.dart';
import '../../components/custom_button.dart';
import '../../components/custom_radio_button.dart';
import '../../components/custom_text_styles.dart';
import '../../components/global_api_call.dart';
import '../../components/svg_extension.dart';
import '../../httpl_actions/handle_api_error.dart';
import '../../utils/app_colors.dart';
import 'package:sizer/sizer.dart';

import '../../utils/widgetChange.dart';
import '../../utils/widgets.dart';
import 'add_item_detail.dart';

class BuildItemDetail extends StatefulWidget {
  const BuildItemDetail({super.key});

  @override
  State<BuildItemDetail> createState() => _BuildItemDetailState();
}

class _BuildItemDetailState extends State<BuildItemDetail> {
  List templateOptionList = [LabelString.lblHideProductPrice, LabelString.lblHideProduct, LabelString.lblNone];
  List<RadioModel> templateOption = <RadioModel>[]; //step 1

  TextEditingController sellingPriceController = TextEditingController();
  TextEditingController discountPriceController = TextEditingController();

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
            Padding(
              padding: EdgeInsets.only(left:8.sp),
              child: Text(LabelString.lblTemplateOptions,
                  style: CustomTextStyle.labelText),
            ),
            SizedBox(height: 1.h),
            Padding(
              padding: EdgeInsets.only(left: 12.sp),
              child: Wrap(
                spacing: 3,
                direction: Axis.horizontal,
                children: List.generate(
                  growable: false,
                  templateOptionList.length,
                  (index) {
                    templateOption.add(RadioModel(false, templateOptionList[index]));
                    return SizedBox(
                      height: 6.h,
                      child: InkWell(
                        splashColor: AppColors.transparent,
                        highlightColor: AppColors.transparent,
                        onTap: () {
                          for (var element in templateOption) {
                            element.isSelected = false;
                          }

                          //Provider.of<WidgetChange>(context, listen: false).isTemplateOption();
                          templateOption[index].isSelected = true;
                          //Provider.of<WidgetChange>(context, listen: false).isSelectTemplateOption;
                          setState(() {});
                        },
                        child: RadioItem(templateOption[index]),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: query.height / 1.65,
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
                      child: Padding(
                        padding:
                            EdgeInsets.fromLTRB(12.sp, 10.sp, 10.sp, 10.sp),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 1.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                      text: LabelString.lblItemName,
                                      style: CustomTextStyle.labelFontHintText,
                                      children: [
                                        TextSpan(
                                            text: '\nABCD Item',
                                            style: CustomTextStyle.labelText)
                                      ]),
                                ),
                                Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            ///Make new class for dialog
                                            return Dialog(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                elevation: 0,
                                                insetPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 12.sp),
                                                child: EditItem());
                                          },
                                        );
                                      },
                                      child: Icon(Icons.edit,
                                          color: AppColors.primaryColor,
                                          size: 14.sp),
                                    ),
                                    SizedBox(height: 1.0.h),
                                    Icon(Icons.delete,
                                        color: AppColors.redColor, size: 14.sp)
                                  ],
                                )
                              ],
                            ),
                            SizedBox(height: 1.5.h),
                            Row(
                              children: [
                                Expanded(
                                  child: RichText(
                                    text: TextSpan(
                                        text: LabelString.lblCostPricePound,
                                        style:
                                            CustomTextStyle.labelFontHintText,
                                        children: [
                                          TextSpan(
                                              text: ' : 0',
                                              style: CustomTextStyle.labelText)
                                        ]),
                                  ),
                                ),
                                Expanded(
                                  child: RichText(
                                    textAlign: TextAlign.start,
                                    text: TextSpan(
                                        text: LabelString.lblSellingPricePound,
                                        style:
                                            CustomTextStyle.labelFontHintText,
                                        children: [
                                          TextSpan(
                                              text: ' : 0',
                                              style: CustomTextStyle.labelText)
                                        ]),

                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 1.5.h),
                            Row(
                              children: [
                                Expanded(
                                  child: RichText(
                                    text: TextSpan(
                                        text: "${LabelString.lblQuantity} : ",
                                        style:
                                            CustomTextStyle.labelFontHintText,
                                        children: [
                                          TextSpan(
                                              text: '2',
                                              style: CustomTextStyle.labelText)
                                        ]),
                                  ),
                                ),
                                Expanded(
                                  child: RichText(
                                    text: TextSpan(
                                        text: LabelString.lblDiscountPound,
                                        style:
                                            CustomTextStyle.labelFontHintText,
                                        children: [
                                          TextSpan(
                                              text: ' : 0',
                                              style: CustomTextStyle.labelText)
                                        ]),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 1.5.h),
                            Row(
                              children: [
                                Expanded(
                                  child: RichText(
                                    text: TextSpan(
                                        text: "${LabelString.lblAmount} : ",
                                        style:
                                            CustomTextStyle.labelFontHintText,
                                        children: [
                                          TextSpan(
                                              text: '240.00',
                                              style: CustomTextStyle.labelText)
                                        ]),
                                  ),
                                ),
                                Expanded(
                                  child: RichText(
                                    text: TextSpan(
                                        text: "${LabelString.lblProfit} : ",
                                        style:
                                            CustomTextStyle.labelFontHintText,
                                        children: [
                                          TextSpan(
                                              text: '28',
                                              style: CustomTextStyle.labelText)
                                        ]),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 2.0.h),
                            Text(
                                "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                                style: CustomTextStyle.labelText),
                            SizedBox(height: 1.h),
                          ],
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
          ],
        ),
      ),

      ///bottom sheet design
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
              onTap: () => modelBottomSheetMenu(query),
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

      ///Open add item screen
      ///Make new class and using pageView for add item detail
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            callNextScreen(context, const AddItemDetail());
          },
          child: const Icon(Icons.add)),
    );
  }

  ///Method for open bottom sheet
  ///Design opened bottom sheet
  void modelBottomSheetMenu(Size query) {
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

///Custom class for bottom sheet static design
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



///class for select location dialog
class SelectLocation extends StatelessWidget {
  TextEditingController titleController = TextEditingController();

  SelectLocation({super.key});

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.fromLTRB(10.sp, 0, 10.sp, 15.sp),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
              alignment: Alignment.topRight,
              child: IconButton(
                  highlightColor: AppColors.transparent,
                  splashColor: AppColors.transparent,
                  onPressed: () => Navigator.pop(context),
                  icon:
                      Icon(Icons.close_rounded, color: AppColors.blackColor))),
          CustomTextField(
              keyboardType: TextInputType.name,
              readOnly: false,
              controller: titleController,
              obscureText: false,
              hint: LabelString.lblTitle,
              titleText: LabelString.lblTitle,
              isRequired: false),
          CustomTextField(
              keyboardType: TextInputType.name,
              readOnly: false,
              controller: titleController,
              obscureText: false,
              hint: LabelString.lblLocation,
              titleText: LabelString.lblLocation,
              isRequired: false),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                  width: query.width * 0.4,
                  height: query.height * 0.06,
                  child: BorderButton(
                      btnString: ButtonString.btnCancel,
                      onClick: () => Navigator.pop(context))),
              SizedBox(
                  width: query.width * 0.4,
                  height: query.height * 0.06,
                  child: CustomButton(
                      title: ButtonString.btnSave, onClick: () {})),
            ],
          )
        ],
      ),
    );
  }
}

///Class for edit item
class EditItem extends StatelessWidget {
  EditItem({Key? key}) : super(key: key);

  TextEditingController itemNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.fromLTRB(10.sp, 0, 10.sp, 0.sp),
      child: SizedBox(
        height: query.height / 1.2,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            SizedBox(height: 1.h),
            Align(
                alignment: Alignment.topRight,
                child: InkWell(
                    highlightColor: AppColors.transparent,
                    splashColor: AppColors.transparent,
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.close_rounded,
                        color: AppColors.blackColor))),
            CustomTextField(
              keyboardType: TextInputType.name,
              readOnly: false,
              //controller: titleController,
              obscureText: false,
              hint: LabelString.lbItemName,
              titleText: LabelString.lbItemName,
              isRequired: false,
              controller: itemNameController,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text(LabelString.lblAttachmentDocument,
                      style: CustomTextStyle.commonTextBlue),
                ),
                TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        ///Make new class for dialog
                        return Dialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            elevation: 0,
                            insetPadding:
                                EdgeInsets.symmetric(horizontal: 12.sp),
                            child: SelectLocation());
                      },
                    );
                  },
                  child: Text(LabelString.lblSelectLocation,
                      style: CustomTextStyle.commonTextBlue),
                ),
              ],
            ),
            MultiLineTextField(
                keyboardType: TextInputType.name,
                readOnly: false,
                controller: itemNameController,
                obscureText: false,
                hint: LabelString.lbItemDescription,
                titleText: LabelString.lbItemDescription,
                isRequired: false),
            CustomTextField(
                keyboardType: TextInputType.name,
                readOnly: false,
                controller: itemNameController,
                obscureText: false,
                hint: LabelString.lblCostPricePound,
                titleText: LabelString.lblCostPricePound,
                isRequired: false),
            CustomTextField(
                keyboardType: TextInputType.name,
                readOnly: false,
                controller: itemNameController,
                obscureText: false,
                hint: LabelString.lblSellingPricePound,
                titleText: LabelString.lblSellingPricePound,
                isRequired: false),
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: CustomTextField(
                    keyboardType: TextInputType.name,
                    readOnly: false,
                    //controller: titleController,
                    obscureText: false,
                    hint: LabelString.lblQuantityEdit,
                    titleText: LabelString.lblQuantityEdit,
                    isRequired: false,
                    controller: itemNameController,
                  ),
                ),
                SizedBox(width: 3.w),
                Flexible(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.sp),
                        color: AppColors.primaryColor),
                    child: Padding(
                      padding: EdgeInsets.all(8.sp),
                      child: Icon(Icons.remove, color: AppColors.whiteColor),
                    ),
                  ),
                ),
                SizedBox(width: 3.w),
                Flexible(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.sp),
                        color: AppColors.primaryColor),
                    child: Padding(
                      padding: EdgeInsets.all(8.sp),
                      child: Icon(Icons.add, color: AppColors.whiteColor),
                    ),
                  ),
                ),
              ],
            ),
            CustomTextField(
                keyboardType: TextInputType.name,
                readOnly: false,
                controller: itemNameController,
                obscureText: false,
                hint: LabelString.lblDiscountPound,
                titleText: LabelString.lblDiscountPound,
                isRequired: false),
            Row(
              children: [
                Expanded(
                  child: RichText(
                    text: TextSpan(
                        text: "${LabelString.lblAmount} : ",
                        style: CustomTextStyle.labelFontHintText,
                        children: [
                          TextSpan(
                              text: '240.00', style: CustomTextStyle.labelText)
                        ]),
                  ),
                ),
                Expanded(
                  child: RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                        text: "${LabelString.lblProfit} : ",
                        style: CustomTextStyle.labelFontHintText,
                        children: [
                          TextSpan(
                              text: '28.00', style: CustomTextStyle.labelText)
                        ]),
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h),
            SizedBox(
                width: query.width,
                height: query.height * 0.06,
                child: CustomButton(
                    title: ButtonString.btnAddProduct, onClick: () {})),
            SizedBox(height: 1.h),
          ],
        ),
      ),
    );
  }
}
