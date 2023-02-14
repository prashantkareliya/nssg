import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nssg/components/custom_textfield.dart';
import 'package:nssg/constants/navigation.dart';
import 'package:nssg/constants/strings.dart';
import 'package:nssg/screens/qoute/bloc/product_list_bloc.dart';
import 'package:nssg/screens/qoute/models/products_list.dart';
import 'package:provider/provider.dart';
import '../../components/custom_appbar.dart';
import '../../components/custom_button.dart';
import '../../components/custom_radio_button.dart';
import '../../components/custom_text_styles.dart';
import '../../utils/app_colors.dart';
import 'package:sizer/sizer.dart';

import '../../utils/widgetChange.dart';
import 'add_item_detail.dart';
import 'package:collection/collection.dart';

// List products = [];

class BuildItemDetail extends StatefulWidget {
  var eAmount;
  String? systemTypeSelect;

  String? quotePaymentSelection;

  BuildItemDetail(this.eAmount, this.systemTypeSelect, this.quotePaymentSelection, {super.key});

  @override
  State<BuildItemDetail> createState() => _BuildItemDetailState();
}

class _BuildItemDetailState extends State<BuildItemDetail> {
  List templateOptionList = [
    LabelString.lblHideProductPrice,
    LabelString.lblHideProduct,
    LabelString.lblNone
  ];
  List<RadioModel> templateOption = <RadioModel>[]; //step 1

  TextEditingController sellingPriceController = TextEditingController();
  TextEditingController discountPriceController = TextEditingController();

  var total = 0;

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    var profit = (double.parse(widget.eAmount) - 80.0)
        .toString()
        .replaceAll(".0", ".00");
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
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 8.sp),
              child: Text(LabelString.lblTemplateOptions,
                  style: CustomTextStyle.labelText),
            ),
            SizedBox(height: 1.h),

            //Template opation design
            Padding(
              padding: EdgeInsets.only(left: 12.sp),
              child: Wrap(
                spacing: 3,
                direction: Axis.horizontal,
                children: List.generate(
                  growable: false,
                  templateOptionList.length,
                  (index) {
                    templateOption
                        .add(RadioModel(false, templateOptionList[index]));
                    Provider.of<WidgetChange>(context).isSelectTemplateOption;
                    return SizedBox(
                      height: 6.h,
                      child: InkWell(
                        splashColor: AppColors.transparent,
                        highlightColor: AppColors.transparent,
                        onTap: () {
                          for (var element in templateOption) {
                            element.isSelected = false;
                          }
                          Provider.of<WidgetChange>(context, listen: false)
                              .isTemplateOption();
                          templateOption[index].isSelected = true;
                        },
                        child: RadioItem(templateOption[index]),
                      ),
                    );
                  },
                ),
              ),
            ),


            Padding(
              padding: EdgeInsets.only(left: 12.sp, right: 12.sp),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.sp),
                ),
                elevation: 3,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(12.sp, 10.sp, 10.sp, 10.sp),
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
                                      text: '\nInstallation (1st & 2nd fix)',
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
                                                borderRadius: BorderRadius.circular(10)),
                                            elevation: 0,
                                            insetPadding: EdgeInsets.symmetric(
                                                horizontal: 12.sp),
                                            child: EditItem('Installation (1st & 2nd fix)','80.00',widget.eAmount, '1', widget.eAmount, profit, "0"));
                                      },
                                    );
                                  },
                                  child: Image.asset(ImageString.icEdit,
                                      height: 2.5.h)
                                /*Icon(Icons.edit,
                                            color: AppColors.primaryColor,
                                            size: 14.sp),*/
                              ),
                              SizedBox(height: 1.5.h),
                              Image.asset(ImageString.icDelete, height: 2.5.h)
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
                                  style: CustomTextStyle.labelFontHintText,
                                  children: [
                                    TextSpan(
                                        text: '\n80.00',
                                        style: CustomTextStyle.labelText)
                                  ]),
                            ),
                          ),
                          Expanded(
                            child: RichText(
                              textAlign: TextAlign.start,
                              text: TextSpan(
                                  text: LabelString.lblSellingPricePound,
                                  style: CustomTextStyle.labelFontHintText,
                                  children: [
                                    TextSpan(
                                        text: "\n${widget.eAmount}",
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
                                  style: CustomTextStyle.labelFontHintText,
                                  children: [
                                    TextSpan(
                                        text: '1',
                                        style: CustomTextStyle.labelText)
                                  ]),
                            ),
                          ),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                  text: LabelString.lblDiscountPound,
                                  style: CustomTextStyle.labelFontHintText,
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
                                  style: CustomTextStyle.labelFontHintText,
                                  children: [
                                    TextSpan(
                                        text: '${widget.eAmount}',
                                        style: CustomTextStyle.labelText)
                                  ]),
                            ),
                          ),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                  text: "${LabelString.lblProfit} : ",
                                  style: CustomTextStyle.labelFontHintText,
                                  children: [
                                    TextSpan(
                                        text: profit.toString(),
                                        style: CustomTextStyle.labelText)
                                  ]),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 2.0.h),
                      Text(
                          "Installation of all devices, commission and handover Monday - Friday 8.00am - 5.00pm",
                          style: CustomTextStyle.labelText),
                      SizedBox(height: 1.h),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.sp),
            //item list
            BlocConsumer<ProductListBloc, ProductListState>(
              listener: (context, state) {},
              builder: (context, state) {
                return SizedBox(
                  height: query.height/3.7,
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: state.productList.length,
                    itemBuilder: (context, index) {
                      ProductsList products = state.productList[index];

                      double total = 0.0;

                      print(jsonEncode(products));
                      for (var element in state.productList) {
                         total += num.parse(products.amountPrice.toString());
                      }

                      print("********************************* $total");
                      // profit calculation
                      //var profit = (double.parse(widget.eAmount) - 80.0).toString().replaceAll(".0", ".00");
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                          text: LabelString.lblItemName,
                                          style:
                                              CustomTextStyle.labelFontHintText,
                                          children: [
                                            TextSpan(
                                                text: "\n${products.itemName}",
                                                style:
                                                    CustomTextStyle.labelText)
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
                                                      shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10)),
                                                      elevation: 0,
                                                      insetPadding: EdgeInsets.symmetric(horizontal: 12.sp),
                                                      child: EditItem(products.itemName, products.costPrice, products.sellingPrice, products.quantity, products.amountPrice, products.profit, products.discountPrice));
                                                },
                                              );
                                            },
                                            child: Image.asset(ImageString.icEdit, height: 2.5.h)
                                            /*Icon(Icons.edit,
                                                        color: AppColors.primaryColor,
                                                        size: 14.sp),*/
                                            ),
                                        SizedBox(height: 1.5.h),
                                        InkWell(
                                          onTap: () => state.productList.removeAt(index),
                                          child: Image.asset(ImageString.icDelete, height: 2.5.h),
                                        )
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
                                            style: CustomTextStyle
                                                .labelFontHintText,
                                            children: [
                                              TextSpan(
                                                  text:
                                                      '\n${products.costPrice}',
                                                  style:
                                                      CustomTextStyle.labelText)
                                            ]),
                                      ),
                                    ),
                                    Expanded(
                                      child: RichText(
                                        textAlign: TextAlign.start,
                                        text: TextSpan(
                                            text: LabelString.lblSellingPricePound,
                                            style: CustomTextStyle
                                                .labelFontHintText,
                                            children: [
                                              TextSpan(
                                                  text:
                                                      "\n${double.parse(products.sellingPrice.toString())}",
                                                  style:
                                                      CustomTextStyle.labelText)
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
                                            text:
                                                "${LabelString.lblQuantity} : ",
                                            style: CustomTextStyle
                                                .labelFontHintText,
                                            children: [
                                              TextSpan(
                                                  text: '${products.quantity ?? "1"}',
                                                  style:
                                                      CustomTextStyle.labelText)
                                            ]),
                                      ),
                                    ),
                                    Expanded(
                                      child: RichText(
                                        text: TextSpan(
                                            text: LabelString.lblDiscountPound,
                                            style: CustomTextStyle
                                                .labelFontHintText,
                                            children: [
                                              TextSpan(
                                                  text: products.discountPrice,
                                                  style:
                                                      CustomTextStyle.labelText)
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
                                            style: CustomTextStyle
                                                .labelFontHintText,
                                            children: [
                                              TextSpan(
                                                  text: products.amountPrice
                                                      .toString()
                                                      .substring(0, 5),
                                                  style:
                                                      CustomTextStyle.labelText)
                                            ]),
                                      ),
                                    ),
                                    Expanded(
                                      child: RichText(
                                        text: TextSpan(
                                            text: "${LabelString.lblProfit} : ",
                                            style: CustomTextStyle
                                                .labelFontHintText,
                                            children: [
                                              TextSpan(
                                                  text: products.profit.toString().substring(0, 5),
                                                  style:
                                                      CustomTextStyle.labelText)
                                            ]),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 2.0.h),
                                Text(
                                    "Installation of all devices, commission and handover Monday - Friday 8.00am - 5.00pm",
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
                );
              },
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
                  //TODO: Same operation on submit button
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
            callNextScreen(context, AddItemDetail(widget.systemTypeSelect));
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
                    BottomSheetData(
                        "Sub Total", "0", CustomTextStyle.labelText),
                    BottomSheetData(
                        "Discount Amount", "0.00", CustomTextStyle.labelText),

                    BottomSheetData(
                        "Items Total", "0", CustomTextStyle.labelText),
                    BottomSheetData(
                        "Vat Total", "0.00", CustomTextStyle.labelText),
                    widget.quotePaymentSelection == "No deposit" ? Container() :
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14.sp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Deposit Amount", style: CustomTextStyle.labelText),
                          Container(
                            height: 4.h,
                            width: 20.w,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1,
                                    color:
                                    AppColors.primaryColor),
                                color: AppColors.whiteColor,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(5.sp))),
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(
                                    3.sp, 0, 3.sp, 0),
                                child: TextField(
                                  controller:
                                  sellingPriceController,
                                  keyboardType:
                                  TextInputType.number,
                                  decoration: InputDecoration.collapsed(
                                      hintText: "Deposit",
                                      hintStyle: CustomTextStyle.labelFontHintText),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    BottomSheetData(
                        "Grand Total", "0", CustomTextStyle.labelText),
                    BottomSheetData(
                        "Total Profit", "0", CustomTextStyle.labelText),
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
  TextStyle? textStyle;

  BottomSheetData(this.keyText, this.valueText, this.textStyle, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(keyText!, style: textStyle),
          Text(valueText!, style: textStyle),
        ],
      ),
    );
  }
}

///class for select location dialog
class SelectLocation extends StatelessWidget {
  TextEditingController titleController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  var quantity;

  SelectLocation(this.quantity, {super.key});

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.fromLTRB(10.sp, 0, 10.sp, 15.sp),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
                alignment: Alignment.topRight,
                child: IconButton(
                    highlightColor: AppColors.transparent,
                    splashColor: AppColors.transparent,
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.close_rounded,
                        color: AppColors.blackColor))),
            SizedBox(
              height: quantity == 1 ? query.height / 4 : query.height / 2,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: quantity,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        CustomTextField(
                          keyboardType: TextInputType.name,
                          readOnly: false,
                          controller: titleController,
                          obscureText: false,
                          hint: "${LabelString.lblTitle} ${index + 1}",
                          titleText: LabelString.lblTitle,
                          isRequired: false,
                          maxLines: 1,
                          minLines: 1,
                          textInputAction: TextInputAction.next,
                        ),
                        CustomTextField(
                            keyboardType: TextInputType.name,
                            readOnly: false,
                            controller: locationController,
                            obscureText: false,
                            hint: "${LabelString.lblLocation} ${index + 1}",
                            titleText: LabelString.lblLocation,
                            isRequired: false,
                            maxLines: 1,
                            minLines: 1,
                            textInputAction: TextInputAction.next),
                      ],
                    );
                  }),
            ),
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
      ),
    );
  }
}

///Class for edit item
class EditItem extends StatefulWidget {
  var itemName;
  var costPrice;
  var sellingPrice;
  var quantity;
  var amountPrice;
  var profit;
  var discountPrice;



  EditItem(this.itemName, this.costPrice, this.sellingPrice, this.quantity, this.amountPrice, this.profit, this.discountPrice, {Key? key}) : super(key: key);

  @override
  State<EditItem> createState() => _EditItemState();
}

class _EditItemState extends State<EditItem> {
  TextEditingController itemNameController = TextEditingController();
  TextEditingController itemDescriptionController = TextEditingController(text: 'Installation of all devices, commission and handover Monday - Friday 8.00am - 5.00pm');
  TextEditingController itemCostPriceController = TextEditingController();
  TextEditingController itemSellingPriceController = TextEditingController();
  TextEditingController itemQuantityController = TextEditingController();
  TextEditingController itemDiscountController = TextEditingController();

  int? quantity = 1;

  @override
  void initState() {
    super.initState();
    itemNameController.text = widget.itemName.toString();
    itemCostPriceController.text = widget.costPrice.toString();
    itemSellingPriceController.text = (double.parse(widget.sellingPrice)).toString();
    itemQuantityController.text = widget.quantity.toString();
    itemDiscountController.text = widget.discountPrice.toString();
  }

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    dynamic amount = (double.parse(widget.sellingPrice.toString()) * double.parse(quantity.toString())-double.parse(itemDiscountController.text=="" ? "0" : itemDiscountController.text));
    dynamic profit = ((double.parse(widget.sellingPrice.toString())-double.parse(widget.costPrice.toString()))*(quantity!)-double.parse(itemDiscountController.text=="" ? "0" : itemDiscountController.text));
    quantity = int.parse(widget.quantity.toString());

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
              obscureText: false,
              hint: LabelString.lbItemName,
              titleText: LabelString.lbItemName,
              isRequired: false,
              controller: itemNameController,
              maxLines: 1,
              minLines: 1,
              textInputAction: TextInputAction.next,
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
                      barrierDismissible: false,
                      builder: (context) {
                        ///Make new class for dialog
                        return Dialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            elevation: 0,
                            insetPadding:
                                EdgeInsets.symmetric(horizontal: 12.sp),
                            child: SelectLocation(quantity));
                      },
                    );
                  },
                  child: Text(LabelString.lblSelectLocation,
                      style: CustomTextStyle.commonTextBlue),
                ),
              ],
            ),
            CustomTextField(
                keyboardType: TextInputType.name,
                readOnly: false,
                controller: itemDescriptionController,
                obscureText: false,
                hint: LabelString.lbItemDescription,
                titleText: LabelString.lbItemDescription,
                minLines: 1,
                maxLines: 4,
                textInputAction: TextInputAction.none,
                isRequired: false),
            CustomTextField(
              keyboardType: TextInputType.number,
              readOnly: false,
              controller: itemCostPriceController,
              obscureText: false,
              hint: LabelString.lblCostPricePound,
              titleText: LabelString.lblCostPricePound,
              isRequired: false,
              maxLines: 1,
              minLines: 1,
              textInputAction: TextInputAction.next,
            ),
            CustomTextField(
                keyboardType: TextInputType.number,
                readOnly: false,
                controller: itemSellingPriceController,
                obscureText: false,
                hint: LabelString.lblSellingPricePound,
                titleText: LabelString.lblSellingPricePound,
                isRequired: false),
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: CustomTextField(
                      keyboardType: TextInputType.number,
                      readOnly: true,
                      controller: itemQuantityController,
                      obscureText: false,
                      hint: LabelString.lblQuantityEdit,
                      titleText: LabelString.lblQuantityEdit,
                      isRequired: false),
                ),
                SizedBox(width: 3.w),
                Flexible(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                      if (quantity! >= 2) {
                        Provider.of<WidgetChange>(context, listen: false).decrementCounter();
                        quantity = quantity! - 1;
                        itemQuantityController.text = quantity.toString();
                      }
                    },
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
                ),
                SizedBox(width: 3.w),
                Flexible(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                      Provider.of<WidgetChange>(context, listen: false).incrementCounter();
                      quantity = quantity! + 1;
                      itemQuantityController.text = quantity.toString();
                      /*setState(() {
                        widget.amountPrice = (double.parse(widget.amountPrice)+double.parse(widget.sellingPrice)).toString();
                        widget.profit = ((double.parse(widget.sellingPrice.toString())-double.parse(widget.costPrice.toString()))*(quantity!)-double.parse(itemDiscountController.text=="" ? "0" : itemDiscountController.text));
                      });*/
                    },
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
                ),
              ],
            ),
            CustomTextField(
                keyboardType: TextInputType.number,
                readOnly: false,
                controller: itemDiscountController,
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
                              text:
                              widget.amountPrice.toString(),
                              style: CustomTextStyle.labelText)
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
                              text: widget.profit.toString().substring(0,5),
                              style: CustomTextStyle.labelText)
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
