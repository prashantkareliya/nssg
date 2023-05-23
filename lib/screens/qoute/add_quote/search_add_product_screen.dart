  import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nssg/screens/qoute/get_product/product_model_dir/get_product_response_model.dart';
import 'package:nssg/utils/extention_text.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:collection/collection.dart';

import '../../../components/custom_text_styles.dart';
import '../../../constants/constants.dart';
import '../../../constants/strings.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/helpers.dart';
import '../../../utils/widgetChange.dart';
import '../../../utils/widgets.dart';
import '../bloc/product_list_bloc.dart';
import '../get_product/product_bloc_dir/get_product_bloc.dart';
import '../get_product/product_datasource.dart';
import '../get_product/product_repository.dart';
import '../models/products_list.dart';

class SearchAndAddProduct extends StatefulWidget {
  const SearchAndAddProduct({Key? key}) : super(key: key);

  @override
  State<SearchAndAddProduct> createState() => _SearchAndAddProductState();
}

class _SearchAndAddProductState extends State<SearchAndAddProduct> {

  String searchKey = "";

  List<Result>? productItems = [];
  List<Result>? searchItemList = [];

  TextEditingController sellingPriceController = TextEditingController();
  List<TextEditingController> discountPriceController = [];

  @override
  void initState() {
    super.initState();
    getProduct();
  }

  GetProductBloc productBloc = GetProductBloc(ProductRepository(productDatasource: ProductDatasource()));
  List itemNumber = [];
  bool isLoading = false;

  Future<void> getProduct() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    Map<String, dynamic> queryParameters = {
      'operation': "query",
      'sessionName': preferences.getString(PreferenceString.sessionName).toString(),
      'query': Constants.of().apiKeyProduct
    };
    productBloc.add(GetProductListEvent(queryParameters));
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backWhiteColor,
        body: Column(
          children: [
            buildSearchBar(context),
            SizedBox(height: 1.h),
            buildProductList(),
          ],
        ),
      ),
    );
  }

  Padding buildSearchBar(BuildContext context) {
    return Padding(
      padding:
      EdgeInsets.only(right: 24.sp, top: 8.sp, left: 0.sp, bottom: 0),
      child: Padding(
        padding: EdgeInsets.only(bottom: 0.sp),
        child: Row(
          children: [
            IconButton(
              highlightColor: AppColors.transparent,
                splashColor: AppColors.transparent,
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back_ios_outlined,
                    color: AppColors.blackColor, size: 14.sp)),
//            SizedBox(width: 4.w),
            Expanded(
              child: Consumer<WidgetChange>(
                  builder: (context, updateKey, search) {
                    return TextField(
                      autofocus: true,
                        onChanged: (value) {
                          setState(() {});
                          Provider.of<WidgetChange>(context, listen: false).updateSearch(value);
                          searchKey = updateKey.updateSearchText.toString();
                          searchItemList = [];
                          for (var element in productItems!) {
                            if (element.productname!.toLowerCase().contains(searchKey.toLowerCase())) {
                              searchItemList!.add(element);
                            }
                          }
                        },
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            hintText: LabelString.lblSearch,
                            suffixIcon: Container(
                                decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(5),
                                        bottomRight: Radius.circular(5))),
                                child: Icon(Icons.search,
                                    color: AppColors.whiteColor, size: 15.sp)),
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
                  }),
            ),
          ],
        ),
      ),
    );
  }

  BlocListener<GetProductBloc, GetProductState> buildProductList() {
    return BlocListener<GetProductBloc, GetProductState>(
      bloc: productBloc,
      listener: (context, state) {
        if (state is ProductLoadingState) {
          isLoading = state.isBusy;
        }

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
          }
          if (state is ProductLoadedState) {
            isLoading = false;
          }

          if (state is ProductLoadedFail) {
            isLoading = false;
          }
          return Expanded(
            child: isLoading ? loadingView() :
            ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(vertical: 5.sp),
              physics: const BouncingScrollPhysics(),
              itemCount: searchKey.isNotEmpty
                  ? searchItemList!.length
                  : productItems!.length,
              itemBuilder: (context, index) {
                discountPriceController.add(TextEditingController());


                double amount = searchKey.isNotEmpty ?
                (double.parse(searchItemList![index].unitPrice.toString()) *
                    double.parse(searchItemList![index].quantity.toString()) -
                    double.parse(discountPriceController[index].text == "" ? "0" : discountPriceController[index].text)) :
                (double.parse(productItems![index].unitPrice.toString()) *
                    double.parse(productItems![index].quantity.toString()) -
                    double.parse(discountPriceController[index].text == "" ? "0" : discountPriceController[index].text));

                double profit = searchKey.isNotEmpty ?
                ((double.parse(searchItemList![index].unitPrice!) - double.parse(
                    searchItemList![index].costPrice.toString())) *
                    (searchItemList![index].quantity!) -
                    double.parse(discountPriceController[index].text == "" ? "0" : discountPriceController[index].text)) :

                ((double.parse(productItems![index].unitPrice!) - double.parse(
                    productItems![index].costPrice.toString())) *
                    (productItems![index].quantity!) -
                    double.parse(discountPriceController[index].text == "" ? "0" : discountPriceController[index].text));

                return BlocConsumer<ProductListBloc, ProductListState>(
                  listener: (context, state) {},
                  builder: (context, productState) {

                    final bool isItemAdded = searchKey.isNotEmpty ?
                    productState.productList.firstWhereOrNull((element) => element.productId == searchItemList![index].id) != null  :
                    productState.productList.firstWhereOrNull((element) => element.productId == productItems![index].id) != null;
                    if(searchKey.isNotEmpty){
                      if(searchItemList![index].discontinued == "1"){
                        return Padding(padding: EdgeInsets.symmetric(horizontal: 6.sp),
                            child: Card(
                              shadowColor: AppColors.primaryColor,
                              elevation: 2,
                              child: ListTile(
                                onTap: isItemAdded ? () {
                                  searchKey.isNotEmpty ?
                                  context.read<ProductListBloc>().add(RemoveProductFromCardByIdEvent(productId: searchItemList![index].id ?? "")):
                                  context.read<ProductListBloc>().add(RemoveProductFromCardByIdEvent(productId: productItems![index].id ?? ""));
                                  searchKey.isNotEmpty ? itemNumber.remove(searchItemList![index].id) : itemNumber.remove(productItems![index].id);
                                } :
                                    () {
                                  List<String> documentType = [];

                                  if(searchKey.isNotEmpty){
                                    if (searchItemList![index].productNssKeyholderForm == "1") {
                                      documentType.add("Keyholder form");
                                      if (searchItemList![index].productSecurityAgreeForm == "1") {
                                        documentType.add("Maintenance contract");
                                        if (searchItemList![index].productPoliceAppForm == "1") {
                                          documentType.add("Maintenance contract");
                                          if (searchItemList![index].productDirectDebitForm == "1") {
                                            documentType.add("Direct Debit");
                                          }
                                        }
                                      }
                                      print((documentType).join('###'));
                                    }
                                  }else {
                                    if (productItems![index].productNssKeyholderForm == "1") {
                                      documentType.add("Keyholder form");
                                      if (productItems![index].productSecurityAgreeForm == "1") {
                                        documentType.add("Maintenance contract");
                                        if (productItems![index].productPoliceAppForm == "1") {
                                          documentType.add("Maintenance contract");
                                          if (productItems![index].productDirectDebitForm == "1") {
                                            documentType.add("Direct Debit");
                                          }
                                        }
                                      }
                                      print((documentType).join('###'));
                                    }
                                  }

                                  ProductsList productsList = ProductsList(
                                    itemId: DateTime.now().millisecondsSinceEpoch.toString(),
                                    productId: searchKey.isNotEmpty? searchItemList![index].id.toString()  : productItems![index].id.toString(),
                                    itemName: searchKey.isNotEmpty? searchItemList![index].productname.toString() :productItems![index].productname.toString(),
                                    costPrice: searchKey.isNotEmpty? searchItemList![index].costPrice.toString() :productItems![index].costPrice.toString(),
                                    sellingPrice: searchKey.isNotEmpty ?
                                    (sellingPriceController.text.isEmpty? searchItemList![index].unitPrice : sellingPriceController.text) :
                                    (sellingPriceController.text.isEmpty? productItems![index].unitPrice : sellingPriceController.text),
                                    discountPrice: discountPriceController[index].text.toString(),
                                    amountPrice: amount.toString(),
                                    profit: profit.toString(),
                                    quantity: searchKey.isNotEmpty ? searchItemList![index].quantity : productItems![index].quantity,
                                    description: searchKey.isNotEmpty? searchItemList![index] .description: productItems![index] .description,
                                    selectLocation: searchKey.isNotEmpty ? (searchItemList![index].locationList ?? []).join('###') :(productItems![index].locationList ?? []).join('###'),
                                    titleLocation: searchKey.isNotEmpty ? (searchItemList![index].titleLocationList ?? []).join("###"):(productItems![index].titleLocationList ?? []).join("###"),
                                    itemAdd: searchKey.isNotEmpty? searchItemList![index].isItemAdded : productItems![index].isItemAdded,
                                    productImage: searchKey.isNotEmpty? searchItemList![index].imagename : productItems![index].imagename,
                                    requiredDocument: (documentType).join('###'),
                                    productTitle: searchKey.isNotEmpty? searchItemList![index].productsTitle : productItems![index].productsTitle
                                  );
                                  setState(() {
                                    searchKey.isNotEmpty ?
                                    itemNumber.add(searchItemList![index].id) :
                                    itemNumber.add(productItems![index].id);
                                  });
                                  context.read<ProductListBloc>().add(AddProductToListEvent(productsList: productsList));
                                },

                                leading: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 5.sp),
                                    child:(searchKey.isNotEmpty ? searchItemList![index].imagename == "" : productItems![index].imagename == "") ?
                                    SvgPicture.asset(ImageString.imgPlaceHolder, height: 10.h, width: 20.w,) :
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(8.0),
                                        child: Container(
                                          color: AppColors.backWhiteColor,
                                          child: Padding(
                                            padding:  EdgeInsets.all(4.sp),
                                            child: searchKey.isNotEmpty ?
                                            Image.network("${ImageBaseUrl.productImageBaseUrl}${searchItemList![index].imagename}",
                                                height: 10.h,width: 20.w)
                                                :Image.network("${ImageBaseUrl.productImageBaseUrl}${productItems![index].imagename}",
                                                height: 10.h,width: 20.w),
                                          ),
                                        ))
                                ),
                                title: Text(searchKey.isNotEmpty ? searchItemList![index].productname.toString()
                                    : productItems![index].productname.toString(),textAlign: TextAlign.start,
                                    style: CustomTextStyle.labelBoldFontText),
                                subtitle: Text(searchKey.isNotEmpty ? "£${searchItemList![index].unitPrice.formatAmount()}"
                                    : "£${productItems![index].unitPrice.formatAmount()}",textAlign: TextAlign.start,
                                    style: CustomTextStyle.labelText),
                                trailing: isItemAdded
                                    ? Container(
                                    height: 5.h, width: 10.w,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8.0),
                                        border: Border.all(color: AppColors.greenColorAccent, width: 1),
                                        color: AppColors.greenColorAccent),
                                    child: SvgPicture.asset(ImageString.icAddCartGreen, fit: BoxFit.none))
                                    : Container(
                                    height: 5.h, width: 10.w,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8.0),
                                        border: Border.all(color: AppColors.primaryColor, width: 1),
                                        color: AppColors.primaryColor),
                                    child: SvgPicture.asset(ImageString.icAddCart, fit: BoxFit.none)),
                              ),
                            )
                        );
                      }
                    }else{
                      return Padding(padding: EdgeInsets.symmetric(horizontal: 6.sp),
                          child: Card(
                            shadowColor: AppColors.primaryColor,
                            elevation: 2,
                            child: ListTile(
                              onTap: isItemAdded ? () {
                                searchKey.isNotEmpty ?
                                context.read<ProductListBloc>().add(RemoveProductFromCardByIdEvent(productId: searchItemList![index].id ?? "")):
                                context.read<ProductListBloc>().add(RemoveProductFromCardByIdEvent(productId: productItems![index].id ?? ""));
                                searchKey.isNotEmpty ? itemNumber.remove(searchItemList![index].id) : itemNumber.remove(productItems![index].id);
                              } :
                                  () {
                                List<String> documentType = [];

                                if(searchKey.isNotEmpty){
                                  if (searchItemList![index].productNssKeyholderForm == "1") {
                                    documentType.add("Keyholder form");
                                    if (searchItemList![index].productSecurityAgreeForm == "1") {
                                      documentType.add("Maintenance contract");
                                      if (searchItemList![index].productPoliceAppForm == "1") {
                                        documentType.add("Maintenance contract");
                                        if (searchItemList![index].productDirectDebitForm == "1") {
                                          documentType.add("Direct Debit");
                                        }
                                      }
                                    }
                                    print((documentType).join('###'));
                                  }
                                }else {
                                  if (productItems![index].productNssKeyholderForm == "1") {
                                    documentType.add("Keyholder form");
                                    if (productItems![index].productSecurityAgreeForm == "1") {
                                      documentType.add("Maintenance contract");
                                      if (productItems![index].productPoliceAppForm == "1") {
                                        documentType.add("Maintenance contract");
                                        if (productItems![index].productDirectDebitForm == "1") {
                                          documentType.add("Direct Debit");
                                        }
                                      }
                                    }
                                    print((documentType).join('###'));
                                  }
                                }

                                ProductsList productsList = ProductsList(
                                  itemId: DateTime.now().millisecondsSinceEpoch.toString(),
                                  productId: searchKey.isNotEmpty? searchItemList![index].id.toString()  : productItems![index].id.toString(),
                                  itemName: searchKey.isNotEmpty? searchItemList![index].productname.toString() :productItems![index].productname.toString(),
                                  costPrice: searchKey.isNotEmpty? searchItemList![index].costPrice.toString() :productItems![index].costPrice.toString(),
                                  sellingPrice: searchKey.isNotEmpty ?
                                  (sellingPriceController.text.isEmpty? searchItemList![index].unitPrice : sellingPriceController.text) :
                                  (sellingPriceController.text.isEmpty? productItems![index].unitPrice : sellingPriceController.text),
                                  discountPrice: discountPriceController[index].text.toString(),
                                  amountPrice: amount.toString(),
                                  profit: profit.toString(),
                                  quantity: searchKey.isNotEmpty ? searchItemList![index].quantity : productItems![index].quantity,
                                  description: searchKey.isNotEmpty? searchItemList![index] .description: productItems![index] .description,
                                  selectLocation: searchKey.isNotEmpty ? (searchItemList![index].locationList ?? []).join('###') :(productItems![index].locationList ?? []).join('###'),
                                  titleLocation: searchKey.isNotEmpty ? (searchItemList![index].titleLocationList ?? []).join("###"):(productItems![index].titleLocationList ?? []).join("###"),
                                  itemAdd: searchKey.isNotEmpty? searchItemList![index].isItemAdded : productItems![index].isItemAdded,
                                  productImage: searchKey.isNotEmpty? searchItemList![index].imagename : productItems![index].imagename,
                                  requiredDocument: (documentType).join('###'),
                                );
                                setState(() {
                                  searchKey.isNotEmpty ?
                                  itemNumber.add(searchItemList![index].id) :
                                  itemNumber.add(productItems![index].id);
                                });
                                context.read<ProductListBloc>().add(AddProductToListEvent(productsList: productsList));
                              },

                              leading: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5.sp),
                                  child:(searchKey.isNotEmpty ? searchItemList![index].imagename == "" : productItems![index].imagename == "") ?
                                  SvgPicture.asset(ImageString.imgPlaceHolder, height: 10.h, width: 20.w,) :
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Container(
                                        color: AppColors.backWhiteColor,
                                        child: Padding(
                                          padding:  EdgeInsets.all(4.sp),
                                          child: searchKey.isNotEmpty ?
                                          Image.network("${ImageBaseUrl.productImageBaseUrl}${searchItemList![index].imagename}",
                                              height: 10.h,width: 20.w)
                                              :Image.network("${ImageBaseUrl.productImageBaseUrl}${productItems![index].imagename}",
                                              height: 10.h,width: 20.w),
                                        ),
                                      ))
                              ),
                              title: Text(searchKey.isNotEmpty ? searchItemList![index].productname.toString()
                                  : productItems![index].productname.toString(),textAlign: TextAlign.start,
                                  style: CustomTextStyle.labelBoldFontText),
                              subtitle: Text(searchKey.isNotEmpty ? "£${searchItemList![index].unitPrice.formatAmount()}"
                                  : "£${productItems![index].unitPrice.formatAmount()}",textAlign: TextAlign.start,
                                  style: CustomTextStyle.labelText),
                              trailing: isItemAdded
                                  ? Container(
                                  height: 5.h, width: 10.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      border: Border.all(color: AppColors.greenColorAccent, width: 1),
                                      color: AppColors.greenColorAccent),
                                  child: SvgPicture.asset(ImageString.icAddCartGreen, fit: BoxFit.none))
                                  : Container(
                                  height: 5.h, width: 10.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      border: Border.all(color: AppColors.primaryColor, width: 1),
                                      color: AppColors.primaryColor),
                                  child: SvgPicture.asset(ImageString.icAddCart, fit: BoxFit.none)),
                            ),
                          )
                      );
                    }
                      return Container();
                    }
                    );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Container(height: 1.h);
              },
            ),
          );
        },
      ),
    );
  }
}