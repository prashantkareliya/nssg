import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nssg/constants/navigation.dart';
import 'package:nssg/screens/qoute/add_quote/add_quote_screen.dart';
import 'package:nssg/screens/qoute/quote_datasource.dart';
import 'package:nssg/screens/qoute/quote_repository.dart';
import 'package:nssg/utils/extention_text.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../components/custom_appbar.dart';
import '../../components/custom_text_styles.dart';
import '../../components/global_api_call.dart';
import '../../constants/constants.dart';
import '../../constants/strings.dart';
import '../../httpl_actions/handle_api_error.dart';
import '../../utils/app_colors.dart';
import '../../utils/helpers.dart';
import '../../utils/widgetChange.dart';
import '../../utils/widgets.dart';
import '../contact/contact_screen.dart';
import 'bloc/product_list_bloc.dart';
import 'get_quote/quote_bloc_dir/get_quote_bloc.dart';
import 'get_quote/quote_model_dir/get_quote_response_model.dart';
import 'item_detail.dart';

class QuoteScreen extends StatefulWidget {
  const QuoteScreen({Key? key}) : super(key: key);

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  List<Result>? quoteItems = [];
  List<Result>? searchItemList = [];
  String searchKey = "";

  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getQuote();
  }

  GetQuoteBloc quoteBloc =
      GetQuoteBloc(QuoteRepository(quoteDatasource: QuoteDatasource()));
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backWhiteColor,
        body: Column(
          children: [
            buildAppbar(context),
            buildSearchBar(context),
            buildQuoteList(context)
          ],
        ),
        floatingActionButton: buildAddContactButton(context),
      ),
    );
  }

  //Design appbar field
  AnimatedOpacity buildAppbar(BuildContext context) {
    return AnimatedOpacity(
      opacity:
          Provider.of<WidgetChange>(context, listen: true).isAppbarShow ? 1 : 0,
      duration: const Duration(milliseconds: 500),
      child: Visibility(
        visible: Provider.of<WidgetChange>(context, listen: true).isAppbarShow,
        child: BaseAppBar(
          appBar: AppBar(),
          title: LabelString.lblQuotes,
          titleTextStyle: CustomTextStyle.labelFontText,
          isBack: false,
          searchWidget: Padding(
            padding: EdgeInsets.only(right: 12.sp),
            child: IconButton(
                onPressed: () =>
                    Provider.of<WidgetChange>(context, listen: false)
                        .appbarVisibility(),
                icon: Icon(Icons.search, color: AppColors.blackColor)),
          ),
          backgroundColor: AppColors.backWhiteColor,
        ),
      ),
    );
  }

  //Design search field
  AnimatedOpacity buildSearchBar(BuildContext context) {
    return AnimatedOpacity(
      opacity:
          Provider.of<WidgetChange>(context, listen: true).isAppbarShow ? 0 : 1,
      duration: const Duration(milliseconds: 500),
      child: Visibility(
        visible: Provider.of<WidgetChange>(context, listen: true).isAppbarShow
            ? false
            : true,
        child: Padding(
          padding:
              EdgeInsets.only(right: 24.sp, top: 8.sp, left: 15.sp, bottom: 0),
          child: Padding(
            padding: EdgeInsets.only(bottom: 0.sp),
            child: Row(
              children: [
                InkWell(
                    onTap: () => closeSearchBar(),
                    child: Icon(Icons.arrow_back_ios_rounded,
                        color: AppColors.blackColor)),
                SizedBox(width: 5.w),
                Expanded(
                  child: Consumer<WidgetChange>(
                    builder: (context, updateKey, search){
                      return TextField(
                          onChanged: (value) {
                          Provider.of<WidgetChange>(context, listen: false).updateSearch(value);
                          searchKey = updateKey.updateSearchText.toString();

                            searchItemList = [];
                            for (var element in quoteItems!) {
                              if (element.subject!.toLowerCase().contains(searchKey)) {
                                searchItemList!.add(element);
                              } else if (element.quotesCompany!
                                  .toLowerCase()
                                  .contains(searchKey)) {
                                searchItemList!.add(element);
                              } else if (element.shipStreet!
                                  .toLowerCase()
                                  .contains(searchKey)) {
                                searchItemList!.add(element);
                              } else if (element.shipCode!
                                  .toLowerCase()
                                  .contains(searchKey)) {
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
                              contentPadding:
                              EdgeInsets.only(left: 10.sp, top: 0, bottom: 0)));
                    },

                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //Quote list design
  buildQuoteList(BuildContext context) {
    return BlocListener<GetQuoteBloc, GetQuoteState>(
      bloc: quoteBloc,
      listener: (context, state) {
        if (state is QuoteLoadedFail) {
          Helpers.showSnackBar(context, state.error.toString());
        }
        if (state is QuoteLoadedState) {
          quoteItems = state.quoteList;
        }
      },
      child: BlocBuilder<GetQuoteBloc, GetQuoteState>(
        bloc: quoteBloc,
        builder: (context, state) {
          if (state is QuoteLoadingState) {
            isLoading = state.isBusy;
          }
          if (state is QuoteLoadedState) {
            isLoading = false;
          }
          if (state is QuoteLoadedFail) {
            isLoading = false;
          }

          return Expanded(
            child: isLoading
                ? loadingView()
                : RefreshIndicator(
                    onRefresh: () => getQuote(),
                    child: AnimationLimiter(
                      child: ListView.separated(
                        padding: EdgeInsets.only(top: 10.sp),
                        physics: const BouncingScrollPhysics(),
                        itemCount: searchKey.isNotEmpty
                            ? searchItemList!.length
                            : quoteItems!.length,
                        itemBuilder: (context, index) {
                          //var quoteItem = quoteItems![index];
                          return AnimationConfiguration.staggeredList(
                            position: index,
                            child: SlideAnimation(
                              verticalOffset: 50.0,
                              curve: Curves.decelerate,
                              child: FadeInAnimation(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 12.sp, right: 12.sp),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(12.sp),
                                    ),
                                    elevation: 3,
                                    child: InkWell(
                                      onTap: () {
                                        if(searchKey.isNotEmpty){
                                          callNextScreen(context, QuoteDetail(searchItemList![index].id));
                                        }else{
                                          callNextScreen(context, QuoteDetail(quoteItems![index].id));
                                        }
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: AppColors.whiteColor,
                                            borderRadius:
                                                BorderRadius.circular(12.sp)),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 8.sp,
                                              horizontal: 15.sp),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(height: 1.0.h),
                                              Text(
                                                  searchKey.isNotEmpty
                                                      ? searchItemList![index]
                                                          .subject
                                                          .toString()
                                                      : quoteItems![index]
                                                          .subject
                                                          .toString(),
                                                  style: CustomTextStyle
                                                      .labelMediumBoldFontText),
                                              SizedBox(height: 2.0.h),
                                              Text(
                                                  searchKey.isNotEmpty
                                                      ? searchItemList![index]
                                                          .quotesCompany
                                                          .toString()
                                                      : quoteItems![index]
                                                          .quotesCompany
                                                          .toString(),
                                                  style: CustomTextStyle
                                                      .labelText),
                                              SizedBox(height: 0.5.h),
                                              Text.rich(
                                                TextSpan(
                                                  text: quoteItems![index]
                                                      .quotesEmail
                                                      .toString(),
                                                  style:
                                                      CustomTextStyle.labelText,
                                                  children: [
                                                    WidgetSpan(
                                                        child: quoteItems![
                                                                    index]
                                                                .quoteMobileNumber!
                                                                .isEmpty
                                                            ? Container()
                                                            : Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal: 8
                                                                            .sp),
                                                                child: Container(
                                                                    color: AppColors
                                                                        .hintFontColor,
                                                                    height:
                                                                        2.0.h,
                                                                    width: 0.5
                                                                        .w))),
                                                    TextSpan(
                                                        text: quoteItems![index]
                                                            .quoteMobileNumber
                                                            .toString(),
                                                        style: CustomTextStyle
                                                            .labelText)
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: 0.5.h),
                                              Text(
                                                  searchKey.isNotEmpty
                                                      ? "${searchItemList![index].shipStreet} ${searchItemList![index].shipCode}"
                                                      : "${quoteItems![index].shipStreet} ${quoteItems![index].shipCode}",
                                                  style: CustomTextStyle
                                                      .labelText),
                                              SizedBox(height: 2.0.h),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
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
                  ),
          );
        },
      ),
    );
  }

  FloatingActionButton buildAddContactButton(BuildContext context) {
    return FloatingActionButton(
        onPressed: () {
          context.read<ProductListBloc>().add(ClearProductToListEvent());
          callNextScreen(context, AddQuotePage(true));
        },
        child: const Icon(Icons.add));
  }


  Future<void> getQuote() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    Map<String, dynamic> queryParameters = {
      'operation': 'query',
      'sessionName':
          preferences.getString(PreferenceString.sessionName).toString(),
      'query': Constants.of().apiKeyQuote, //2017
      'module_name': 'Quotes',
      'assigned_user_id':
          preferences.getString(PreferenceString.userId).toString(),
    };
    quoteBloc.add(GetQuoteListEvent(queryParameters));
  }

  void closeSearchBar() {
    Provider.of<WidgetChange>(context, listen: false).appbarVisibility();
    searchKey = "";
  }
}

class QuoteDetail extends StatefulWidget {
  var id;

  QuoteDetail(this.id, {Key? key}) : super(key: key);

  @override
  State<QuoteDetail> createState() => _QuoteDetailState();
}

class _QuoteDetailState extends State<QuoteDetail> {
  Future<dynamic>? getDetail;

  @override
  Widget build(BuildContext context) {
    getDetail = getContactDetail(widget.id);
    return Scaffold(
      backgroundColor: AppColors.backWhiteColor,
      appBar: BaseAppBar(
        appBar: AppBar(),
        title: LabelString.lblQuoteDetail,
        isBack: true,
        elevation: 1,
        backgroundColor: AppColors.whiteColor,
        searchWidget: Container(),
        titleTextStyle: CustomTextStyle.labelBoldFontText,
      ),
      body: FutureBuilder<dynamic>(
          future: getDetail,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var dataQuote = snapshot.data["result"];
              List<dynamic> itemList = dataQuote["LineItems"];
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.sp),
                  child: Column(
                    children: [
                      SizedBox(height: 2.h),
                      ExpansionTile(
                        iconColor: AppColors.primaryColor,
                        onExpansionChanged: (value) {
                          Provider.of<WidgetChange>(context, listen: false).isExpansionTileFirst(value);
                        },
                        textColor: AppColors.blackColor,
                        collapsedBackgroundColor: AppColors.whiteColor,
                        title: Text(LabelString.lblPersonalDetail,
                            style:
                                Provider.of<WidgetChange>(context, listen: true)
                                        .isExpansionOne
                                    ? TextStyle(
                                        fontSize: 14.sp,
                                        color: AppColors.primaryColor,
                                        fontWeight: FontWeight.bold)
                                    : CustomTextStyle.labelBoldFontText),
                        trailing: SvgPicture.asset(
                            Provider.of<WidgetChange>(context, listen: true)
                                    .isExpansionOne
                                ? ImageString.imgAccordion
                                : ImageString.imgAccordionClose),
                        backgroundColor: AppColors.whiteColor,
                        children: [buildPersonalDetail(dataQuote)],
                      ),
                      SizedBox(height: 2.h),
                      ExpansionTile(
                          iconColor: AppColors.primaryColor,
                          onExpansionChanged: (value) {
                            Provider.of<WidgetChange>(context, listen: false)
                                .isExpansionTileSecond(value);
                          },
                          initiallyExpanded: true,
                          textColor: AppColors.blackColor,
                          collapsedBackgroundColor: AppColors.whiteColor,
                          title: Text(LabelString.lblProductDetail,
                              style: Provider.of<WidgetChange>(context,
                                          listen: true)
                                      .isExpansionTwo
                                  ? TextStyle(
                                      fontSize: 14.sp,
                                      color: AppColors.primaryColor,
                                      fontWeight: FontWeight.bold)
                                  : CustomTextStyle.labelBoldFontText),
                          backgroundColor: AppColors.whiteColor,
                          trailing: SvgPicture.asset(
                              Provider.of<WidgetChange>(context, listen: true)
                                      .isExpansionTwo
                                  ? ImageString.imgAccordion
                                  : ImageString.imgAccordionClose),
                          children: [buildProductDetail(dataQuote, itemList)]),
                      SizedBox(height: 2.h),
                      Container(
                          height: 28.h,
                          color: Colors.transparent,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              BottomSheetData("Sub Total", "0",
                                  CustomTextStyle.labelFontHintText),
                              BottomSheetData("Discount Amount", "0.00",
                                  CustomTextStyle.labelFontHintText),
                              BottomSheetData("Items Total", "0",
                                  CustomTextStyle.labelFontHintText),
                              BottomSheetData("Vat Total", "0.00",
                                  CustomTextStyle.labelFontHintText),
                              BottomSheetData("Deposit Amount", "0.00",
                                  CustomTextStyle.labelFontHintText),
                              Divider(
                                  color: AppColors.hintFontColor,
                                  thickness: 1.sp,
                                  endIndent: 8.sp,
                                  indent: 8.sp),
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 14.sp),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Total Profit",
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            color: AppColors.primaryColor,
                                            fontWeight: FontWeight.w500)),
                                    Text("0",
                                        style: CustomTextStyle.commonTextBlue),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 14.sp),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Grand Total",
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            color: AppColors.primaryColor,
                                            fontWeight: FontWeight.w500)),
                                    Text("0",
                                        style: TextStyle(
                                            fontSize: 18.sp,
                                            color: AppColors.primaryColor,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              )
                            ],
                          ))
                    ],
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              final message = HandleAPI.handleAPIError(snapshot.error);
              return Text(message);
            }
            return loadingView();
          }),
    );
  }

  buildProductDetail(dataQuote, List<dynamic> itemList) {
    return Container(
      color: AppColors.primaryColorLawOpacityBack,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 5.sp),
        child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: itemList.length,
            itemBuilder: (context, index) {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.sp),
                ),
                elevation: 3,
                child: Column(
                  children: [
                    SizedBox(height: 1.h),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 8.sp),
                          child:
                              Image.asset(ImageString.imgDemo, height: 80.sp),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(right: 30.sp),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Row(
                                    children: [
                                      Flexible(
                                          flex: 4,
                                          child: Text(
                                              itemList[index]["prod_name"],
                                              style: CustomTextStyle
                                                  .labelBoldFontText)),
                                      Flexible(
                                        flex: 1,
                                        child: IconButton(
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return Dialog(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                      elevation: 0,
                                                      insetPadding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 12
                                                                  .sp),
                                                      child:
                                                          itemDescription(
                                                              itemList[index]
                                                                  ["prod_name"],
                                                              itemList[index]
                                                                  ["comment"]));
                                                },
                                              );
                                            },
                                            icon: Icon(Icons.info_outline,
                                                color: AppColors.blackColor)),
                                      )
                                    ],
                                  ),
                                ),
                                ContactTileField(
                                    LabelString.lblCostPrice,
                                    (double.parse(itemList[index]["costprice"]))
                                        .toString(),
                                    textAlign: TextAlign.end),
                                //Use listPrice as sellingPrice
                                ContactTileField(
                                    LabelString.lblSellingPrice,
                                    (double.parse(itemList[index]["listprice"]))
                                        .toString(),
                                    textAlign: TextAlign.end),
                                ContactTileField(
                                    LabelString.lblDiscount,
                                    (double.parse(
                                            itemList[index]["discount_amount"])
                                        .toString()),
                                    textAlign: TextAlign.end),

                                ///Amount calculation
                                //(listPrice * quantity)- discount
                                ContactTileField(
                                    LabelString.lblAmount,
                                    ((double.parse(itemList[index]
                                                    ["listprice"])) *
                                                (double.parse(itemList[index]
                                                    ["quantity"])) -
                                            (double.parse(itemList[index]
                                                ["discount_amount"])))
                                        .toString(),
                                    textAlign: TextAlign.end),

                                ///Profit calculation
                                //(listPrice-costPrice)*quantity
                                ContactTileField(
                                    LabelString.lblProfit,
                                    ((double.parse(itemList[index]
                                                    ["listprice"]) -
                                                double.parse(itemList[index]
                                                    ["costprice"])) *
                                            double.parse(itemList[index]["quantity"])).formatAmount(),
                                    textAlign: TextAlign.end),

                                ContactTileField(
                                    LabelString.lblQuantity,
                                    (double.parse(itemList[index]["quantity"]))
                                        .toString(),
                                    textAlign: TextAlign.end),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.sp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: Text(LabelString.lblAttachedDocument,
                                style: CustomTextStyle.commonTextBlue),
                          ),
                          TextButton(
                            onPressed: () {
                              /* showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    ///Make new class for dialog
                                                    return Dialog(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                            BorderRadius.circular(10)),
                                                        elevation: 0,
                                                        insetPadding: EdgeInsets.symmetric(
                                                            horizontal: 12.sp),
                                                        child: SelectLocation());
                                                  },
                                                );*/
                            },
                            child: Text(LabelString.lblViewLocation,
                                style: CustomTextStyle.commonTextBlue),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                Container(height: 1.5.h)),
      ),
    );
  }

  Container buildPersonalDetail(dataQuote) {
    return Container(
      color: AppColors.primaryColorLawOpacityBack,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 10.sp),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 1.0.h),
            Text(dataQuote["subject"].toString(),
                style: CustomTextStyle.labelMediumBoldFontText),
            SizedBox(height: 1.0.h),
            Text(dataQuote["quotes_company"].toString(),
                style: CustomTextStyle.labelText),
            SizedBox(height: 0.5.h),
            Row(
              children: [
                Flexible(
                  child: Text(dataQuote["quotes_email"],
                      style: CustomTextStyle.labelText),
                ),
                dataQuote["quote_mobile_number"] == ""
                    ? Container()
                    : Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.sp),
                        child: Container(
                            color: AppColors.hintFontColor,
                            height: 2.0.h,
                            width: 0.5.w),
                      ),
                Text(dataQuote["quote_mobile_number"],
                    style: CustomTextStyle.labelText),
              ],
            ),
            SizedBox(height: 1.5.h),
            QuoteTileField(
                LabelString.lblPremisesType, dataQuote["premises_type"]),
            QuoteTileField(LabelString.lblSystemType, dataQuote["system_type"]),
            QuoteTileField(
                LabelString.lblGradeNumber, dataQuote["grade_number"]),
            QuoteTileField(
                LabelString.lblSignallingType, dataQuote["signalling_type"]),
            QuoteTileField(
                LabelString.lblQuotePayment, dataQuote["quotes_payment"]),
            QuoteTileField(LabelString.lblTerms, dataQuote["quotes_terms"]),
            SizedBox(height: 1.5.h),
            RichText(
              text: TextSpan(
                  text: "${LabelString.lblInstallationAddress} : ",
                  style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w500),
                  children: [
                    TextSpan(
                        text:
                            "\n${dataQuote["bill_street"]}, ${dataQuote["bill_city"]}, ${dataQuote["bill_state"]}, ${dataQuote["bill_country"]}, ${dataQuote["bill_code"]}",
                        style: CustomTextStyle.labelText)
                  ]),
            ),
            SizedBox(height: 1.0.h),
            RichText(
              text: TextSpan(
                  text: "${LabelString.lblInvoiceAddress} : ",
                  style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w500),
                  children: [
                    TextSpan(
                        text:
                            "\n${dataQuote["ship_street"]}, ${dataQuote["ship_city"]}, ${dataQuote["ship_state"]}, ${dataQuote["ship_country"]}, ${dataQuote["ship_code"]}",
                        style: CustomTextStyle.labelText)
                  ]),
            ),
          ],
        ),
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
                    icon:
                        Icon(Icons.close_rounded, color: AppColors.blackColor)),
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
}

class QuoteTileField extends StatelessWidget {
  String? field;
  String? fieldDetail;

  TextAlign? textAlign;

  QuoteTileField(this.field, this.fieldDetail, {super.key, this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.sp, 4.sp, 0.sp, 4.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text("$field :",
                style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w500)),
          ),
          Expanded(
              child: Text(
                  textAlign: textAlign,
                  fieldDetail!,
                  style: CustomTextStyle.labelText)),
        ],
      ),
    );
  }
}
