import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nssg/utils/extention_text.dart';
import 'package:sizer/sizer.dart';

import '../../../components/custom_button.dart';
import '../../../components/custom_text_styles.dart';
import '../../../components/custom_textfield.dart';
import '../../../constants/strings.dart';
import '../../../utils/app_colors.dart';
import '../bloc/product_list_bloc.dart';
import '../models/products_list.dart';
import 'select_location_dialog.dart';

///Class for edit item
class EditItem extends StatefulWidget {
  final ProductsList productsList;

  EditItem({Key? key, required this.productsList}) : super(key: key);

  @override
  State<EditItem> createState() => _EditItemState();
}

class _EditItemState extends State<EditItem> {
  TextEditingController itemNameController = TextEditingController();
  TextEditingController itemDescriptionController = TextEditingController();
  TextEditingController itemCostPriceController = TextEditingController();
  TextEditingController itemSellingPriceController = TextEditingController();
  TextEditingController itemQuantityController = TextEditingController();
  TextEditingController itemDiscountController = TextEditingController();

  int? quantity = 1;
  late ProductsList productsList;
  List<String>? listLocation = [];
  List<String>? listLocationTitle = [];
  @override
  void initState() {
    super.initState();
    productsList = widget.productsList;


    if(productsList.selectLocation != null && productsList.titleLocation != null){
      listLocation = productsList.selectLocation!.split("###");
      listLocationTitle = productsList.titleLocation!.split("###");
    }

    itemDescriptionController.text = widget.productsList.description.toString();
    itemNameController.text = widget.productsList.itemName.toString();
    itemCostPriceController.text = widget.productsList.costPrice.toString();
    itemSellingPriceController.text = widget.productsList.sellingPrice.formatAmount();
    itemQuantityController.text = widget.productsList.quantity.toString();
    itemDiscountController.text = widget.productsList.discountPrice.toString();
  }

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;

    //this is for show amount on edit dialog
    String finalAmountShow = (itemSellingPriceController.text == "" ? 0.0 : (double.parse(itemSellingPriceController.text) *
        productsList.quantity!)- (itemDiscountController.text == "" ? 0.0
        : double.parse(itemDiscountController.text))).formatAmount();

    //this is for data pass
    String finalAmount = (itemSellingPriceController.text == "" ? 0.0 : (double.parse(itemSellingPriceController.text) *
        productsList.quantity!)- (0.0)).formatAmount();

    /*(double.parse(productsList.amountPrice!) -
            (itemDiscountController.text == "" ? 0.0
                : double.parse(itemDiscountController.text))).formatAmount();*/

    String finalProfit = (itemSellingPriceController.text == "" ? 0.0 :
    ((double.parse(itemSellingPriceController.text) * productsList.quantity!) -
        (itemCostPriceController.text == "" ? 0.0 : double.parse(itemCostPriceController.text) * productsList.quantity!))
        - (itemDiscountController.text == "" ? 0.0
            : double.parse(itemDiscountController.text))).formatAmount();

    /*(double.parse(productsList.profit!) -
            (itemDiscountController.text == "" ? 0.0
                : double.parse(itemDiscountController.text))).formatAmount();*/

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
                Visibility(
                  visible: false,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(LabelString.lblAttachmentDocument,
                        style: CustomTextStyle.commonTextBlue),
                  ),
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
                            child: SelectLocation(
                                productsList.quantity,
                                productsList.itemName,
                                listLocation,
                                listLocationTitle,
                              productsList.productTitle,));
                      },
                    ).then((value) {
                      if (value != null) {
                        if (value is List) {
                          productsList = productsList.copyWith(locationList: value[0] as List<String>?,
                              titleLocationList: value[1] as List<String>?);
                          listLocation = value[0] as List<String>?;
                          listLocationTitle = value[1] as List<String>?;
                          setState(() { });
                        }
                      }
                    });
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
            AbsorbPointer(
              absorbing: false,
              child: CustomTextField(
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
                onChange: (string) {
                  setState(() {});
                },
              ),
            ),
            AbsorbPointer(
              absorbing: false,
              child: CustomTextField(
                keyboardType: TextInputType.number,
                readOnly: false,
                controller: itemSellingPriceController,
                obscureText: false,
                hint: LabelString.lblSellingPricePound,
                titleText: LabelString.lblSellingPricePound,
                isRequired: false,
                textInputAction: TextInputAction.next,
                onChange: (string) {
                  setState(() {});
                },
              ),
            ),
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
                      if (productsList.quantity! > 1) {
                        setState(() {
                          productsList.quantity = (productsList.quantity ?? 0) - 1;
                          productsList.amountPrice = ((productsList.quantity ?? 0) *
                                      productsList.sellingPrice.formatDouble()).formatAmount();
                          itemQuantityController.text = productsList.quantity.toString();
                        });
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
                      setState(() {
                        productsList.quantity = (productsList.quantity ?? 0) + 1;
                        productsList.amountPrice = ((productsList.quantity ?? 0) *
                                    productsList.sellingPrice.formatDouble()).formatAmount();
                        itemQuantityController.text = productsList.quantity.toString();
                      });
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
              isRequired: false,
              onChange: (string) {
                setState(() {});
              },
              textInputAction: TextInputAction.next,
            ),
            Row(
              children: [
                Expanded(
                  child: RichText(
                    text: TextSpan(
                        text: "${LabelString.lblAmount} : ",
                        style: CustomTextStyle.labelFontHintText,
                        children: [
                          TextSpan(
                              text: finalAmountShow,
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
                              text: finalProfit == "-0.00" ? "0.00" : finalProfit,
                              //productsList.profit.formatAmount(),
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
                    title: ButtonString.btnAddProduct,
                    onClick: () {
                      context.read<ProductListBloc>().add(
                          UpdateProductToListEvent(
                              productsList: productsList.copyWith(
                                  itemName: itemNameController.text,
                                  description: itemDescriptionController.text,
                                  profit: finalProfit,
                                  amountPrice: finalAmount,
                                  costPrice: itemCostPriceController.text,
                                  sellingPrice: itemSellingPriceController.text,
                                  quantity: int.parse(itemQuantityController.text),
                                  discountPrice: itemDiscountController.text,
                                  selectLocation: (listLocation ?? []).join('###'),
                                  titleLocation: (listLocationTitle ?? []).join('###'),
                              )));
                      Navigator.pop(context, finalAmountShow);
                    })),
            SizedBox(height: 1.h),
          ],
        ),
      ),
    );
  }
}

class DiscountDialog extends StatefulWidget {
  final ProductsList productsList;
  const DiscountDialog({Key? key, required this.productsList}) : super(key: key);

  @override
  State<DiscountDialog> createState() => _DiscountDialogState();
}

class _DiscountDialogState extends State<DiscountDialog> {
  TextEditingController discController = TextEditingController();
  late ProductsList productsList;

  @override
  void initState() {
    super.initState();
    productsList = widget.productsList;
    discController.text = widget.productsList.discountPrice.toString();
  }

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;

    return SizedBox(
        width: query.width / 1.1,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 1.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 12.sp),
                  child: Text(LabelString.lblAddDiscount,
                      style: CustomTextStyle.labelBoldFontText),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close_rounded, color: AppColors.blackColor),
                  splashColor: AppColors.transparent,
                  highlightColor: AppColors.transparent,
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.sp),
              child: CustomTextField(
                  keyboardType: TextInputType.number,
                  readOnly: false,
                  controller: discController,
                  obscureText: false,
                  hint: LabelString.lblAddDiscount,
                  titleText: LabelString.lblAddDiscount,
                  maxLines: 1,
                  minLines: 1,
                  textInputAction: TextInputAction.done,
                  onEditingComplete: () {
                    setState(() {});
                  },
                  isRequired: false),
            ),
            SizedBox(height: 1.h),
            SizedBox(
                width: query.width * 0.4,
                height: query.height * 0.06,
                child: CustomButton(
                    title: ButtonString.btnSubmit,
                    onClick: () {
                      String finalAmount = (widget.productsList.sellingPrice == "" ? 0.0 : (double.parse(widget.productsList.sellingPrice.toString()) *
                          productsList.quantity!)- (0.0)).formatAmount();

                      String finalProfit = (widget.productsList.sellingPrice == "" ? 0.0 :
                      ((double.parse(widget.productsList.sellingPrice.toString()) * productsList.quantity!) -
                          (widget.productsList.costPrice == "" ? 0.0 : double.parse(widget.productsList.costPrice.toString()) * productsList.quantity!))
                          - (discController.text == "" ? 0.0
                          : double.parse(discController.text))).formatAmount();

                      context.read<ProductListBloc>().add(
                          UpdateProductToListEvent(
                              productsList: productsList.copyWith(
                                  itemName: widget.productsList.itemName.toString(),
                                  description: widget.productsList.description.toString(),
                                  profit: finalProfit,
                                  amountPrice: finalAmount,
                                  costPrice: widget.productsList.costPrice.toString(),
                                  sellingPrice: widget.productsList.sellingPrice.toString(),
                                  quantity: widget.productsList.quantity,
                                  discountPrice: discController.text,
                                  selectLocation: (productsList.locationList ?? []).join('###'),
                                titleLocation:(productsList.titleLocationList ?? []).join('###'),
                              )));
                     // Navigator.pop(context, double.parse(discController.text));
                      Navigator.pop(context);
                    })),
            SizedBox(height: 3.h)
          ],
        ));
  }
}
