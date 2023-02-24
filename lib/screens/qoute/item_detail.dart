import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:nssg/components/custom_textfield.dart';
import 'package:nssg/constants/navigation.dart';
import 'package:nssg/constants/strings.dart';
import 'package:nssg/screens/qoute/bloc/product_list_bloc.dart';
import 'package:nssg/screens/qoute/models/products_list.dart';
import 'package:nssg/screens/qoute/quote_datasource.dart';
import 'package:nssg/screens/qoute/quote_repository.dart';
import 'package:nssg/utils/extention_text.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/custom_appbar.dart';
import '../../components/custom_button.dart';
import '../../components/custom_radio_button.dart';
import '../../components/custom_text_styles.dart';
import '../../components/toggle_switch.dart';
import '../../constants/constants.dart';
import '../../utils/app_colors.dart';
import 'package:sizer/sizer.dart';
import 'package:collection/collection.dart';
import '../../utils/helpers.dart';
import '../../utils/widgetChange.dart';
import 'add_item_detail.dart';
import 'add_quote/add_quote_bloc_dir/add_quote_bloc.dart';
import 'add_quote/models/create_quote_request.dart';

class BuildItemDetail extends StatefulWidget {
  var eAmount;
  String? systemTypeSelect;
  String? quotePaymentSelection;
  String? contactSelect;
  String? premisesTypeSelect;
  String? termsItemSelection;
  String? gradeFireSelect;
  String? signallingTypeSelect;
  String? engineerNumbers;
  String? timeType;
  String? billStreet;
  String? billCity;
  String? billCountry;
  String? billCode;
  String? shipStreet;
  String? shipCity;
  String? shipCountry;
  String? shipCode;
  String? contactId;
  String? contactCompany;
  String? mobileNumber;
  String? telephoneNumber;

  var termsList;

  BuildItemDetail(
      this.eAmount,
      this.systemTypeSelect,
      this.quotePaymentSelection,
      this.contactSelect,
      this.premisesTypeSelect,
      this.termsItemSelection,
      this.gradeFireSelect,
      this.signallingTypeSelect,
      this.engineerNumbers,
      this.timeType,
      this.billStreet,
      this.billCity,
      this.billCountry,
      this.billCode,
      this.shipStreet,
      this.shipCity,
      this.shipCountry,
      this.shipCode,
      this.contactId,
      this.contactCompany,
      this.mobileNumber,
      this.telephoneNumber, this.termsList,
      {super.key});

  @override
  State<BuildItemDetail> createState() => _BuildItemDetailState();
}

class _BuildItemDetailState extends State<BuildItemDetail> {
  List templateOptionList = [LabelString.lblHideProductPrice, LabelString.lblHideProduct, LabelString.lblNone];
  List<RadioModel> templateOption = <RadioModel>[]; //step 1

  TextEditingController sellingPriceController = TextEditingController();
  TextEditingController discountPriceController = TextEditingController();
  TextEditingController depositAmountController = TextEditingController();

  bool isLoading = false;
  var total = 0;
  double subTotal = 0.0;
  double disc = 0.0;
  double profit = 0.0;
  double grandTotal = 0.0;
  double vatTotal = 0.0;

  List<ProductsList> productListLocal = [];
  List<String> userChecked = [];

  String selectTemplateOption = '';

  String termsSelect = "";

  String depositValue = "";
  @override
  void initState() {
    super.initState();
    var profit = (double.parse(widget.eAmount) - 80.0).formatAmount();
    var productList = context.read<ProductListBloc>().state.productList.firstWhereOrNull((element) => element.itemId == "123456");
    if(productList ==null){
      context.read<ProductListBloc>().add(AddProductToListEvent(productsList: ProductsList(
          itemId:  "123456",
          productId: "789",
          itemName: 'Installation (1st & 2nd fix)',
          costPrice: '80.00',
          sellingPrice: widget.eAmount,
          quantity: 1,
          discountPrice: "0",
          amountPrice: widget.eAmount,
          profit: profit,
          description: "Installation of all devices, commission and handover Monday - Friday 8.00am - 5.00pm"
      )));
    }
    //todo: call event(ClearProductToListEvent) after get success response
  }

  AddQuoteBloc addQuoteBloc = AddQuoteBloc(QuoteRepository(quoteDatasource: QuoteDatasource()));
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
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 5.sp),
        child: BlocListener<AddQuoteBloc, AddQuoteState>(
          bloc: addQuoteBloc,
            listener: (context, state) {
              if (state is FailAddQuote) {
                Helpers.showSnackBar(context, state.error.toString());
              }
              if(state is LoadedAddQuote){
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              }
            },
            child: BlocBuilder<AddQuoteBloc, AddQuoteState>(
              bloc: addQuoteBloc,
            builder: (context, state) {
              if (state is LoadingAddQuote) {
                isLoading = state.isBusy;
              }
              if (state is LoadedAddQuote) {
                isLoading = false;
                Helpers.showSnackBar(context, "Quote added successfully!");
              }
              if (state is FailAddQuote) {
                isLoading = false;
              }

            return BlocConsumer<ProductListBloc, ProductListState>(
            listener: (context, state) {
              productListLocal = state.productList;
            },
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
                        templateOption.add(RadioModel(false, templateOptionList[index]));
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
                              Provider.of<WidgetChange>(context, listen: false).isTemplateOption();
                              templateOption[index].isSelected = true;
                              selectTemplateOption = templateOption[index].buttonText.toString().replaceAll(" ", "_");
                              print(templateOption[index].buttonText.toString().replaceAll(" ", "_"));
                            },
                            child: RadioItem(templateOption[index]),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: 10.sp),
                ...state.productList.map((e) => buildDetailItemTile(e, context, state)).toList(),
                //item list
                SizedBox(height: query.height *0.08)
              ],
            );
          },
        );
  },
),
),
      ),

      ///bottom sheet design
      bottomSheet: Container(
        width: query.width,
        height: query.height * 0.08,
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
            /*SizedBox(
              width: query.width * 0.8,
              height: query.height * 0.06,
              child: CustomButton(
                title: ButtonString.btnSubmit,
                buttonColor: AppColors.primaryColor,
                onClick: () => callCreateQuoteAPI(subTotal, grandTotal, disc,
                    selectTemplateOption, vatTotal, profit,
                    depositAmountController.text, productListLocal)
              ),
            )*/
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
      padding: EdgeInsets.only(left: 6.sp, right: 6.sp),
      child: Slidable(
        key: const ValueKey(0),
        startActionPane:  ActionPane(
          motion: const ScrollMotion(),
          extentRatio: 0.25,
          children: [
            SlidableAction(
              borderRadius: BorderRadius.circular(12.0),
              padding: EdgeInsets.zero,
              autoClose: true,
              onPressed: (context){
                showDialog(
                  context: context,
                  builder: (context) {
                    ///Make new class for dialog
                    return Dialog(
                        shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10)),
                        elevation: 0,
                        insetPadding: EdgeInsets.symmetric(horizontal: 12.sp),
                        child: EditItem(productsList: products));
                  });
              },
              backgroundColor: AppColors.backWhiteColor,
              foregroundColor: AppColors.primaryColor,
              icon: Icons.percent,
              label: "Discount"),
          ],
        ),
        endActionPane:  ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              borderRadius: BorderRadius.circular(12.0),
              padding: EdgeInsets.zero,
              onPressed: (context){
                showDialog(
                  context: context,
                  builder: (context) {
                    ///Make new class for dialog
                    return Dialog(
                        shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10)),
                        elevation: 0,
                        insetPadding: EdgeInsets.symmetric(horizontal: 12.sp),
                        child: EditItem(productsList: products));
                  });
              },
              autoClose: true,
              backgroundColor: AppColors.backWhiteColor,
              foregroundColor: Colors.green,
              icon: Icons.edit,
              label: 'Edit'),
            SlidableAction(
              borderRadius: BorderRadius.circular(12.0),
              padding: EdgeInsets.zero,
              autoClose: true,
              onPressed: null,
              backgroundColor: AppColors.backWhiteColor,
              foregroundColor: AppColors.redColor,
              icon: Icons.delete_outline,
              label: 'Delete'),
          ],
        ),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.sp),
            ),
            child: Padding(
              padding:EdgeInsets.fromLTRB(12.sp, 10.sp, 10.sp, 10.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${products.quantity} items",style: CustomTextStyle.commonText),
                  SizedBox(height: 0.8.h),
                  Text("${products.itemName}",style: CustomTextStyle.labelBoldFontText),
                  SizedBox(height: 0.4.h),
                  Text("£${products.amountPrice}",style: CustomTextStyle.labelBoldFontTextSmall)
                ],
            ),
            ),
          ),
        ),
      )

      /*Card(
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
                  Expanded(
                    child: RichText(
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
                            );
                          },
                          child: Image.asset(ImageString.icEdit, height: 2.5.h)

                      ),
                      SizedBox(height: 1.5.h),
                      InkWell(
                        onTap: () {

                        },
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
              Text(products.description.toString(), maxLines: 3,
                  style: CustomTextStyle.labelText),
              SizedBox(height: 1.h),
            ],
          ),
        ),
      ),*/
    );
  }

  ///Method for open bottom sheet
  ///Design opened bottom sheet
  void modelBottomSheetMenu(Size query) {
    showModalBottomSheet(

        backgroundColor: AppColors.transparent,
        enableDrag: false,
        isDismissible: false,
        isScrollControlled: true,

        context: context,
        builder: (builder) {
          return Container(
            height: query.height * 0.8,
            color: Colors.transparent, //could change this to Color(0xFF737373),
            //so you don't have to change MaterialApp canvasColor
            child: BlocConsumer<ProductListBloc, ProductListState>(
              listener: (context, state) {},
              builder: (context, state) {

                //total of amount
                  for(ProductsList p in state.productList){
                    subTotal += p.amountPrice.formatDouble();
                    disc += (p.discountPrice == "" ? 0.0 : p.discountPrice.formatDouble());
                    profit += p.profit.formatDouble();
                  }

                  grandTotal = subTotal+(subTotal*0.2);
                  vatTotal = (subTotal*0.2);
                  //initial text for deposit textField
                  depositAmountController.text = (subTotal+(subTotal*0.2)).formatAmount();

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
                                Text(LabelString.lblHideAmount,
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
                        BottomSheetDataTile(
                            LabelString.lblSubTotal, (subTotal+disc).formatAmount(), CustomTextStyle.labelText),

                        //Entered by user in textField
                        BottomSheetDataTile(
                            LabelString.lblDiscountAmount, disc.formatAmount(), CustomTextStyle.labelText),

                        //subTotal - discount = itemTotal
                        BottomSheetDataTile(
                            LabelString.lblItemsTotal, subTotal.formatAmount(), CustomTextStyle.labelText),

                        //itemTotal * 0.2(Means 20%) = vat (20% vat on itemTotal)
                        BottomSheetDataTile(
                            LabelString.lblVatTotal, vatTotal.formatAmount(), CustomTextStyle.labelText),
                        //show textField for enter deposit mount if user select deposit otherwise field is invisible
                        Provider.of<WidgetChange>(context, listen: true).isDeposit ?
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 14.sp),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(LabelString.lblDepositAmount, style: CustomTextStyle.labelText),
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
                                          hintText: LabelString.lblDepositAmount,
                                          hintStyle: CustomTextStyle.labelFontHintText),
                                      textAlign: TextAlign.right,

                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ) : Container(),
                        //itemTotal + vatTotal = GrandTotal
                        BottomSheetDataTile(
                            LabelString.lblGrandTotal, grandTotal.formatAmount(), CustomTextStyle.labelText),

                        //Sum of all profit amount
                        BottomSheetDataTile(
                            LabelString.lblTotalProfit, profit.formatAmount() , CustomTextStyle.labelText),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 14.sp,vertical: 10.sp),
                          child: Row(
                            children: [
                              ToggleSwitch((value) {
                                Provider.of<WidgetChange>(context, listen: false).isDepositAmount(value);
                                depositValue = value.toString();
                              },
                                  valueBool: Provider.of<WidgetChange>(context, listen: true).isDeposit),
                              SizedBox(width: 5.w),
                              Text(Provider.of<WidgetChange>(context, listen: true).isDeposit ? "Deposit" : "No Deposit", style: CustomTextStyle.labelText)
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 14.sp, vertical: 10.sp),
                              child: Text(LabelString.lblTerms, style: CustomTextStyle.labelMediumBoldFontText),
                            )),
                        ...widget.termsList.map((e) {
                          return  Padding(
                            padding: EdgeInsets.symmetric(horizontal: 14.sp,vertical: 10.sp),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ToggleSwitch((value) {
                                  Provider.of<WidgetChange>(context, listen: false).isTermsSelect(e['value']);
                                  termsSelect = e['value'].toString();
                                },
                                    valueBool: e['value'] == Provider.of<WidgetChange>(context, listen: false).isTermsBS),
                                SizedBox(width: 5.w),
                                Expanded(child: Text(e["label"].toString(), style: CustomTextStyle.labelText))
                              ],
                            ),
                          );
                        }).toList(),
                        SizedBox(
                          width: query.width * 0.8,
                          height: query.height * 0.06,
                          child: CustomButton(
                            title: ButtonString.btnSubmit,
                            buttonColor: AppColors.primaryColor,
                            onClick: () {
                              Navigator.pop(context);
                              callCreateQuoteAPI(subTotal, grandTotal, disc, selectTemplateOption, vatTotal, profit, depositAmountController.text, state.productList);
                            },
                          ),
                        ),

                      ],
                    ));
              },
            ),
          );
        });
  }

  Future<void> callCreateQuoteAPI(double subTotal, double grandTotal, double disc,
      String selectTemplateOption, double vatTotal, double profit, String depositAmount,
      List<ProductsList> productList ) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    //for create data in json format
    CreateQuoteRequest createQuoteRequest = CreateQuoteRequest(
        subject: "${widget.contactSelect}-${widget.systemTypeSelect}",
        quotestage: "Processed",
        contactId : widget.contactId,
        subtotal : subTotal.toString(),
        txtAdjustment : "0.00",
        hdnGrandTotal : grandTotal.toString(),
        hdnTaxType : "individual",
        hdnDiscountPercent : "0.00",
        hdnDiscountAmount : disc.toString(),
        hdnSHAmount : "0.00",
        assignedUserId : preferences.getString(PreferenceString.userId).toString(),
        currencyId : "21x1",
        conversionRate : "0.00",
        billStreet : widget.billStreet,
        shipStreet : widget.shipStreet,
        billCity : widget.billCity,
        shipCity : widget.shipCity,
        billCountry : widget.billCountry,
        shipCountry : widget.shipCountry,
        billCode : widget.billCode,
        shipCode : widget.shipCode ,
        description : Message.descriptionForQuote,
        termsConditions : termsSelect  == "50% Deposit Balance on Account(Agreed terms)"
            ? Message.termsCondition1
            : Message.termsCondition2,
        preTaxTotal : vatTotal.toString(),
        hdnSHPercent : "0",
        siteAddressId : "", //todo: get this id when perform edit operation
        quotesTerms : widget.termsItemSelection,
        hdnprofitTotal : profit.toString(),
        markup : "0.00",
        issueNumber : "1",
        gradeNumber : widget.gradeFireSelect,
        systemType : widget.systemTypeSelect,
        signallingType : widget.signallingTypeSelect,
        premisesType : widget.premisesTypeSelect,
        projectManager : preferences.getString(PreferenceString.userId).toString(),
        quotesEmail : preferences.getString(PreferenceString.userName).toString(),
        quotesTemplateOptions : selectTemplateOption,
        quoteRelatedId : "0", //todo: get this field on edit operation
        quotesCompany : widget.contactCompany,
        installation : "0",
        hdnsubTotal : subTotal.toString(),
        hdndiscountTotal : disc.toString(),
        quoteMobileNumber : widget.mobileNumber,
        quoteTelephoneNumber : widget.telephoneNumber,
        isQuotesConfirm : "0",
        quotesPayment : Provider.of<WidgetChange>(context, listen: true).isDeposit ? "Deposit" : "No Deposit",
        isQuotesPaymentConfirm : "0",
        quotesDepositeAmount : depositAmount,
        quotesDepoReceivedAmount : "0.00",
        quoteEmailReminder : "0",
        quoteReminderEmailSentLog : "",
        isKeyholderConfirm : "0",
        isMaintenanceConConfirm : "0",
        isPoliceAppliConfirm : "0",
        quoteCorrespondencesDocs : "",
        quoteQuoteType : "Installation",
        quotesContractId : "",
        quoteStopEmailDocReminder : "0",
        quotePriorityLevel : "Normal",
        quoteWorksSchedule : "2nd fix only",
        quoteNoOfEngineer : widget.engineerNumbers,
        quoteReqToCompleteWork : widget.timeType,
        lineItems :  productList.map((e) => LineItems(
          productid: e.productId,
          sequenceNo: "2",
          quantity: e.quantity.toString(),
          listprice: e.amountPrice,
          discountPercent: "00.00",
          discountAmount: e.discountPrice,
          comment: e.description,
          description: "",
          incrementondel: "0",
          tax1: "20.00",
          tax2: "",
          tax3: "",
          productLocation: "",
          productLocationTitle: "",
          costprice: e.costPrice,
          extQty: "0",
          requiredDocument: "Keyholder form###Maintenance contract###Police application###Direct Debit",
          proShortDescription: e.description,
        )).toList()
    );

    String jsonQuoteDetail = jsonEncode(createQuoteRequest);

    debugPrint(" jsonQuoteDetail add ----- $jsonQuoteDetail");

    Map<String, String> bodyData = {
      'operation': "create",
      'sessionName': preferences.getString(PreferenceString.sessionName).toString(),
      'element': jsonQuoteDetail,
      'elementType': 'Quotes',
      'appversion': Constants.of().appversion.toString(),
    };

    addQuoteBloc.add(AddQuoteDetailEvent(bodyData));
  }

  void _onSelected(bool selected, String dataName) {
    if (selected == true) {
      setState(() {
        userChecked.add(dataName);
      });
    } else {
      setState(() {
        userChecked.remove(dataName);
      });
    }
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

    final finalAmount = (double.parse(productsList.amountPrice!) -
        (itemDiscountController.text == "" ? 0.0 : double.parse(itemDiscountController.text))).formatAmount();

    final finalProfit = (double.parse(productsList.profit!) -
        (itemDiscountController.text == "" ? 0.0 : double.parse(itemDiscountController.text))).formatAmount();

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
            AbsorbPointer(
              absorbing: true,
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
              ),
            ),
            AbsorbPointer(
              absorbing: true,
              child: CustomTextField(
                keyboardType: TextInputType.number,
                readOnly: false,
                controller: itemSellingPriceController,
                obscureText: false,
                hint: LabelString.lblSellingPricePound,
                titleText: LabelString.lblSellingPricePound,
                isRequired: false,
                textInputAction: TextInputAction.next,

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
                              text: finalAmount,
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
                              text: finalProfit,
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
                          UpdateProductToListEvent(productsList: productsList.copyWith(
                            profit:finalProfit,
                            amountPrice: finalAmount,
                            discountPrice : itemDiscountController.text,
                          )));
                      Navigator.pop(context);
                    })),
            SizedBox(height: 1.h),
          ],
        ),
      ),
    );
  }
}

///Custom class for bottom sheet static design
class BottomSheetDataTile extends StatelessWidget {
  String? keyText;
  String? valueText;
  TextStyle? textStyle;

  BottomSheetDataTile(this.keyText, this.valueText, this.textStyle, {super.key});

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
class SelectLocation extends StatefulWidget {

  var quantity;

  SelectLocation(this.quantity, {super.key});

  @override
  State<SelectLocation> createState() => _SelectLocationState();
}

class _SelectLocationState extends State<SelectLocation> {
  var titleTECs = <TextEditingController>[];
  var locationTECs = <TextEditingController>[];
  var cards = <Card>[];

  Card createCard() {
    var titleController = TextEditingController();
    var locationController = TextEditingController();

    titleTECs.add(titleController);
    locationTECs.add(locationController);

    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('Location ${cards.length + 1}'),
          CustomTextField(
            keyboardType: TextInputType.name,
            readOnly: false,
            controller: titleController,
            obscureText: false,
            hint: LabelString.lblTitle,
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
              hint: LabelString.lblLocation,
              titleText: LabelString.lblLocation,
              isRequired: false,
              maxLines: 1,
              minLines: 1,
              textInputAction: TextInputAction.next),

        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    cards.add(createCard());
  }

  _onDone() {
    List<PersonEntry> entries = [];
    for (int i = 0; i < cards.length; i++) {
      var title = titleTECs[i].text;
      var location = locationTECs[i].text;
      entries.add(PersonEntry(title, location));
    }
    Navigator.pop(context, entries);
  }

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.fromLTRB(10.sp, 0, 10.sp, 15.sp),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Align(
                alignment: Alignment.topRight,
                child: IconButton(
                    highlightColor: AppColors.transparent,
                    splashColor: AppColors.transparent,
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.close_rounded,
                        color: AppColors.blackColor))),
            SizedBox(
              height: cards.length == 1 ? query.height / 4 : query.height / 2,
              child: ListView.builder(
                itemCount: cards.length,
                itemBuilder: (BuildContext context, int index) {
                  return cards[index];
                },
              ),
            ),
            TextButton(
              child:  widget.quantity != cards.length ? const Text('Add location') : const Text(''),
              onPressed: () => setState(() {
                if(widget.quantity != cards.length){
                  cards.add(createCard());
                }
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
                        title: ButtonString.btnSave, onClick: _onDone)),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class PersonEntry {
  final String title;
  final String location;

  PersonEntry(this.title, this.location);
  @override
  String toString() {
    return 'title= $title, location= $location';
  }
}