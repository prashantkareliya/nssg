import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nssg/constants/navigation.dart';
import 'package:nssg/screens/qoute/add_quote/add_quote_screen.dart';
import 'package:nssg/screens/qoute/quote_datasource.dart';
import 'package:nssg/screens/qoute/quote_repository.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../components/custom_appbar.dart';
import '../../components/custom_dialog.dart';
import '../../components/custom_text_styles.dart';
import '../../constants/constants.dart';
import '../../constants/strings.dart';
import '../../httpl_actions/handle_api_error.dart';
import '../../utils/app_colors.dart';
import '../../utils/helpers.dart';
import '../../utils/widgetChange.dart';
import '../../utils/widgets.dart';
import '../contact/add_contact/add_contact_screen.dart';
import '../contact/contact_screen.dart';
import 'get_quote/quote_bloc_dir/get_quote_bloc.dart';
import 'get_quote/quote_model_dir/get_quote_response_model.dart';

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
                    onTap: () => closeSearchBar(searchKey, context),
                    child: Icon(Icons.arrow_back_ios_rounded,
                        color: AppColors.blackColor)),
                SizedBox(width: 5.w),
                Expanded(
                  child: TextField(
                      onChanged: (value) {
                        setState(() {
                          searchKey = value;
                          searchItemList = [];
                          for (var element in quoteItems!) {
                            if (element.subject!.contains(searchKey)) {
                              searchItemList!.add(element);
                            } else if (element.quotesCompany!
                                .contains(searchKey)) {
                              searchItemList!.add(element);
                            } else if (element.shipStreet!
                                .contains(searchKey)) {
                              searchItemList!.add(element);
                            } else if (element.shipCode!.contains(searchKey)) {
                              searchItemList!.add(element);
                            }
                          }
                        });
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
                              EdgeInsets.only(left: 10.sp, top: 0, bottom: 0))),
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
                    child: ListView.separated(
                      padding: EdgeInsets.only(top: 10.sp),
                      physics: const BouncingScrollPhysics(),
                      itemCount: searchKey.isNotEmpty
                          ? searchItemList!.length
                          : quoteItems!.length,
                      itemBuilder: (context, index) {
                        var quoteItem = quoteItems![index];
                        return Padding(
                          padding: EdgeInsets.only(left: 12.sp, right: 12.sp),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.sp),
                            ),
                            elevation: 3,
                            child: InkWell(
                              onTap: () => callNextScreen(
                                  context, QuoteDetail(quoteItem.id)),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 1.0.h),
                                        ContactTileField(
                                            LabelString.lblSubject,
                                            searchKey.isNotEmpty
                                                ? searchItemList![index].subject
                                                : quoteItem.subject),
                                        ContactTileField(
                                            LabelString.lblCompany,
                                            searchKey.isNotEmpty
                                                ? searchItemList![index]
                                                    .quotesCompany
                                                : quoteItem.quotesCompany),
                                        ContactTileField(
                                            LabelString.lblPrimaryEmail,
                                            quoteItem.quotesEmail),
                                        ContactTileField(
                                            LabelString.lblMobilePhone,
                                            quoteItem.quoteMobileNumber),
                                        ContactTileField(
                                            LabelString.lblAddress,
                                            searchKey.isNotEmpty
                                                ? "${searchItemList![index].shipStreet} ${searchItemList![index].shipCode}"
                                                : "${quoteItem.shipStreet} ${quoteItem.shipCode}"),
                                        SizedBox(height: 2.0.h),
                                      ],
                                    ),
                                  ),
                                  Flexible(
                                    flex: 0,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Visibility(
                                          visible:
                                              quoteItem.quotestage != "accepted"
                                                  ? true
                                                  : false,
                                          child: InkWell(
                                            highlightColor:
                                                AppColors.transparent,
                                            splashColor: AppColors.transparent,
                                            onTap: () {},
                                            child: Padding(
                                                padding: EdgeInsets.all(8.sp),
                                                child: Center(
                                                    child: Icon(
                                                        Icons.edit_rounded,
                                                        size: 14.sp,
                                                        color: AppColors
                                                            .blackColor))),
                                          ),
                                        ),
                                        InkWell(
                                          highlightColor: AppColors.transparent,
                                          splashColor: AppColors.transparent,
                                          onTap: () {
                                            //Dialog to confirm delete contact or not
                                            showDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (ctx) =>
                                                  ValidationDialog(
                                                Message.deleteContact,
                                                //Yes button
                                                () {
                                                  Navigator.pop(context);
                                                },
                                                () => Navigator.pop(
                                                    context), //No button
                                              ),
                                            );
                                          },
                                          child: Center(
                                              child: Icon(
                                            Icons.delete_rounded,
                                            color: AppColors.redColor,
                                            size: 14.sp,
                                          )),
                                        )
                                      ],
                                    ),
                                  )
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
          );
        },
      ),
    );
  }

  Padding buildSearchField(Size query) {
    return Padding(
      padding: EdgeInsets.only(right: 18.sp, top: 8.sp),
      child: AnimSearchBar(
        width: query.width * 0.89,
        textController: textController,
        onSuffixTap: () {
          textController.clear();
        },
        boxShadow: false,
        color: AppColors.backWhiteColor,
        onSubmitted: (string) {
          debugPrint(string);
        },
        style: CustomTextStyle.commonText,
      ),
    );
  }

  FloatingActionButton buildAddContactButton(BuildContext context) {
    return FloatingActionButton(
        onPressed: () {
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
      backgroundColor: AppColors.whiteColor,
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
                  padding: EdgeInsets.fromLTRB(10.sp, 10.sp, 10.sp, 5.sp),
                  child: Column(
                    children: [
                      ContactTileField(
                          LabelString.lblSubject, dataQuote["subject"]),
                      ContactTileField(
                          LabelString.lblCompany, dataQuote["quotes_company"]),
                      ContactTileField(LabelString.lblPrimaryEmail,
                          dataQuote["quotes_email"]),
                      ContactTileField(LabelString.lblMobilePhone,
                          dataQuote["quote_mobile_number"]),
                      ContactTileField(LabelString.lblPremisesType,
                          dataQuote["premises_type"]),
                      ContactTileField(
                          LabelString.lblSystemType, dataQuote["system_type"]),
                      ContactTileField(LabelString.lblGradeNumber,
                          dataQuote["grade_number"]),
                      ContactTileField(LabelString.lblSignallingType,
                          dataQuote["signalling_type"]),
                      ContactTileField(LabelString.lblQuotePayment,
                          dataQuote["quotes_payment"]),
                      ContactTileField(
                          LabelString.lblTerms, dataQuote["quotes_terms"]),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.sp),
                          child: TextButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      elevation: 0,
                                      insetPadding: EdgeInsets.symmetric(
                                          horizontal: 12.sp),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: InkWell(
                                                  onTap: () =>
                                                      Navigator.pop(context),
                                                  highlightColor:
                                                      AppColors.transparent,
                                                  splashColor:
                                                      AppColors.transparent,
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(10.sp),
                                                    child: Icon(
                                                        Icons.close_rounded,
                                                        color: AppColors
                                                            .blackColor),
                                                  )),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 5.sp),
                                              child: Text(
                                                  LabelString
                                                      .lblInvoiceAddressDetails,
                                                  style: CustomTextStyle
                                                      .labelBoldFontTextBlue),
                                            ),
                                            ContactTileField(
                                                LabelString.lblAddress,
                                                dataQuote["bill_street"]),
                                            ContactTileField(
                                                LabelString.lblCity,
                                                dataQuote["bill_city"]),
                                            ContactTileField(
                                                LabelString.lblState,
                                                dataQuote["bill_state"]),
                                            ContactTileField(
                                                LabelString.lblCountry,
                                                dataQuote["bill_country"]),
                                            ContactTileField(
                                                LabelString.lblPostalCode,
                                                dataQuote["bill_code"]),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: 15.sp, bottom: 5.sp),
                                              child: Text(
                                                  LabelString
                                                      .lblInstallationAddressDetails,
                                                  style: CustomTextStyle
                                                      .labelBoldFontTextBlue),
                                            ),
                                            ContactTileField(
                                                LabelString.lblAddress,
                                                dataQuote["ship_street"]),
                                            ContactTileField(
                                                LabelString.lblCity,
                                                dataQuote["ship_city"]),
                                            ContactTileField(
                                                LabelString.lblState,
                                                dataQuote["ship_state"]),
                                            ContactTileField(
                                                LabelString.lblCountry,
                                                dataQuote["ship_country"]),
                                            ContactTileField(
                                                LabelString.lblPostalCode,
                                                dataQuote["ship_code"]),
                                            SizedBox(height: 2.h)
                                          ],
                                        ),
                                      ));
                                },
                              );
                            },
                            child: Text(LabelString.lblViewAddress,
                                style: CustomTextStyle.labelBoldFontTextBlue),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 0.sp, bottom: 5.sp),
                        child: Text(LabelString.lblItemDetail,
                            style: CustomTextStyle.labelBoldFontTextBlue),
                      ),
                      ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: itemList.length,
                          itemBuilder: (context, index) {
                            final key = GlobalKey<State<Tooltip>>();

                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.sp),
                              ),
                              elevation: 3,
                              child: Column(
                                children: [
                                  SizedBox(height: 2.h),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 8.sp),
                                        child: Image.asset(ImageString.imgDemo,
                                            height: 80.sp),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              EdgeInsets.only(right: 30.sp),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                          itemList[index]["prod_name"],
                                                          style: CustomTextStyle
                                                              .labelBoldFontText)
                                                    ),
                                                    Tooltip(
                                                      key:key,
                                                      message: itemList[index]["comment"] ?? "",
                                                      textStyle: CustomTextStyle.buttonText,
                                                      preferBelow: true,
                                                      padding: EdgeInsets.all(10.sp),
                                                      child: InkWell(
                                                          onTap: () {
                                                            final dynamic tooltip = key.currentState;
                                                            tooltip.ensureTooltipVisible();
                                                          },
                                                          child: Icon(
                                                              Icons.info_outline,
                                                              color: AppColors.blackColor)),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              ContactTileField(
                                                  LabelString.lblCostPrice,
                                                  (double.parse(itemList[index]
                                                          ["costprice"]))
                                                      .toString(),
                                                  textAlign: TextAlign.end),
                                              //Use listPrice as sellingPrice
                                              ContactTileField(
                                                  LabelString.lblSellingPrice,
                                                  (double.parse(itemList[index]
                                                          ["listprice"]))
                                                      .toString(),
                                                  textAlign: TextAlign.end),
                                              ContactTileField(
                                                  LabelString.lblDiscount,
                                                  (double.parse(itemList[index]
                                                          ["discount_amount"])
                                                      .toString()),
                                                  textAlign: TextAlign.end),

                                              ///Amount calculation
                                              //(listPrice * quantity)- discount
                                              ContactTileField(
                                                  LabelString.lblAmount,
                                                  ((double.parse(itemList[index]
                                                                  [
                                                                  "listprice"])) *
                                                              (double.parse(
                                                                  itemList[
                                                                          index]
                                                                      [
                                                                      "quantity"])) -
                                                          (double.parse(itemList[
                                                                  index][
                                                              "discount_amount"])))
                                                      .toString(),
                                                  textAlign: TextAlign.end),

                                              ///Profit calculation
                                              //(listPrice-costPrice)*quantity
                                              ContactTileField(
                                                  LabelString.lblProfit,
                                                  ((double.parse(itemList[index]
                                                                  [
                                                                  "listprice"]) -
                                                              double.parse(itemList[
                                                                      index][
                                                                  "costprice"])) *
                                                          double.parse(
                                                              itemList[index]
                                                                  ["quantity"]))
                                                      .toString()
                                                      .substring(0, 4),
                                                  textAlign: TextAlign.end),

                                              ContactTileField(
                                                  LabelString.lblQuantity,
                                                  (double.parse(itemList[index]
                                                          ["quantity"]))
                                                      .toString(),
                                                  textAlign: TextAlign.end),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8.sp),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextButton(
                                          onPressed: () {},
                                          child: Text(
                                              LabelString.lblAttachedDocument,
                                              style: CustomTextStyle
                                                  .commonTextBlue),
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
                                          child: Text(
                                              LabelString.lblViewLocation,
                                              style: CustomTextStyle
                                                  .commonTextBlue),
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
                      SizedBox(height: 2.h)
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
}
