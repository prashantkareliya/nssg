import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nssg/components/custom_button.dart';
import 'package:nssg/constants/navigation.dart';
import 'package:nssg/screens/qoute/bloc/product_list_bloc.dart';
import 'package:nssg/screens/qoute/get_product/product_datasource.dart';
import 'package:nssg/utils/extention_text.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../../components/custom_radio_button.dart';
import '../../../components/custom_text_styles.dart';
import '../../../components/global_api_call.dart';
import '../../../components/svg_extension.dart';
import '../../../constants/constants.dart';
import '../../../constants/strings.dart';
import '../../../httpl_actions/handle_api_error.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/helpers.dart';
import '../../../utils/widgetChange.dart';
import '../../../utils/widgets.dart';
import '../get_product/product_bloc_dir/get_product_bloc.dart';
import '../get_product/product_model_dir/get_product_response_model.dart';
import '../get_product/product_repository.dart';
import '../models/products_list.dart';
import 'build_item_screen.dart';
import 'select_location_dialog.dart';

///Second step to create quote
class AddItemDetail extends StatefulWidget {
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

  AddItemDetail(
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
      this.termsList,
      this.contactEmail,
      this.siteAddress,
      {super.key});

  @override
  // ignore: no_logic_in_create_state
  State<AddItemDetail> createState() => _AddItemDetailState(
      eAmount,
      systemTypeSelect,
      quotePaymentSelection,
      contactSelect,
      premisesTypeSelect,
      termsItemSelection,
      gradeFireSelect,
      signallingTypeSelect,
      engineerNumbers,
      timeType,
      billStreet,
      billCity,
      billCountry,
      billCode,
      shipStreet,
      shipCity,
      shipCountry,
      shipCode,
      contactId,
      contactCompany,
      mobileNumber,
      telephoneNumber,
      termsList,
      contactEmail,
      (siteAddress ?? {}) as Map);
}

class _AddItemDetailState extends State<AddItemDetail> {
  PageController pageController = PageController();
  Future<dynamic>? getItemDetailFields;

  List<Result>? productItems = [];
  List<Result>? filterList = [];
  List<String>? locList = [];

  TextEditingController sellingPriceController = TextEditingController();
  List<TextEditingController> discountPriceController = [];

  String manufactureSelect = "";
  String systemTypeItemProductSelect = "";
  String categorySelect = "";
  String page = "0";

  List itemNumber = [];

  String? locations;
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
  _AddItemDetailState(
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
      this.termsList,
      this.contactEmail,
      this.siteAddress);

  @override
  void initState() {
    super.initState();
    getProduct();
    var profit = (double.parse("450") - 80.0).formatAmount();
    var productList = context.read<ProductListBloc>().state.productList.firstWhereOrNull((element) =>
    element.itemId == "123456");
    if(productList == null){
      context.read<ProductListBloc>().add(
          AddProductToListEvent(productsList: ProductsList(
          itemId:  "123456",
          productId: "1188",
          itemName: 'Installation (1st & 2nd fix)',
          costPrice: '80.00',
          sellingPrice: "450",
          quantity: 1,
          discountPrice: "0",
          amountPrice: "450",
          profit: profit,
          description: "Installation of all devices, commission and handover Monday - Friday 8.00am - 5.00pm",
          productImage: ImageString.imgDemo,
      )));
    }
  }

  List<RadioModel> manufacturingType = <RadioModel>[]; //step 1
  List<RadioModel> systemTypeItem = <RadioModel>[]; //step 2
  List<RadioModel> categoryType = <RadioModel>[]; //step 3

  GetProductBloc productBloc =
      GetProductBloc(ProductRepository(productDatasource: ProductDatasource()));
  bool isLoading = false;

  Future<void> getProduct() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    Map<String, dynamic> queryParameters = {
      'operation': "query",
      'sessionName':
          preferences.getString(PreferenceString.sessionName).toString(),
      'query': Constants.of().apiKeyProduct
    };
    productBloc.add(GetProductListEvent(queryParameters));
  }
//3400+4256+7904.87
  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: AppBar(
          backgroundColor: AppColors.whiteColor,
          elevation: 1,
          centerTitle: true,
          automaticallyImplyLeading: false,
          leadingWidth: 12.w,
          leading: InkWell(
            highlightColor: AppColors.transparent,
            splashColor: AppColors.transparent,
            onTap: () {
              if(page == "0" || page == "1"){
                Navigator.pop(context);
              }else{
                pageController.previousPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.decelerate);
              }
            },
            child: Icon(Icons.arrow_back_ios_outlined,
                color: AppColors.blackColor, size: 14.sp),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(),
              Text(LabelString.lblItemDetail, style: CustomTextStyle.labelBoldFontText),
              InkWell(
                splashColor: AppColors.transparent,
                highlightColor: AppColors.transparent,
                onTap: () => goToCartPage(),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Padding(
                        padding: EdgeInsets.all(12.sp),
                        child: Image.asset(ImageString.imgCart, width: 6.0.w)),
                    itemNumber.isEmpty ? Container()
                        : Positioned(
                          top: 10.sp, right: 5.sp,
                          child: Container(
                          height: 2.h,
                          width: 4.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: AppColors.redColor),
                          child: Center(
                              child: Text(itemNumber.length.toString(),
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.roboto(
                                      textStyle: TextStyle(
                                          color: AppColors.whiteColor,
                                          fontSize: 8.sp))))),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        body: PageView(
          scrollDirection: Axis.horizontal,
          pageSnapping: true,
          physics: manufactureSelect.isEmpty
              ? const NeverScrollableScrollPhysics()
              : const BouncingScrollPhysics(),
          controller: pageController,
          onPageChanged: (number) {
            Provider.of<WidgetChange>(context, listen: false).pageNumber(number.toString());
            page = Provider.of<WidgetChange>(context, listen: false).pageNo;
          },
          children: [
            // manufacturing view
            buildStepZeroItem(context, query),

            // systemType view
            //buildStepOneItem(context, query, fieldsData),

            // category view
            buildStepTwoItem(context, query),

            //products view
            buildStepThreeItem(context, query)
          ],
        ));
  }

  ///step 1
  buildStepZeroItem(context, Size query) {
    Provider.of<WidgetChange>(context).isSelectManufacture;
    return FutureBuilder<dynamic>(
      future: getItemFields(
          widget.systemTypeSelect == "Intruder & Hold Up Alarm: PD6662:2017"
              ? widget.systemTypeSelect.toString().replaceAll("&", "%26")
              : widget.systemTypeSelect.toString().replaceAll("+", " "),
          ""),
      builder: (context, snapshotOne) {
        if (snapshotOne.hasData) {
          var fieldsData = snapshotOne.data["result"];
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding:
                  EdgeInsets.only(right: 12.sp, left: 12.sp, bottom: 12.sp),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(height: 4.h),
                  Text(LabelString.lblManufacturing,
                      style: CustomTextStyle.labelBoldFontText),
                  SizedBox(height: 4.h),

                  Wrap(
                    spacing: 15.sp,
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.spaceBetween,
                    runSpacing: 15.sp,
                    children: List.generate(
                      fieldsData["product_manufacturer"].length,
                      (index) {
                        manufacturingType.add(RadioModel(false, fieldsData["product_manufacturer"][index]["label"]));
                        return InkWell(
                          onTap: () {
                            for (var element in manufacturingType) {
                              element.isSelected = false;
                            }

                            Provider.of<WidgetChange>(context, listen: false).isManufacture();
                            manufacturingType[index].isSelected = true;

                            if (manufactureSelect.isEmpty) {
                              manufactureSelect = fieldsData["product_manufacturer"][index]["label"];
                            } else {
                              manufactureSelect = "";
                              manufactureSelect = fieldsData["product_manufacturer"][index]["label"];
                            }
                            pageController.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.decelerate);
                          },
                          child: Container(
                            height: 15.h,
                            width: 42.w,
                            decoration: BoxDecoration(
                                color: manufacturingType[index].isSelected
                                    ? AppColors.primaryColorLawOpacity
                                    : AppColors.whiteColor,
                                border: Border.all(
                                    color: manufacturingType[index].isSelected
                                        ? AppColors.primaryColor
                                        : AppColors.borderColor,
                                    width: 1),
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(height: 1.h),
                                      SvgExtension(
                                          iconColor: manufacturingType[index].isSelected
                                              ? AppColors.primaryColor
                                              : AppColors.blackColor,
                                          itemName:
                                              fieldsData["product_manufacturer"][index]["label"].toString()),
                                      SizedBox(height: 1.h),
                                      SizedBox(
                                        width: query.width * 0.3,
                                        child: Text(
                                            fieldsData["product_manufacturer"][index]["label"],
                                            textAlign: TextAlign.center,
                                            style: manufacturingType[index].isSelected
                                                ? CustomTextStyle.commonTextBlue
                                                : CustomTextStyle.commonText),
                                      ),
                                      SizedBox(height: 1.h),
                                    ]),
                                Visibility(
                                  visible: manufacturingType[index].isSelected
                                      ? true : false,
                                  child: Positioned(
                                    right: 10, top: 5,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(80.0),
                                          color: AppColors.greenColor),
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Icon(Icons.done,
                                            color: AppColors.whiteColor,
                                            size: 14.sp),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (snapshotOne.hasError) {
          final message = HandleAPI.handleAPIError(snapshotOne.error);
          return Text(message);
        }
        return SizedBox(height: 70.h, child: loadingView());
      },
    );
  }

  // Design category view
  ///step 3
  FutureBuilder buildStepTwoItem(context, Size query) {
    Provider.of<WidgetChange>(context).isSelectCategoryItemDetail;
    return FutureBuilder(
        future: getItemFields(
            widget.systemTypeSelect == "Intruder & Hold Up Alarm: PD6662:2017"
                ? widget.systemTypeSelect.toString().replaceAll("&", "%26")
                : widget.systemTypeSelect.toString().replaceAll("+", " "),
            manufactureSelect),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var stepThreeData = snapshot.data["result"];
            /*if(stepThreeData["product_prod_category"].length == 0){
              pageController.jumpToPage(2);
            }*/
            return SingleChildScrollView(
              child: Padding(
                padding:
                    EdgeInsets.only(right: 12.sp, left: 12.sp, bottom: 12.sp),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: 4.h),
                    Text(LabelString.lblCategory,
                        style: CustomTextStyle.labelBoldFontText),
                    SizedBox(height: 4.h),
                    stepThreeData["product_prod_category"].length == 0 ?
                    Center(
                        child: Column(
                          children: [
                            Text(LabelString.lblNoData,
                                style: CustomTextStyle.labelBoldFontText),
                            SizedBox(height: 2.h),
                            SizedBox(

                              height: query.height * 0.06,
                              child: CustomButton(title: "See Products",
                                buttonColor: AppColors.primaryColor,
                                onClick: (){
                                pageController.nextPage(
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.decelerate);
                              },),
                            )
                          ],
                        ))
                        : Wrap(
                      spacing: 15.sp,
                      direction: Axis.horizontal,
                      alignment: WrapAlignment.spaceBetween,
                      runSpacing: 15.sp,
                      children: List.generate(
                        stepThreeData["product_prod_category"].length,
                        (index) {

                          categoryType.add(RadioModel(false, stepThreeData["product_prod_category"][index]["label"]));

                          return InkWell(
                            onTap: () {
                              for (var element in categoryType) {
                                element.isSelected = false;
                              }

                              Provider.of<WidgetChange>(context, listen: false).isCategoryItemDetail();
                              categoryType[index].isSelected = true;

                              filterList!.clear();
                              if (categorySelect.isEmpty) {
                                categorySelect = stepThreeData["product_prod_category"][index]["label"];
                              } else {
                                categorySelect = "";
                                categorySelect = stepThreeData["product_prod_category"][index]["label"];
                              }

                              if (categoryType.isNotEmpty) {
                                pageController.nextPage(
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.decelerate);
                              }
                            },
                            child: Container(
                              height: 15.h,
                              width: 42.w,
                              decoration: BoxDecoration(
                                  color: categoryType[index].isSelected
                                      ? AppColors.primaryColorLawOpacity
                                      : AppColors.whiteColor,
                                  border: Border.all(
                                      color: categoryType[index].isSelected
                                          ? AppColors.primaryColor
                                          : AppColors.borderColor,
                                      width: 1),
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(height: 1.h),
                                        SvgExtension(
                                            iconColor: categoryType[index].isSelected
                                                    ? AppColors.primaryColor : AppColors.blackColor,
                                            itemName: categoryType[index].buttonText),
                                        SizedBox(height: 1.h),
                                        SizedBox(
                                          width: query.width * 0.3,
                                          child: Text(
                                              categoryType[index].buttonText,
                                              textAlign: TextAlign.center,
                                              style: categoryType[index].isSelected
                                                  ? CustomTextStyle.commonTextBlue
                                                  : CustomTextStyle.commonText),
                                        ),
                                        SizedBox(height: 1.h),
                                      ]),
                                  Visibility(
                                    visible: categoryType[index].isSelected
                                        ? true : false,
                                    child: Positioned(
                                      right: 10,
                                      top: 5,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(80.0),
                                            color: AppColors.greenColor),
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Icon(Icons.done,
                                              color: AppColors.whiteColor,
                                              size: 14.sp),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            final message = HandleAPI.handleAPIError(snapshot.error);
            return Text(message);
          }
          return SizedBox(height: 70.h, child: loadingView());
        });
  }

  // Item category view
  ///step 4
  Widget buildStepThreeItem(BuildContext context, Size query) {
    return BlocListener<GetProductBloc, GetProductState>(
      bloc: productBloc,
      listener: (context, state) {
        if (state is ProductLoadedFail) {
          Helpers.showSnackBar(context, state.error.toString());
        }
      },
      child: BlocBuilder<GetProductBloc, GetProductState>(
        bloc: productBloc,
        builder: (context, state) {
          if (state is ProductLoadingState) {
            isLoading = state.isBusy;
          }
          if (state is ProductLoadedState) {
            isLoading = false;
            productItems = state.productList;
            filterList!.clear();
            for (var element in productItems!) {
              if(categorySelect.isEmpty){
                if(element.productManufacturer!.contains(manufactureSelect) &&
                    widget.systemTypeSelect!.contains(systemTypeItemProductSelect)){
                  filterList!.add(element);
                }
              }else {
                if (element.productManufacturer!.contains(manufactureSelect) &&
                    widget.systemTypeSelect!.contains(systemTypeItemProductSelect) &&
                    element.productProdCategory!.contains(categorySelect) != false) {
                  filterList!.add(element);
                }
              }

            }
          }
          if (state is ProductLoadedFail) {
            isLoading = false;
          }
          if (filterList!.isEmpty) {
            return Center(
                child: Text(LabelString.lblNoData,
                    style: CustomTextStyle.labelBoldFontText));
          } else {

            return ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(vertical: 10.sp),
                  physics: const BouncingScrollPhysics(),
                  itemCount: filterList!.length,
                  itemBuilder: (context, index) {
                    discountPriceController.add(TextEditingController());

                    double amount = (double.parse(filterList![index].unitPrice.toString()) *
                        double.parse(filterList![index].quantity.toString()) -
                        double.parse(discountPriceController[index].text == ""
                            ? "0"
                            : discountPriceController[index].text));

                    double profit = ((double.parse(filterList![index].unitPrice!) - double.parse(
                            filterList![index].costPrice.toString())) *
                        (filterList![index].quantity!) -
                        double.parse(discountPriceController[index].text == ""
                            ? "0"
                            : discountPriceController[index].text));
                    return BlocConsumer<ProductListBloc, ProductListState>(
                      listener: (context, state) {},
                      builder: (context, productState) {
                        final bool isItemAdded = productState.productList
                            .firstWhereOrNull((element) =>
                        element.productId == filterList![index].id) != null;
                        print("@@@@@@@@@@@@@@@@@ ${filterList![index].imagename!.replaceAll("&ndash;", "–")}");
                        return Padding(
                          padding: EdgeInsets.only(left: 12.sp, right: 12.sp),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.sp),
                                border: Border.all(
                                    color: AppColors.borderColor, width: 1),
                                color: AppColors.whiteColor),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(width: 2.w),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: filterList![index].imagename == "" ?
                                  SvgPicture.asset(ImageString.imgPlaceHolder, height: 8.h, width: 16.w) :
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Container(
                                        color: AppColors.backWhiteColor,
                                        child: Padding(
                                          padding: EdgeInsets.all(4.sp),
                                          child: Image.network("${ImageBaseUrl.productImageBaseUrl}${filterList![index].imagename!.replaceAll("&ndash;", "–")}",
                                          height: 9.h, width: 18.w),
                                        ),
                                      ))
                                ),
                                SizedBox(width: 5.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 1.5.h),
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                                text: filterList![index].productname.toString(),
                                                style: CustomTextStyle.labelBoldFontText),
                                            WidgetSpan(
                                              child: InkWell(
                                                splashColor: AppColors.transparent,
                                                highlightColor:
                                                AppColors.transparent,
                                                onTap: () {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return Dialog(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(10)),
                                                          elevation: 0,
                                                          insetPadding:EdgeInsets.symmetric(horizontal: 12.sp),
                                                          child: itemDescription(
                                                              filterList![index].productname.toString(),
                                                              filterList![index].description.toString()));
                                                    },
                                                  );
                                                },
                                                child: Icon(
                                                    Icons.info_outline,
                                                    color: AppColors.primaryColor,
                                                    size: 14.sp),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 2.h),
                                      Row(
                                        children: [
                                          Container(
                                            //  width: query.width * 0.40,
                                            height: 5.h,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(8.0),
                                                border: Border.all(
                                                    color: AppColors.primaryColor,
                                                    width: 1),
                                                color: AppColors.primaryColor),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                              children: [
                                                IconButton(
                                                    onPressed: () {
                                                      if (isItemAdded) {
                                                        context.read<ProductListBloc>().add(
                                                            UpdateProductQuantityByIdEvent(
                                                                productId: filterList![index].id!,
                                                                quantity: filterList![index].quantity! - 1));
                                                      }
                                                      filterList![index].isItemAdded = false;
                                                      if (filterList![index].quantity! >= 2) {
                                                        Provider.of<WidgetChange>(context, listen: false).incrementCounter();
                                                        filterList![index].quantity = filterList![index].quantity! - 1;
                                                      }
                                                      //itemNumber.remove(filterList![index].id);
                                                    },
                                                    icon: Icon(Icons.remove,
                                                        color: AppColors.whiteColor,
                                                        size: 12.sp)),
                                                Container(
                                                    color: AppColors.whiteColor,
                                                    width: query.width * 0.15,
                                                    height: query.height,
                                                    child: Center(
                                                        child: Text(
                                                            "${filterList![index].quantity}",
                                                            style: CustomTextStyle
                                                                .labelBoldFontText))),
                                                IconButton(
                                                    onPressed: () {
                                                      if (isItemAdded) {
                                                        context.read<ProductListBloc>().add(
                                                            UpdateProductQuantityByIdEvent(
                                                                productId:filterList![index].id!,
                                                                quantity: filterList![index].quantity! +1));
                                                      }
                                                      filterList![index].isItemAdded = false;
                                                      Provider.of<WidgetChange>(context, listen: false).incrementCounter();
                                                      filterList![index].quantity = filterList![index].quantity! + 1;
                                                      // itemNumber.add(filterList![index].id);
                                                    },
                                                    icon: Icon(Icons.add,
                                                        color: AppColors.whiteColor,
                                                        size: 12.sp))
                                              ],
                                            ),
                                          ),
                                          SizedBox(width: 3.w),
                                          InkWell(
                                            onTap: isItemAdded
                                                ? () {
                                              context.read<ProductListBloc>().add(RemoveProductFromCardByIdEvent(productId: filterList![index].id ?? ""));
                                              setState(() {
                                                itemNumber.remove(filterList![index].id);
                                              });
                                            }
                                                : () {

                                              List<String> documentType = [];

                                              if (filterList![index].productNssKeyholderForm == "1") {
                                                documentType.add("Keyholder form");
                                                if (filterList![index].productSecurityAgreeForm == "1") {
                                                  documentType.add("Maintenance contract");
                                                  if (filterList![index].productPoliceAppForm == "1") {
                                                    documentType.add("Maintenance contract");
                                                    if (filterList![index].productDirectDebitForm == "1") {
                                                      documentType.add("Direct Debit");
                                                    }
                                                  }
                                                }
                                                print((documentType).join('###'));
                                              }

                                              ProductsList productsList = ProductsList(
                                                  itemId: DateTime.now().millisecondsSinceEpoch.toString(),
                                                  productId: filterList![index].id.toString(),
                                                  itemName: filterList![index].productname.toString(),
                                                  costPrice: filterList![index].costPrice.toString(),
                                                  sellingPrice: sellingPriceController.text.isEmpty?
                                                  filterList![index].unitPrice : sellingPriceController.text,
                                                  discountPrice: discountPriceController[index].text.toString(),
                                                  amountPrice: amount.toString(),
                                                  profit: profit.toString(),
                                                  quantity: filterList![index] .quantity,
                                                  description: filterList![index] .description,
                                                  selectLocation: (filterList![index].locationList ?? []).join('###'),
                                                  titleLocation: (filterList![index].titleLocationList ?? []).join("###"),
                                                  itemAdd: filterList![index].isItemAdded,
                                                productImage: filterList![index].imagename,
                                                requiredDocument: (documentType).join('###'),
                                              );
                                              context.read<ProductListBloc>().add(AddProductToListEvent(productsList: productsList));
                                              //Helpers.showSnackBar(context, "Item Added", isError: false);
                                              setState(() {
                                                itemNumber.add(filterList![index].id);
                                              });
                                            },
                                            child: isItemAdded
                                                ? Container(
                                                height: 5.h, width: 10.w,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(8.0),
                                                    border: Border.all(color: AppColors.greenColorAccent,
                                                        width: 1),
                                                    color: AppColors.greenColorAccent),
                                                child: SvgPicture.asset(ImageString.icAddCartGreen,
                                                    fit: BoxFit.none))
                                                : Container(
                                                height: 5.h, width: 10.w,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(8.0),
                                                    border: Border.all(color: AppColors.primaryColor,
                                                        width: 1),
                                                    color: AppColors.primaryColor),
                                                child: SvgPicture.asset(ImageString.icAddCart,
                                                    fit: BoxFit.none)),
                                          )
                                        ],
                                      ),
                                      InkWell(
                                        onTap: () {
                                          if(isItemAdded){
                                            context.read<ProductListBloc>().add(RemoveProductFromCardByIdEvent(productId: filterList![index].id ?? ""));
                                            setState(() {
                                              itemNumber.remove(filterList![index].id);
                                            });
                                          }
                                          showDialog(
                                            barrierDismissible: true,
                                            context: context,
                                            builder: (context) {
                                              ///Make new class for dialog
                                              return Dialog(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(10)),
                                                  insetPadding:
                                                  EdgeInsets.symmetric(horizontal: 8.sp),
                                                  child: SelectLocation(
                                                      filterList![index].quantity,
                                                      filterList![index].productname,
                                                      filterList![index].locationList,
                                                      filterList![index].titleLocationList));
                                            },
                                          ).then((value) {
                                            if (value != null) {
                                              if (value is List) {
                                                Result r = filterList![index];
                                                r.locationList = value[0] as List<String>?;
                                                r.titleLocationList = value[1] as List<String>?;
                                                filterList![index] = r;
                                              }
                                            }
                                          });
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              top: 10.sp, bottom: 10.sp),
                                          child: Text(LabelString.lblSelectLocation,
                                              style:
                                              CustomTextStyle.commonTextBlue),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Container(height: 10.sp);
                  },
                ),

                Padding(padding: EdgeInsets.all(12.sp),
                  child: SizedBox(
                      height: query.height * 0.06,
                      child: CustomButton(
                          title: ButtonString.btnViewCart,
                          buttonColor: AppColors.primaryColor,
                          onClick: () => goToCartPage())
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  //Item Description dialog
  Widget itemDescription(String productName, String description) {
    return Padding(
      padding: EdgeInsets.only(left: 15.sp, bottom: 16.sp),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(LabelString.lblDescription,
                    style: CustomTextStyle.labelBoldFontText),
                IconButton(
                    highlightColor: AppColors.transparent,
                    splashColor: AppColors.transparent,
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.close_rounded, color: AppColors.blackColor)),
              ],
            ),
            SizedBox(height: 2.h),
            Text(productName, style: CustomTextStyle.labelBoldFontText),
            SizedBox(height: 3.h),
            Text(description == "" ? LabelString.lblNoData : description,
                style: CustomTextStyle.labelText),
          ],
        ),
      ),
    );
  }

  //Method for move in cart page
  void goToCartPage() {
    callNextScreen(
        context,
        BuildItemScreen(
            eAmount,
            systemTypeSelect,
            quotePaymentSelection,
            contactSelect,
            premisesTypeSelect,
            termsItemSelection,
            gradeFireSelect,
            signallingTypeSelect,
            engineerNumbers,
            timeType,
            billStreet,
            billCity,
            billCountry,
            billCode,
            shipStreet,
            shipCity,
            shipCountry,
            shipCode,
            contactId,
            contactCompany,
            mobileNumber,
            telephoneNumber,
            termsList,
            contactEmail,
            siteAddress));
  }
}