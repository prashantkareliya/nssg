import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nssg/components/custom_appbar.dart';
import 'package:nssg/screens/qoute/get_product/product_datasource.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../../components/custom_button.dart';
import '../../components/custom_radio_button.dart';
import '../../components/custom_text_styles.dart';
import '../../components/global_api_call.dart';
import '../../components/svg_extension.dart';
import '../../constants/constants.dart';
import '../../constants/strings.dart';
import '../../httpl_actions/handle_api_error.dart';
import '../../utils/app_colors.dart';
import '../../utils/helpers.dart';
import '../../utils/widgetChange.dart';
import '../../utils/widgets.dart';
import 'get_product/product_bloc_dir/get_product_bloc.dart';
import 'get_product/product_model_dir/get_product_response_model.dart';
import 'get_product/product_repository.dart';
import 'item_detail.dart';

///Class for add item detail
class AddItemDetail extends StatefulWidget {
  const AddItemDetail({Key? key}) : super(key: key);

  @override
  State<AddItemDetail> createState() => _AddItemDetailState();
}

class _AddItemDetailState extends State<AddItemDetail> {
  PageController pageController = PageController();
  List<Result>? productItems = [];
  List<Result>? filterList = [];

  Future<dynamic>? getItemFields;

  TextEditingController sellingPriceController = TextEditingController();
  TextEditingController discountPriceController = TextEditingController();

  String manufactureSelect = "";
  String systemTypeItemProductSelect = "";
  String categorySelect = "";

  List<RadioModel> manufacturingType = <RadioModel>[]; //step 1
  List<RadioModel> systemTypeItem = <RadioModel>[]; //step 2
  List<RadioModel> categoryType = <RadioModel>[]; //step 3

  int itemNumber = 1;

  @override
  void initState() {
    super.initState();
    getProduct();
  }

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

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    getItemFields = getQuoteFields("Products");

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
      body: FutureBuilder<dynamic>(
        future: getItemFields,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var fieldsData = snapshot.data["result"];
            return PageView(
              scrollDirection: Axis.horizontal,
              pageSnapping: true,
              physics: const BouncingScrollPhysics(),
              controller: pageController,
              onPageChanged: (number) {},
              children: [
                buildStepZero(context, query, fieldsData), // category view
                buildStepOne(context, query, fieldsData), // category view
                buildStepTwo(context, query, fieldsData), //Sub-category view
                buildStepThree(context, query)
              ],
            );
          } else if (snapshot.hasError) {
            final message = HandleAPI.handleAPIError(snapshot.error);
            return Text(message);
          }
          return SizedBox(height: 70.h, child: loadingView());
        },
      ),
    );
  }

  ///step 1
  buildStepZero(context, Size query, stepOneData) {
    List dataMfg = stepOneData["manufacturer"];
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16.sp),
          child: Text(LabelString.lblManufacturing,
              style: CustomTextStyle.labelBoldFontText),
        ),
        Wrap(
          spacing: 15.sp,
          direction: Axis.horizontal,
          alignment: WrapAlignment.center,
          runSpacing: 14.sp,
          children: List.generate(
            dataMfg.getRange(20, 22).toList().length,
            (index) {
              manufacturingType.add(RadioModel(
                  false, dataMfg.getRange(20, 22).toList()[index]["label"]));
              return InkWell(
                onTap: () {
                  for (var element in manufacturingType) {
                    element.isSelected = false;
                  }

                  //Provider.of<WidgetChange>(context, listen: false).isManufacture();
                  manufacturingType[index].isSelected = true;
                  //Provider.of<WidgetChange>(context, listen: false).isSelectManufacture;
                  setState(() {});

                  if (manufactureSelect.isEmpty) {
                    manufactureSelect =
                        dataMfg.getRange(20, 22).toList()[index]["label"];
                  } else {
                    manufactureSelect = "";
                    manufactureSelect =
                        dataMfg.getRange(20, 22).toList()[index]["label"];
                  }

                  if (manufacturingType.isNotEmpty) {
                    pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.decelerate);
                  }
                },
                child: Container(
                  height: 15.h,
                  width: query.width / 1.13,
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgExtension(
                                iconColor: manufacturingType[index].isSelected
                                    ? AppColors.primaryColor
                                    : AppColors.blackColor,
                                itemName: dataMfg
                                    .getRange(20, 22)
                                    .toList()[index]["label"]),
                            SizedBox(height: 1.h),
                            Text(
                                dataMfg.getRange(20, 22).toList()[index]
                                    ["label"],
                                style: manufacturingType[index].isSelected
                                    ? CustomTextStyle.commonTextBlue
                                    : CustomTextStyle.commonText)
                          ]),
                      Visibility(
                        visible:
                            manufacturingType[index].isSelected ? true : false,
                        child: Positioned(
                          right: 10,
                          top: 5,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(80.0),
                                color: AppColors.greenColor),
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Icon(Icons.done,
                                  color: AppColors.whiteColor, size: 14.sp),
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
    );
  }

  // Design category view
  ///step 2
  SingleChildScrollView buildStepOne(context, Size query, stepTwoData) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.sp),
            child: Text(LabelString.lblSystemType,
                style: CustomTextStyle.labelBoldFontText),
          ),
          Wrap(
            spacing: 15.sp,
            direction: Axis.horizontal,
            alignment: WrapAlignment.center,
            runSpacing: 14.sp,
            children: List.generate(
              stepTwoData["productcategory"].length,
              (index) {
                systemTypeItem.add(RadioModel(
                    false, stepTwoData["productcategory"][index]["label"]));
                return Container(
                  height: 15.h,
                  width: query.width / 1.13,
                  decoration: BoxDecoration(
                      color: systemTypeItem[index].isSelected
                          ? AppColors.primaryColorLawOpacity
                          : AppColors.whiteColor,
                      border: Border.all(
                          color: systemTypeItem[index].isSelected
                              ? AppColors.primaryColor
                              : AppColors.borderColor,
                          width: 1),
                      borderRadius: BorderRadius.circular(10.0)),
                  child: InkWell(
                    onTap: () {
                      for (var element in systemTypeItem) {
                        element.isSelected = false;
                      }

                      //Provider.of<WidgetChange>(context, listen: false).isSystemTypeItemDetail();
                      systemTypeItem[index].isSelected = true;
                      //Provider.of<WidgetChange>(context, listen: false).isSelectSystemTypeItemDetail;

                      setState(() {});
                      filterList!.clear();
                      if (systemTypeItemProductSelect.isEmpty) {
                        systemTypeItemProductSelect =
                            stepTwoData["productcategory"][index]["label"];
                      } else {
                        systemTypeItemProductSelect = "";
                        systemTypeItemProductSelect =
                            stepTwoData["productcategory"][index]["label"];
                      }

                      if (systemTypeItem.isNotEmpty) {
                        pageController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.decelerate);
                      }
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgExtension(
                                  iconColor: systemTypeItem[index].isSelected
                                      ? AppColors.primaryColor
                                      : AppColors.blackColor,
                                  itemName: stepTwoData["productcategory"]
                                      [index]["label"]),
                              SizedBox(height: 1.h),
                              Text(
                                  stepTwoData["productcategory"][index]
                                      ["label"],
                                  style: systemTypeItem[index].isSelected
                                      ? CustomTextStyle.commonTextBlue
                                      : CustomTextStyle.commonText)
                            ]),
                        Visibility(
                          visible:
                              systemTypeItem[index].isSelected ? true : false,
                          child: Positioned(
                            right: 10,
                            top: 5,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(80.0),
                                  color: AppColors.greenColor),
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Icon(Icons.done,
                                    color: AppColors.whiteColor, size: 14.sp),
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
    );
  }

  // Design sub-category view
  ///step 3
  SingleChildScrollView buildStepTwo(context, Size query, stepThreeData) {
    List categoryData = stepThreeData["sub_category"];

    return SingleChildScrollView(
      child: Column(
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
              categoryData.length,
              (index) {
                categoryType
                    .add(RadioModel(false, categoryData[index]["label"]));

                return InkWell(
                  onTap: () {
                    for (var element in categoryType) {
                      element.isSelected = false;
                    }

                    //Provider.of<WidgetChange>(context, listen: false).isCategoryItemDetail();
                    categoryType[index].isSelected = true;
                    //Provider.of<WidgetChange>(context, listen: false).isSelectCategoryItemDetail;

                    setState(() {});
                    filterList!.clear();
                    if (categorySelect.isEmpty) {
                      categorySelect =
                          stepThreeData["sub_category"][index]["label"];
                    } else {
                      categorySelect = "";
                      categorySelect =
                          stepThreeData["sub_category"][index]["label"];
                    }

                    if (categoryType.isNotEmpty) {
                      pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.decelerate);
                    }
                  },
                  child: Container(
                    height: 15.h,
                    width: query.width / 1.13,
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgExtension(
                                  iconColor: categoryType[index].isSelected
                                      ? AppColors.primaryColor
                                      : AppColors.blackColor,
                                  itemName: categoryData[index]["label"]),
                              SizedBox(height: 1.h),
                              Text(categoryData[index]["label"],
                                  style: categoryType[index].isSelected
                                      ? CustomTextStyle.commonTextBlue
                                      : CustomTextStyle.commonText)
                            ]),
                        Visibility(
                          visible:
                              categoryType[index].isSelected ? true : false,
                          child: Positioned(
                            right: 10,
                            top: 5,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(80.0),
                                  color: AppColors.greenColor),
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Icon(Icons.done,
                                    color: AppColors.whiteColor, size: 14.sp),
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
    );
  }

  // Item listing view
  ///step 4
  buildStepThree(BuildContext context, Size query) {
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
              if (filterList!.isEmpty) {
                if (element.manufacturer!.contains(manufactureSelect) &&
                    element.productcategory!
                        .contains(systemTypeItemProductSelect) &&
                    element.subCategory!.contains(categorySelect)) {
                  filterList!.add(element);
                }
              }
              //filterList!.add(element);
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
            return ListView.separated(
              padding: EdgeInsets.symmetric(vertical: 10.sp),
              physics: const BouncingScrollPhysics(),
              itemCount: filterList!.length,
              itemBuilder: (context, index) {
                var counter = Provider.of<WidgetChange>(context).getCounter;
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
                            Expanded(
                              child: Image.asset("assets/images/demo.png",
                                  height: 15.h),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(right: 10.sp),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Flexible(
                                            flex: 4,
                                            child: Text(
                                                filterList![index]
                                                    .productname
                                                    .toString(),
                                                style: CustomTextStyle
                                                    .labelBoldFontText)),
                                        Flexible(
                                            flex: 1,
                                            child: IconButton(
                                              splashColor:
                                                  AppColors.transparent,
                                              highlightColor:
                                                  AppColors.transparent,
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return Dialog(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        elevation: 0,
                                                        insetPadding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    12.sp),
                                                        child: itemDescription(
                                                            filterList![index]
                                                                .productname
                                                                .toString(),
                                                            filterList![index]
                                                                .description
                                                                .toString()));
                                                  },
                                                );
                                              },
                                              icon: Icon(Icons.info_outline,
                                                  color:
                                                      AppColors.primaryColor),
                                            ))
                                      ],
                                    ),
                                    SizedBox(height: 1.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(LabelString.lblCostPrice,
                                            style: CustomTextStyle.commonText),
                                        Text("£${filterList![index].costPrice}",
                                            style: CustomTextStyle
                                                .labelBoldFontTextSmall)
                                      ],
                                    ),
                                    SizedBox(height: 1.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(LabelString.lblSellingPrice,
                                            style: CustomTextStyle.commonText),
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
                                                    hintText:
                                                        "£${filterList![index].unitPrice.toString().substring(0, 5)}",
                                                    hintStyle: CustomTextStyle
                                                        .labelFontHintText),
                                                textAlign: TextAlign.right,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 1.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(LabelString.lblDiscPrice,
                                            style: CustomTextStyle.commonText),
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
                                                    discountPriceController,
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration:
                                                    InputDecoration.collapsed(
                                                        hintText: "£29.50",
                                                        hintStyle: CustomTextStyle
                                                            .labelFontHintText),
                                                textAlign: TextAlign.right,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 1.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(LabelString.lblAmount,
                                            style: CustomTextStyle.commonText),
                                        Text("£29.50",
                                            style: CustomTextStyle
                                                .labelBoldFontTextSmall)
                                      ],
                                    ),
                                    SizedBox(height: 1.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(LabelString.lblProfit,
                                            style: CustomTextStyle.commonText),
                                        Text("£29.50",
                                            style: CustomTextStyle
                                                .labelBoldFontTextSmall)
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 1.h),
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 13.sp),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    onPressed: () {},
                                    child: Text(
                                        LabelString.lblAttachmentDocument,
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
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              elevation: 0,
                                              insetPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 12.sp),
                                              child: SelectLocation());
                                        },
                                      );
                                    },
                                    child: Text(LabelString.lblSelectLocation,
                                        style: CustomTextStyle.commonTextBlue),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.sp, vertical: 3.sp),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Container(
                                      width: query.width * 0.4,
                                      height: query.height * 0.06,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.sp),
                                          border: Border.all(
                                              width: 1,
                                              color: AppColors.primaryColor)),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 0.sp),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            InkWell(
                                                onTap: () {
                                                  if (itemNumber >= 2) {}
                                                },
                                                child: Icon(Icons.remove,
                                                    color: AppColors.blackColor,
                                                    size: 15.sp)),
                                            Container(
                                                height: query.height * 0.06,
                                                color: AppColors.primaryColor,
                                                width: 0.3.w),
                                            Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10.sp),
                                                child: Text('$itemNumber',
                                                    style: CustomTextStyle
                                                        .labelBoldFontText)),
                                            Container(
                                                height: query.height * 0.06,
                                                color: AppColors.primaryColor,
                                                width: 0.3.w),
                                            InkWell(
                                                onTap: () {},
                                                child: Icon(Icons.add,
                                                    color: AppColors.blackColor,
                                                    size: 15.sp)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 6.w),
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
                        ),
                        SizedBox(height: 1.h),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Container(height: 10.sp);
              },
            );
          }
        },
      ),
    );
  }

  //Item Description dialog
  Widget itemDescription(
    String productName,
    String description,
  ) {
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
                    icon:
                        Icon(Icons.close_rounded, color: AppColors.blackColor)),
              ],
            ),
            SizedBox(height: 2.h),
            Text(productName, style: CustomTextStyle.labelBoldFontText),
            SizedBox(height: 3.h),
            Text(description, style: CustomTextStyle.labelText),
          ],
        ),
      ),
    );
  }
}
