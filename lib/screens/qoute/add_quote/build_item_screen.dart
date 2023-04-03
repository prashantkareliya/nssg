import 'dart:convert';
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shake_animated/flutter_shake_animated.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:nssg/constants/navigation.dart';
import 'package:nssg/constants/strings.dart';
import 'package:nssg/screens/qoute/bloc/product_list_bloc.dart';
import 'package:nssg/screens/qoute/quote_datasource.dart';
import 'package:nssg/screens/qoute/quote_repository.dart';
import 'package:nssg/screens/qoute/quotes_screen.dart';
import 'package:nssg/utils/extention_text.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../components/custom_appbar.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_radio_button.dart';
import '../../../components/custom_text_styles.dart';
import '../../../components/toggle_switch.dart';
import '../../../constants/constants.dart';
import '../../../httpl_actions/app_http.dart';
import '../../../utils/app_colors.dart';
import 'package:sizer/sizer.dart';
import 'package:collection/collection.dart';
import '../../../utils/helpers.dart';
import '../../../utils/widgetChange.dart';
import '../../../utils/widgets.dart';
import '../../dashboard/root_screen.dart';
import '../models/products_list.dart';
import '../send_email.dart';
import 'add_item_screen.dart';
import 'add_quote_bloc_dir/add_quote_bloc.dart';
import 'edit_item_dialog.dart';
import 'models/create_quote_request.dart';

import 'quote_estimation_dialog.dart';
import '../get_product/product_model_dir/get_product_response_model.dart' as product;
import 'search_add_product_screen.dart';
import 'thankyou_screen.dart';


///Third step to create quote
class BuildItemScreen extends StatefulWidget {
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

  String? contactEmail;

  var siteAddress;

  BuildItemScreen(
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
      this.telephoneNumber,
      this.termsList, this.contactEmail, this.siteAddress,
      {super.key});

  @override
  State<BuildItemScreen> createState() => _BuildItemScreenState();
}

class _BuildItemScreenState extends State<BuildItemScreen> {
  List templateOptionList = [LabelString.lblHideProductPrice, LabelString.lblHideProduct, LabelString.lblNone];
  List<RadioModel> templateOption = <RadioModel>[]; //step 1

  TextEditingController sellingPriceController = TextEditingController();
  TextEditingController discountPriceController = TextEditingController();
  TextEditingController depositAmountController = TextEditingController();

  bool isLoading = false;
  var total = 0;

  List<ProductsList> productListLocal = [];
  List<String> userChecked = [];

  String selectTemplateOption = "Hide_Product_Price";
  String termsSelect = "";
  String depositValue = "true";
  String defaultItemPrice = "450";

  bool isEmailRemind = true;

  //String? itemAmount;

  @override
  void initState() {
    super.initState();
    print(widget.siteAddress.toString());
//widget.siteAddress.toString() == "{}"
   /* var profit = (double.parse("0") - 80.0).formatAmount();
    var productList = context.read<ProductListBloc>().state.productList.firstWhereOrNull((element) => element.itemId == "123456");
    if(productList == null){
      context.read<ProductListBloc>().add(AddProductToListEvent(productsList: ProductsList(
          itemId:  "14x123456",
          productId: "789",
          itemName: 'Installation (1st & 2nd fix)',
          costPrice: '80.00',
          sellingPrice: defaultItemPrice,
          quantity: 1,
          discountPrice: "0",
          amountPrice: defaultItemPrice,
          profit: profit,
          description: "Installation of all devices, commission and handover Monday - Friday 8.00am - 5.00pm"
      )));
    }*/
    //todo: call event(ClearProductToListEvent) after get success response
  }

  AddQuoteBloc addQuoteBloc = AddQuoteBloc(
      QuoteRepository(quoteDatasource: QuoteDatasource()));

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
                print(state.quoteId);

                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      return Dialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 0,
                          insetAnimationCurve: Curves.decelerate,
                          insetPadding: EdgeInsets.symmetric(horizontal: 8.sp),
                          child: ThankYouScreen(state.quoteId.toString(), widget.contactEmail.toString()),
                      );
                    });
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
                // Helpers.showSnackBar(context, "Quote added successfully!");
              }
              if (state is FailAddQuote) {
                isLoading = false;
              }

            return BlocConsumer<ProductListBloc, ProductListState>(
            listener: (context, state) {
              productListLocal = state.productList;
            },
            builder: (context, state) {
              return isLoading ? loadingView() :ListView(
              physics: const BouncingScrollPhysics(),
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
                        templateOption.add(
                            RadioModel(templateOptionList[index] == "Hide Product Price"
                                ? true : false, templateOptionList[index]));
                        Provider.of<WidgetChange>(context).isSelectTemplateOption;

                        return SizedBox(
                          height: 6.h,
                          child: InkWell(
                            splashColor: AppColors.transparent,
                            highlightColor: AppColors.transparent,
                            onTap: () {
                              setState(() {
                                templateOption[0].isSelected = false;
                              });
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
                SizedBox(height: 2.0.h),
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 20,
                        width: 20,
                        child: Checkbox(
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0)),
                            activeColor: AppColors.primaryColor,
                            onChanged: (value) {
                              Provider.of<WidgetChange>(context, listen: false).isReminder();
                              isEmailRemind = Provider.of<WidgetChange>(context, listen: true).isReminderCheck;
                            },
                            value: Provider.of<WidgetChange>(context, listen: true).isReminderCheck
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10.sp),
                        child: Text(LabelString.lblQuoteEmailReminder,
                            style: CustomTextStyle.labelFontText),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10.sp),
                quoteEstimationWidget(query),
                SizedBox(height: 10.sp),
                ...state.productList.map((e) => buildDetailItemTile(e, context, state)).toList().reversed,
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
            TextButton(
              onPressed: () => modelBottomSheetMenu(query),
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
                    height: 2.h)
                ],
              ),
            ),
          ],
        ),
      ),

      ///Open add item screen
      ///Make new class and using pageView for add item detail
      floatingActionButton: SizedBox(
        height: 8.h,
        child: FittedBox(
          child: FloatingActionButton.small(
              onPressed: () {
                //callNextScreen(context, AddItemDetail(widget.systemTypeSelect));
              /* Navigator.push(context,
                    MaterialPageRoute(builder: (context) =>
                        AddItemDetail(widget.eAmount,
                            widget.systemTypeSelect,
                            widget.quotePaymentSelection,
                            widget.contactSelect,
                            widget.premisesTypeSelect,
                            widget.termsItemSelection,
                            widget.gradeFireSelect,
                            widget.signallingTypeSelect,
                            widget.engineerNumbers,
                            widget.timeType,
                            widget.billStreet,
                            widget.billCity,
                            widget.billCountry,
                            widget.billCode,
                            widget.shipStreet,
                            widget.shipCity,
                            widget.shipCountry,
                            widget.shipCode,
                            widget.contactId,
                            widget.contactCompany,
                            widget.mobileNumber,
                            widget.telephoneNumber,
                            widget.termsList,
                          widget.contactEmail,
                          widget.siteAddress
                        ))).then((value) {
                          print(value);
                        });*/
                callNextScreen(context, const SearchAndAddProduct());
              },
              child: Lottie.asset('assets/lottie/adding.json')),
        ),
      ),
    );
  }

  Padding quoteEstimationWidget(Size query) {
    return Padding(
      padding: EdgeInsets.only(left: 6.sp, right: 6.sp,top: 5,bottom: 5),
      child: Container(width: query.width, height: query.height * 0.08,
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.primaryColor,width: 1),
              borderRadius: BorderRadius.circular(12.0),
              color: AppColors.whiteColor),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: query.height,
                color: AppColors.primaryColorLawOpacity,
                child: IconButton(onPressed: (){},
                    icon: Icon(Icons.info_outline, color: AppColors.primaryColor))),
                      SizedBox(width: 3.w),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                              text: "${Message.addEngineerAndHours} ",
                              style: GoogleFonts.roboto(textStyle: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.normal,
                                  fontStyle: FontStyle.normal,
                                  color: AppColors.primaryColor,
                                  decoration: TextDecoration.underline)),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        ///Make new class for dialog
                                        return Dialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10)),
                                            elevation: 0,
                                            insetAnimationCurve: Curves.decelerate,
                                            insetPadding: EdgeInsets.symmetric(horizontal: 12.sp),
                                            child: QuoteEstimation());
                                      }).then((value) {
                                       if(value != null){
                                         var profit = (double.parse(value.toString()) - 80.0).formatAmount();
                                         context.read<ProductListBloc>().add(UpdateProductToListEvent(productsList: ProductsList(
                                             itemId:  "123456",
                                             productId: "14x789",
                                             itemName: 'Installation (1st & 2nd fix)',
                                             costPrice: '80.00',
                                             sellingPrice: value.toString(),
                                             quantity: 1,
                                             discountPrice: "0",
                                             amountPrice: value.toString(),
                                             profit: profit,
                                             description: "Installation of all devices, commission and handover Monday - Friday 8.00am - 5.00pm",
                                           productImage: ""

                                         )));
                                       }
                                       }
                                      );
                                },
                              children: [
                                TextSpan(
                                    text: Message.quoteEstimation,
                                    style: GoogleFonts.roboto(textStyle: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.normal,
                                        fontStyle: FontStyle.normal,
                                        color: AppColors.blackColor,
                                        decoration: TextDecoration.none)))
                              ]),
                        ),
                      ),
                    ],
                  )
                ),
              );
  }

  //product list
  Padding buildDetailItemTile(ProductsList products, BuildContext context, ProductListState state) {
    //itemAmount = products.amountPrice.toString();
    final List<ShakeConstant> shakeList;
    return Padding(
      padding: EdgeInsets.only(left: 6.sp, right: 6.sp,top: 5,bottom: 8.sp),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
              color: AppColors.backWhiteColor
        ),
        child: Slidable(
          key: ValueKey(products.itemId),
          startActionPane:  ActionPane(
            motion: const ScrollMotion(),
            extentRatio: 0.2,
            children: [
              CustomSlidableAction(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10.0),
                    topLeft: Radius.circular(10.0)),
                padding: EdgeInsets.zero,
                autoClose: true,
                onPressed: (context){
                  showDialog(
                      context: context,
                      builder: (context) {
                        ///Make new class for dialog
                        return Dialog(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            elevation: 0,
                            insetPadding: EdgeInsets.zero,
                            child: DiscountDialog(productsList: products));
                      }).then((value) {
                        setState(() {});
                      });
                },
                backgroundColor: AppColors.backWhiteColor,
                foregroundColor: AppColors.primaryColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(ImageString.icDiscount,
                        color: AppColors.primaryColor,
                        fit: BoxFit.fill, height: 2.5.h),
                    SizedBox(height: 0.8.h),
                    Text(LabelString.lblDiscount, style: GoogleFonts.roboto(textStyle: TextStyle(
                        fontSize: 10.sp, color: AppColors.primaryColor)),)
                  ],
                ),
              ),
            ],
          ),
          endActionPane:  ActionPane(
            extentRatio: 0.4,
            motion: const ScrollMotion(),
            children: [
              CustomSlidableAction(
                padding: EdgeInsets.zero,
                onPressed: (context){
                  showDialog(
                    context: context,
                    builder: (context) {
                      ///Make new class for dialog
                      return Dialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 0,
                          insetPadding: EdgeInsets.zero,
                          child: EditItem(productsList: products));
                    });
                },
                autoClose: true,
                backgroundColor: AppColors.backWhiteColor,
                foregroundColor: Colors.green,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(ImageString.icEditProd,
                          color: AppColors.greenColorAccent, fit: BoxFit.fill,height: 2.5.h),
                      SizedBox(height: 0.8.h),
                      Text(ButtonString.btnEdit, style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                            fontSize: 10.sp,
                            color: AppColors.greenColorAccent)
                      ),
                      )
                    ],
                  )),
              CustomSlidableAction(
                borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(10.0),
                    topRight: Radius.circular(10.0)),
                padding: EdgeInsets.zero,
                autoClose: true,
                onPressed: (value){
                  setState(() {
                    state.productList.remove(products);
                  });
                },
                backgroundColor: AppColors.backWhiteColor,
                foregroundColor: AppColors.redColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(ImageString.icDeleteProd,
                        color: AppColors.redColor, fit: BoxFit.fill,height: 2.5.h),
                    SizedBox(height: 0.8.h),
                    Text(ButtonString.btnDelete, style: GoogleFonts.roboto(
                        textStyle :TextStyle(
                            fontSize: 10.sp,
                            color: AppColors.redColor)),
                    )
                  ],
                ),
              ),
            ],
          ),
          child: Card(
            elevation: 2.0,
            margin: EdgeInsets.zero,
            color: products.itemName!.contains("Installation") ?
            AppColors.primaryColorLawOpacityBack : AppColors.whiteColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.sp),
            ),
            child: Padding(
              padding:EdgeInsets.fromLTRB(0.sp, 3.sp, 0.sp, 3.sp),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(flex: 1,
                        child: products.itemName!.contains("Installation (1st & 2nd fix)") ?
                        Lottie.asset('assets/lottie/gear.json', height: 9.h,) :
                        products.productImage == null || products.productImage == "" ?
                        SvgPicture.asset(ImageString.imgPlaceHolder, height: 8.h) :
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network("${ImageBaseUrl.productImageBaseUrl}${products.productImage!.replaceAll("&ndash;", "–")}", height: 8.h),
                        )
                      /* child: products.productImage == null || products.productImage == "" ?
                        SvgPicture.asset(ImageString.imgPlaceHolder, height: 8.h) :
                        products.itemName!.contains("Installation (1st & 2nd fix)") ?
                        Lottie.asset('assets/lottie/gear.json', height: 9.h,)
                        : ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network("${ImageBaseUrl.productImageBaseUrl}${products.productImage}",height: 8.h),
                        )*/
                    ),
                    Expanded(flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(flex: 4,
                                  child: Text("${products.quantity} items", style: CustomTextStyle.labelText)),
                              Expanded(flex: 2,
                                  child: Text("£${products.amountPrice.formatAmount()}",
                                      style:  GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.normal,
                                              color: AppColors.primaryColor))))
                            ],
                          ),
                          SizedBox(height: 1.h),
                          Text("${products.itemName}",style: CustomTextStyle.labelText),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )

        ),
      )
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
                double subTotal = 0.0;
                double disc = 0.0;
                double profit = 0.0;
                double grandTotal = 0.0;
                double vatTotal = 0.0;
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
                          child: TextButton(
                            onPressed: () => Navigator.pop(context),
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
                                  valueBool: Provider.of<WidgetChange>(context, listen: false).isDeposit),
                              SizedBox(width: 5.w),
                              Text(Provider.of<WidgetChange>(context, listen: false).isDeposit ? LabelString.lblDeposit : LabelString.lblNoDeposit, style: CustomTextStyle.labelText)
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
                              callCreateQuoteAPI(subTotal, grandTotal, disc,
                                  selectTemplateOption, vatTotal,
                                  profit, depositAmountController.text, state.productList,
                                  depositValue, termsSelect);
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
      List<ProductsList> productList, String depositValue, String termsSelect ) async {
    String? street, city, country, code;
    SharedPreferences preferences = await SharedPreferences.getInstance();

    if(widget.siteAddress.toString() != "{}"){
      street = widget.siteAddress["address"].toString().replaceAll("\n", ", ");
      city = widget.siteAddress["city"];
      country = widget.siteAddress["country"];
      code = widget.siteAddress["postcode"];
    }else {
      street = widget.shipStreet == "" ? " " : widget.shipStreet;
      city = widget.shipCity == "" ? " " : widget.shipCity;
      country = widget.shipCountry == "" ? " " : widget.shipCountry;
      code = widget.shipCode == "" ? " " : widget.shipCode;
    }
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
        //widget.siteAddress.toString() == "{}"

        billStreet : widget.billStreet == "" ? " " : widget.billStreet, //  todo add installation as ship address if site address selected
        //shipStreet : widget.shipStreet == "" ? " " : widget.shipStreet,
        shipStreet : street,
        billCity : widget.billCity == "" ? " " : widget.billCity,
        //shipCity : widget.shipCity == "" ? " " : widget.shipCity,
        shipCity: city,
        billCountry : widget.billCountry == "" ? " " : widget.billCountry,
        //shipCountry : widget.shipCountry == "" ? " " : widget.shipCountry,
        shipCountry: country,
        billCode : widget.billCode == "" ? " " : widget.billCode,
        //shipCode : widget.shipCode == "" ? " " : widget.shipCode,
        shipCode: code,
        description : Message.descriptionForQuote,
        termsConditions : termsSelect  == "50% Deposit Balance on Account(Agreed terms)"
            ? Message.termsCondition1
            : Message.termsCondition2,
        preTaxTotal : vatTotal.toString(),
        hdnSHPercent : "0",
        siteAddressId : widget.siteAddress["id"] == "" ? "" : widget.siteAddress["id"],
        quotesTerms : widget.termsItemSelection,
        hdnprofitTotal : profit.toString(),
        markup : "0.00",
        issueNumber : "1",
        gradeNumber : widget.gradeFireSelect,
        systemType : widget.systemTypeSelect,
        signallingType : widget.signallingTypeSelect,
        premisesType : widget.premisesTypeSelect,
        projectManager : preferences.getString(PreferenceString.userId).toString(),
        quotesEmail : widget.contactEmail,
        quotesTemplateOptions : selectTemplateOption,
        quoteRelatedId : "0",
        quotesCompany : widget.contactCompany,
        installation : "0",
        hdnsubTotal : subTotal.toString(),
        hdndiscountTotal : disc.toString(),
        quoteMobileNumber : widget.mobileNumber,
        quoteTelephoneNumber : widget.telephoneNumber,
        isQuotesConfirm : "0",
        quotesPayment : depositValue== "false" || depositValue== "" ? "No Deposit" : "Deposit",
        isQuotesPaymentConfirm : "0",
        quotesDepositeAmount : depositAmount,
        quotesDepoReceivedAmount : "0.00",
        quoteEmailReminder : isEmailRemind ? "1" : "0" ,
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
          sequenceNo: productList.indexOf(e).toString(), //todo set sequence number as per item index
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
          productLocation: e.selectLocation,
          productLocationTitle: e.titleLocation, //todo add title with join ###product_title
          costprice: e.costPrice,
          extQty: "0",
          requiredDocument: "Keyholder form###Maintenance contract###Police application###Direct Debit",

          /*
            "product_nss_keyholder_form": "1",  Keyholder form
            "product_security_agree_form": "0", Maintenance contract
            "product_police_app_form": "0", Police application
            "product_direct_debit_form": "0", Direct Debit
           */

          proShortDescription: e.description,
          proName: e.itemName.toString()
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