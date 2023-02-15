import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nssg/components/custom_textfield.dart';
import 'package:nssg/constants/navigation.dart';
import 'package:nssg/constants/strings.dart';
import 'package:nssg/screens/qoute/bloc/product_list_bloc.dart';
import 'package:nssg/screens/qoute/models/products_list.dart';
import 'package:nssg/utils/extention_text.dart';
import 'package:provider/provider.dart';
import '../../components/custom_appbar.dart';
import '../../components/custom_button.dart';
import '../../components/custom_radio_button.dart';
import '../../components/custom_text_styles.dart';
import '../../utils/app_colors.dart';
import 'package:sizer/sizer.dart';

import '../../utils/widgetChange.dart';
import 'add_item_detail.dart';

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

  TextEditingController depositAmountController = TextEditingController();

  var total = 0;

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    var profit = (double.parse(widget.eAmount) - 80.0).formatAmount();
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
        child: BlocConsumer<ProductListBloc, ProductListState>(
          listener: (context, state) {},
          builder: (context, state) {
            return ListView(
              physics: const BouncingScrollPhysics(),
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 8.sp),
                  child: Text(LabelString.lblTemplateOptions,
                      style: CustomTextStyle.labelText),
                ),
                SizedBox(height: 1.h),

                //Template option design
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
                SizedBox(height: 10.sp),

                //Static list item
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
                                    splashColor: AppColors.transparent,
                                      highlightColor: AppColors.transparent,
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
                                                child: EditItem(productsList: ProductsList(
                                                    itemId: DateTime.now().microsecondsSinceEpoch.toString(),
                                                    itemName: 'Installation (1st & 2nd fix)',
                                                    costPrice: '80.00',
                                                    sellingPrice: widget.eAmount,
                                                    quantity: 1,
                                                    discountPrice: "0",
                                                    amountPrice: widget.eAmount,
                                                    profit: profit,
                                                  description: "Installation of all devices, commission and handover Monday - Friday 8.00am - 5.00pm"
                                                )));
                                          },
                                        );
                                      },
                                      child: Image.asset(ImageString.icEdit,color: AppColors.borderColor,
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

                ...state.productList.map((e) => buildDetailItemTile(e, context, state)).toList(),
                //item list
                SizedBox(height: query.height *0.15)
              ],
            );
          },
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
              onTap: () => modelBottomSheetMenu(query, profit),
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

  //product list
  Padding buildDetailItemTile(ProductsList products, BuildContext context, ProductListState state) {
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
                                    child: EditItem(productsList: products));
                              },
                            ).then((value) {
                              setState(() {});
                            });
                          },
                          child: Image.asset(ImageString.icEdit, height: 2.5.h)
                        /*Icon(Icons.edit,
                                                      color: AppColors.primaryColor,
                                                      size: 14.sp),*/
                      ),
                      SizedBox(height: 1.5.h),
                      InkWell(
                        onTap: () {},
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
                                text: products.amountPrice.formatAmount(),
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
                                text: products.profit.formatAmount(),
                                style:
                                CustomTextStyle.labelText)
                          ]),
                    ),
                  )
                ],
              ),
              SizedBox(height: 2.0.h),
              Text(products.description.toString(),
                  style: CustomTextStyle.labelText),
              SizedBox(height: 1.h),
            ],
          ),
        ),
      ),
    );
  }

  ///Method for open bottom sheet
  ///Design opened bottom sheet
  void modelBottomSheetMenu(Size query, String profitFirst) {
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
            child: BlocConsumer<ProductListBloc, ProductListState>(
              listener: (context, state) {},
              builder: (context, state) {
                double subTotal = 0.0;
                double disc = 0.0;
                double profit = 0.0;

                //total of amount
                for(ProductsList p in state.productList){
                  subTotal += p.amountPrice.formatDouble();
                }

                //total of discount
                for(ProductsList d in state.productList){
                  disc += (d.discountPrice == "" ? 0.0 : d.discountPrice.formatDouble());
                }

                //total of profit
                for(ProductsList i in state.productList){
                  profit += i.profit.formatDouble();
                }

                //initial text for deposit textField
                depositAmountController.text = (subTotal+(subTotal*0.2)).formatAmount() == "0.00" ? (double.parse(widget.eAmount)+(double.parse(widget.eAmount)*0.2)).formatAmount(): ((subTotal+(subTotal*0.2))+(double.parse(widget.eAmount)+(double.parse(widget.eAmount)*0.2))).formatAmount();
                return Container(
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
                        //discount + amount = subtotal
                        BottomSheetData(
                            "Sub Total", (subTotal+disc).formatAmount()=="0.00" ? widget.eAmount : (double.parse(widget.eAmount)+((subTotal+disc))).formatAmount(), CustomTextStyle.labelText),

                        //Entered by user in textField
                        BottomSheetData(
                            "Discount Amount", disc.formatAmount() == "0.00" ? "0": disc.formatAmount(), CustomTextStyle.labelText),

                        //subTotal - discount = itemTotal
                        BottomSheetData(
                            "Items Total", subTotal.formatAmount() == "0.00" ? widget.eAmount : (double.parse(widget.eAmount)+subTotal).formatAmount(), CustomTextStyle.labelText),

                        //itemTotal * 0.2(Means 20%) = vat (20% vat on itemTotal)
                        BottomSheetData(
                            "Vat Total", (subTotal*0.2).formatAmount() == "0.00" ? (double.parse(widget.eAmount)*0.2).formatAmount() : ((subTotal*0.2)+(double.parse(widget.eAmount)*0.2)).formatAmount(), CustomTextStyle.labelText),
                        //show textField for enter deposit mount if user select deposit otherwise field is invisible
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
                                      controller: depositAmountController,
                                      keyboardType: TextInputType.number,
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
                        //itemTotal + vatTotal = GrandTotal
                        BottomSheetData(
                            "Grand Total", (subTotal+(subTotal*0.2)).formatAmount() == "0.00" ? (double.parse(widget.eAmount)+(double.parse(widget.eAmount)*0.2)).formatAmount(): ((subTotal+(subTotal*0.2))+(double.parse(widget.eAmount)+(double.parse(widget.eAmount)*0.2))).formatAmount(), CustomTextStyle.labelText),

                        //Sum of all profit amount
                        BottomSheetData(
                            "Total Profit", profit.formatAmount()=="0.00"? profitFirst : (double.parse(profitFirst)+profit).formatAmount() , CustomTextStyle.labelText),
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
                    ));
              },
            ),
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
  @override
  void initState() {
    super.initState();
    print("22222222222222222222222222 ${widget.productsList.itemId}");
    productsList = widget.productsList;
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
                            child: SelectLocation(productsList.quantity));
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
                isRequired: false,
              textInputAction: TextInputAction.next,

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
                          productsList.amountPrice = ((productsList.quantity ?? 0) * productsList.sellingPrice.formatDouble()).formatAmount();
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
                        productsList.amountPrice = ((productsList.quantity ?? 0) * productsList.sellingPrice.formatDouble()).formatAmount();
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
              onEditingComplete: () {
                setState((){});
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
                              text: (double.parse(productsList.amountPrice!) - (itemDiscountController.text == "" ? 0.0 : double.parse(itemDiscountController.text))).formatAmount(),
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
                              text: (double.parse(productsList.profit!) - (itemDiscountController.text == "" ? 0.0 : double.parse(itemDiscountController.text))).formatAmount(),
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
                      //productsList.discountPrice = itemDiscountController.text;
                      /*productsList.discountPrice = (itemDiscountController.text == "" ? 0.0 : double.parse(itemDiscountController.text)).formatAmount();
                      productsList.amountPrice = (double.parse(productsList.amountPrice!) - (itemDiscountController.text == "" ? 0.0 : double.parse(itemDiscountController.text))).formatAmount();
                      productsList.profit =  (double.parse(productsList.profit!) - (itemDiscountController.text == "" ? 0.0 : double.parse(itemDiscountController.text))).formatAmount();
                      productsList.quantity = quantity;*/
/*

                      ProductsList productsListUpdate = ProductsList(
                        itemId: widget.productsList.itemId,
                        itemName: itemNameController.text,
                        costPrice: itemCostPriceController.text,
                        sellingPrice: itemSellingPriceController.text,
                        discountPrice: itemDiscountController.text.toString(),
                        amountPrice: productsList.amountPrice.formatAmount(),
                        profit: productsList.profit.formatAmount(),
                        quantity: quantity,
                        description: itemDescriptionController.text
                      );
*/

                  Navigator.pop(context);
                })),
            SizedBox(height: 1.h),
          ],
        ),
      ),
    );
  }
}
