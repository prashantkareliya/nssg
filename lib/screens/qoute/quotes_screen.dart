import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:nssg/constants/navigation.dart';
import 'package:nssg/screens/qoute/add_quote/add_quote_screen.dart';
import 'package:nssg/screens/qoute/quote_datasource.dart';
import 'package:nssg/screens/qoute/quote_repository.dart';
import 'package:nssg/screens/qoute/send_email.dart';
import 'package:nssg/utils/extention_text.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:sizer/sizer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../components/custom_appbar.dart';
import '../../components/custom_text_styles.dart';
import '../../components/global_api_call.dart';
import '../../constants/constants.dart';
import '../../constants/strings.dart';
import '../../httpl_actions/app_http.dart';
import '../../httpl_actions/handle_api_error.dart';
import '../../utils/app_colors.dart';
import '../../utils/helpers.dart';
import '../../utils/widgetChange.dart';
import '../../utils/widgets.dart';
import '../contact/contact_screen.dart';
import '../job/create_job/add_job_screen.dart';
import 'bloc/product_list_bloc.dart';
import 'get_quote/quote_bloc_dir/get_quote_bloc.dart';
import 'get_quote/quote_model_dir/get_quote_response_model.dart';
import 'add_quote/build_item_screen.dart';

class QuoteScreen extends StatefulWidget {
  const QuoteScreen({Key? key}) : super(key: key);

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  int _page = 0;
  bool _hasNextPage = true;
  int _totalSize = 0;

  // Used to display loading indicators when _firstLoad function is running
  bool _isFirstLoadRunning = false;
  bool _isLoadMoreRunning = false;
  late ScrollController _controller;
  int count = 0;
  TextEditingController searchCtrl = TextEditingController();

  List<Result>? quoteItems = [];

  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // getQuote();
    firstTimeLoad();
    _controller = ScrollController()..addListener(_loadMore);
  }

  @override
  void dispose() {
    _controller.removeListener(_loadMore);
    super.dispose();
  }

  //Method for get item first time
  Future<void> firstTimeLoad() async {
    setState(() {
      _isFirstLoadRunning = true;
    });
    SharedPreferences preferences = await SharedPreferences.getInstance();

    Map<String, dynamic> queryParameters = {
      'operation': 'query',
      'sessionName':
          preferences.getString(PreferenceString.sessionName).toString(),
      'query': Constants.of().apiKeyQuote,
      'page': _page,
      'module_name': 'Quotes'
    };
    quoteBloc.add(GetQuoteListEvent(queryParameters));
  }

  //Method for pagination
  Future<void> _loadMore() async {
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _controller.position.extentAfter < 300) {
      setState(() {
        _isLoadMoreRunning = true; // Display a progress indicator at the bottom
      });
      _page += 1; // Increase _page by 1

      SharedPreferences preferences = await SharedPreferences.getInstance();

      Map<String, dynamic> queryParameters = {
        'operation': 'query',
        'sessionName':
            preferences.getString(PreferenceString.sessionName).toString(),
        'query': Constants.of().apiKeyQuote, //2017
        'page': _page,
        'module_name': 'Quotes'
      };
      quoteBloc.add(GetQuoteListEvent(queryParameters));
    }
  }

  GetQuoteBloc quoteBloc =
      GetQuoteBloc(QuoteRepository(quoteDatasource: QuoteDatasource()));
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backWhiteColor,
        body: Column(children: [
          buildAppbar(context),
          buildSearchBar(context),
          buildQuoteList(context)
        ]),
        floatingActionButton: buildAddContactButton(context),
      ),
    );
  }

  //Design appbar field
  AnimatedOpacity buildAppbar(BuildContext context) {
    return AnimatedOpacity(
        opacity: Provider.of<WidgetChange>(context, listen: true).isAppbarShow
            ? 0
            : 0,
        duration: const Duration(milliseconds: 500));
  }

  //Design search field
  AnimatedOpacity buildSearchBar(BuildContext context) {
    return AnimatedOpacity(
      opacity:
          Provider.of<WidgetChange>(context, listen: true).isAppbarShow ? 1 : 1,
      duration: const Duration(milliseconds: 500),
      child: Visibility(
        visible: Provider.of<WidgetChange>(context, listen: true).isAppbarShow
            ? true
            : true,
        child: Padding(
          padding: EdgeInsets.only(
              right: 18.sp, top: 9.sp, left: 18.sp, bottom: 7.sp),
          child: Padding(
            padding: EdgeInsets.only(bottom: 0.sp),
            child: Row(
              children: [
                Expanded(
                  child: Consumer<WidgetChange>(
                    builder: (context, updateKey, search) {
                      return TextField(
                          controller: searchCtrl,
                          onChanged: (value) async {
                            setState(() {});
                            if(searchCtrl.text.isNotEmpty){
                              SharedPreferences preferences = await SharedPreferences.getInstance();

                              Map<String, dynamic> queryParameters = {
                                'operation': 'query',
                                'sessionName': preferences
                                    .getString(PreferenceString.sessionName)
                                    .toString(),
                                'query': Constants.of().apiKeyQuote, //2017
                                'module_name': 'Quotes',
                                'search_param': searchCtrl.text};
                              quoteBloc.add(GetQuoteListEvent(queryParameters));
                            } else {
                              firstTimeLoad();
                            }
                          },
                          keyboardType: TextInputType.text,
                          autofocus: false,
                          decoration: InputDecoration(
                              hintText: LabelString.lblSearch,
                              hintStyle: TextStyle(fontSize: 16.sp),
                              suffixIcon: Container(
                                  decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(5),
                                          bottomRight: Radius.circular(5))),
                                  child: Icon(Icons.search,
                                      color: AppColors.whiteColor,
                                      size: 20.sp)),
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
          _isFirstLoadRunning = false;
          _isLoadMoreRunning = false;
          _totalSize = state.quoteList!.length;

          if (state.quoteList!.isEmpty) {
            //_hasNextPage = false;
          } else {
            if (_page == 0) {
              quoteItems = state.quoteList;
            } else {
              quoteItems!.addAll(state.quoteList!);
            }
          }
          if (quoteItems!.length == _totalSize) {
            // _hasNextPage = false;
          }
          //quoteItems = state.quoteList;
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
            child: _isFirstLoadRunning && isLoading
                ? loadingView()
                : RefreshIndicator(
                    onRefresh: () => firstTimeLoad(),
                    child: Column(
                      children: [
                        Expanded(
                          child: AnimationLimiter(
                            child: ListView.separated(
                              controller: _controller,
                              padding: EdgeInsets.only(top: 10.sp),
                              physics: const BouncingScrollPhysics(),
                              itemCount: quoteItems!.length,
                              itemBuilder: (context, index) {
                                //var quoteItem = quoteItems![index];
                                String name = "";
                                if ((quoteItems![index].assignedUserName) !=
                                    null) {
                                  if (quoteItems![index]
                                      .assignedUserName!
                                      .contains(" ")) {
                                    if ((quoteItems![index]
                                            .assignedUserName!
                                            .split(" ")
                                            .length) >
                                        1) {
                                      if (quoteItems![index]
                                          .assignedUserName!
                                          .split(" ")[1]
                                          .isNotEmpty) {
                                        name =
                                            "${quoteItems![index].assignedUserName!.split(" ")[0][0]}${quoteItems![index].assignedUserName!.split(" ")[1][0]}"
                                                .toUpperCase();
                                      } else {
                                        name = quoteItems![index]
                                            .assignedUserName![0]
                                            .trim()
                                            .toUpperCase();
                                      }
                                    } else {
                                      name = quoteItems![index]
                                          .assignedUserName![0]
                                          .trim()
                                          .toUpperCase();
                                    }
                                  } else {
                                    name = quoteItems![index]
                                        .assignedUserName![0]
                                        .trim()
                                        .toUpperCase();
                                  }
                                }

                                final DateFormat formatter =
                                    DateFormat('dd/MM/yyyy');
                                final String formatted = formatter.format(
                                    DateTime.parse(quoteItems![index]
                                        .createdDate
                                        .toString()));
                                return AnimationConfiguration.staggeredList(
                                  position: index,
                                  child: SlideAnimation(
                                    verticalOffset: 50.0,
                                    curve: Curves.decelerate,
                                    child: FadeInAnimation(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 19.sp,
                                            right: 18.sp,
                                            bottom: 5.sp),
                                        child: Stack(
                                          children: [
                                            Positioned.fill(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: AppColors.primaryColor,
                                                  borderRadius: BorderRadius.circular(12.sp)))),
                                            Slidable(
                                              enabled: (quoteItems![index]
                                                          .quotestage
                                                          .toString()) ==
                                                      "Accepted"
                                                  ? false
                                                  : true,
                                              endActionPane: ActionPane(
                                                extentRatio: 0.10,
                                                motion: const ScrollMotion(),
                                                children: [
                                                  CustomSlidableAction(
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                            bottomRight:
                                                                Radius.circular(
                                                                    20.0),
                                                            topRight:
                                                                Radius.circular(
                                                                    20.0)),
                                                    padding: EdgeInsets.zero,
                                                    autoClose: true,
                                                    onPressed: (value) {
                                                        Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                                                        AddJobPage(quoteItem: quoteItems![index]))).then((value) {
                                                          if (value == "yes") {
                                                            ScaffoldMessenger.of(context)
                                                              ..hideCurrentSnackBar()
                                                              ..showSnackBar(
                                                                SnackBar(
                                                                  duration: const Duration(milliseconds: 5000),
                                                                  backgroundColor: Colors.green,
                                                                  content: Text(Message.generateJobMessage,
                                                                      style: TextStyle(color: AppColors.whiteColor)),
                                                                  behavior: SnackBarBehavior.floating,
                                                                ),
                                                              );
                                                          }
                                                        });
                                                      },
                                                    backgroundColor: AppColors.primaryColor,
                                                    foregroundColor: AppColors.redColor,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        RotatedBox(
                                                            quarterTurns: -1,
                                                            child: Text(
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                ButtonString
                                                                    .btnGenerateJob,
                                                                style: GoogleFonts.roboto(
                                                                    textStyle: const TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                        color: Colors
                                                                            .white)))),
                                                        SizedBox(height: 5.h),
                                                        const Icon(
                                                            Icons
                                                                .add_circle_outline,
                                                            color:
                                                                Colors.white),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              child: Card(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.r)),
                                                margin: EdgeInsets.zero,
                                                elevation: 2,
                                                child: InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        PageTransition(
                                                            type:
                                                                PageTransitionType
                                                                    .rightToLeft,
                                                            child: QuoteDetail(
                                                                quoteItems![
                                                                        index]
                                                                    .id,
                                                                quoteData:
                                                                    quoteItems![
                                                                        index])));
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: AppColors
                                                            .whiteColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    12.r)),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 10.sp,
                                                              horizontal:
                                                                  16.sp),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          SizedBox(height: 5.h),
                                                          //if Contact name of quote is null then we set subject from the list and remove text after the "-"
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              InkWell(
                                                                onTap: () {
                                                                 Navigator.push(context,
                                                                        PageTransition(type: PageTransitionType.rightToLeft,
                                                                            child: ContactDetail(quoteItems![index].contactId, "quote", [])));

                                                                },
                                                                child: SizedBox(width: 255.w,
                                                                  child: Text.rich(overflow: TextOverflow.clip,
                                                                    TextSpan(
                                                                      text: (quoteItems![index].contactName.toString().replaceAll("&amp;", "&")),
                                                                      style: GoogleFonts.roboto(
                                                                          textStyle: TextStyle(fontSize: 18.sp,
                                                                              color: AppColors.fontColor,
                                                                              fontWeight: FontWeight.w500)),
                                                                      children: [
                                                                        TextSpan(text: " - ${quoteItems![index].quoteNo}",
                                                                            style: GoogleFonts.roboto(
                                                                                textStyle: TextStyle(fontSize: 18.sp,
                                                                                    color: AppColors.fontColor,
                                                                                    fontWeight: FontWeight.w500))),
                                                                      ],
                                                                    ),
                                                                  )),
                                                              Container(
                                                                height: 35.sp,
                                                                width: 35.sp,
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                decoration: BoxDecoration(
                                                                    color: AppColors.stringToColor(
                                                                        quoteItems![index]
                                                                            .assignedUserName!),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            50.r)),
                                                                child: Text(
                                                                  name,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          15.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ),
                                                            ],
                                                          ),

                                                          SizedBox(
                                                              height: 10.h),
                                                          Text(
                                                              quoteItems![index]
                                                                  .systemType
                                                                  .toString(),
                                                              style:
                                                                  CustomTextStyle
                                                                      .labelText),
                                                          SizedBox(height: 4.h),
                                                          Text(
                                                              "${quoteItems![index].shipStreet} ${quoteItems![index].shipCode}",
                                                              style:
                                                                  CustomTextStyle
                                                                      .labelText),
                                                          SizedBox(height: 4.h),
                                                          Text.rich(
                                                            TextSpan(
                                                              text: "",
                                                              style:
                                                                  CustomTextStyle
                                                                      .labelText,
                                                              children: [
                                                                TextSpan(
                                                                    text: quoteItems![index]
                                                                        .quotesEmail
                                                                        .toString(),
                                                                    style: GoogleFonts.roboto(
                                                                        textStyle: TextStyle(
                                                                            fontSize: 14
                                                                                .sp,
                                                                            color: AppColors
                                                                                .primaryColor)),
                                                                    recognizer:
                                                                        TapGestureRecognizer()
                                                                          ..onTap =
                                                                              () {
                                                                            sendMail(quoteItems![index].quotesEmail.toString(),
                                                                                context);
                                                                          }),
                                                                WidgetSpan(
                                                                    child: quoteItems![index]
                                                                            .quoteMobileNumber!
                                                                            .isEmpty
                                                                        ? Container()
                                                                        : Padding(
                                                                            padding:
                                                                                EdgeInsets.symmetric(horizontal: 9.sp),
                                                                            child: Container(color: AppColors.hintFontColor, height: 13.h, width: 2.w))),
                                                                TextSpan(
                                                                    text: quoteItems![
                                                                            index]
                                                                        .quoteMobileNumber
                                                                        .toString(),
                                                                    style: CustomTextStyle
                                                                        .labelText,
                                                                    recognizer: TapGestureRecognizer()
                                                                      ..onTap = () => callFromApp(quoteItems![
                                                                              index]
                                                                          .quoteMobileNumber
                                                                          .toString()))
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(height: 7.h),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              (quoteItems![index]
                                                                          .quotestage
                                                                          .toString()) ==
                                                                      "Accepted"
                                                                  ? Container(
                                                                      decoration: BoxDecoration(
                                                                          color: AppColors
                                                                              .greenColorAccept,
                                                                          borderRadius: BorderRadius.circular(30
                                                                              .sp)),
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                6.sp,
                                                                            vertical: 4.sp),
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Text(quoteItems![index].quotestage.toString(),
                                                                                style: GoogleFonts.roboto(textStyle: TextStyle(fontSize: 14.sp, color: AppColors.whiteColor, fontWeight: FontWeight.w600))),
                                                                            SizedBox(width: 4.sp),
                                                                            SvgPicture.asset(ImageString.icAccepted,
                                                                                height: 8.h)
                                                                          ],
                                                                        ),
                                                                      ))
                                                                  : Container(
                                                                      decoration: BoxDecoration(
                                                                          color: AppColors
                                                                              .darkGray,
                                                                          borderRadius: BorderRadius.circular(30
                                                                              .r)),
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                7.sp,
                                                                            vertical: 5.sp),
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Text(quoteItems![index].quotestage.toString(),
                                                                                style: GoogleFonts.roboto(textStyle: TextStyle(fontSize: 12.sp, color: AppColors.whiteColor, fontWeight: FontWeight.w600))),
                                                                            SizedBox(width: 4.w),
                                                                            SvgPicture.asset(ImageString.icCreateProcessed,
                                                                                height: 8.h)
                                                                          ],
                                                                        ),
                                                                      )),
                                                              Text(
                                                                formatted,
                                                                style: GoogleFonts.roboto(
                                                                    textStyle: TextStyle(
                                                                        fontSize: 14
                                                                            .sp,
                                                                        color: AppColors
                                                                            .hintFontColor)),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return Container(height: 10.sp);
                              },
                            ),
                          ),
                        ),
                        if (_isLoadMoreRunning == true)
                          Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 20),
                              child: Center(child: loadingView())),
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }

  SizedBox buildAddContactButton(BuildContext context) {
    return SizedBox(
      height: 55.h,
      child: FittedBox(
          child: FloatingActionButton.small(
              elevation: 0,
              onPressed: () {
                context.read<ProductListBloc>().add(ClearProductToListEvent());
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddQuotePage(true, "", ""),
                    )).then((value) => firstTimeLoad());
              },
              child: Lottie.asset('assets/lottie/adding.json'))),
    );
  }

  Future<void> getQuote() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    Map<String, dynamic> queryParameters = {
      'operation': 'query',
      'sessionName':
          preferences.getString(PreferenceString.sessionName).toString(),
      'query': Constants.of().apiKeyQuote, //2017
      'module_name': 'Quotes',
      /* 'assigned_user_id':
          preferences.getString(PreferenceString.userId).toString(),*/
    };
    quoteBloc.add(GetQuoteListEvent(queryParameters));
  }
}

class QuoteDetail extends StatefulWidget {
  var id;

  Result? quoteData;

  String? quoteNo;

  QuoteDetail(this.id, {Key? key, this.quoteData, this.quoteNo})
      : super(key: key);

  @override
  State<QuoteDetail> createState() => _QuoteDetailState();
}

class _QuoteDetailState extends State<QuoteDetail> {
  Future<dynamic>? getDetail;
  var dataQuote;
  List<String> contactList = [];
  bool isLoading = false;
  String pdfURL = "";

  @override
  void initState() {
    super.initState();
    getPDFUrl();
  }

  Future<dynamic> getPDFUrl() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    Map<String, dynamic> queryParameters = {
      'operation': "retrieve_quote_pdf_url",
      'sessionName':
          preferences.getString(PreferenceString.sessionName).toString(),
      'id': widget.id.toString(),
      'pdf_type': 'preview'
    };
    final response = await HttpActions()
        .getMethod(ApiEndPoint.getContactListApi, queryParams: queryParameters);

    debugPrint("PDF URL --- $response");
    pdfURL = response["result"];
    return response;
  }

  @override
  Widget build(BuildContext context) {
    getDetail = getContactDetail(widget.id, context);
    var query = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: AppColors.backWhiteColor,
        appBar: BaseAppBar(
            appBar: AppBar(),
            title: widget.quoteData?.quoteNo ?? widget.quoteNo.toString(),
            titleTextStyle: CustomTextStyle.labelMediumBoldFontText,
            isBack: true,
            elevation: 1,
            backgroundColor: AppColors.whiteColor,
            searchWidget: Container()),
        body: Stack(
          children: [
            FutureBuilder<dynamic>(
                future: getDetail,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    dataQuote = snapshot.data["result"];
                    List<dynamic> itemList = dataQuote["LineItems"] ?? [];
                    //itemList = itemList.reversed.toList();
                    return SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.sp),
                        child: Column(
                          children: [
                            SizedBox(height: 13.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                //pdf
                                Tooltip(
                                    message: 'Preview Quote',
                                    child: Card(
                                      elevation: 5,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0))),
                                      child: SizedBox(
                                        height: query.height * 0.05,
                                        width: query.width * 0.10,
                                        child: TextButton(
                                            style: ButtonStyle(
                                                foregroundColor: MaterialStateProperty.all<Color>(
                                                    AppColors.primaryColor),
                                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(
                                                            10.0),
                                                        side: BorderSide(
                                                            color: AppColors
                                                                .transparent,
                                                            width: 0)))),
                                            onPressed: () =>
                                                UrlLauncher.launch(pdfURL),
                                            child: Icon(Icons.picture_as_pdf_outlined,
                                                color: AppColors.primaryColor)),
                                      ),
                                    )),

                                //email
                                Tooltip(
                                  message: 'Send Email with PDF',
                                  child: Card(
                                    elevation: 5.0,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0))),
                                    child: SizedBox(
                                      height: query.height * 0.05,
                                      width: query.width * 0.10,
                                      child: TextButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (context) {
                                                return Dialog(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                    elevation: 0,
                                                    insetAnimationCurve:
                                                        Curves.decelerate,
                                                    insetPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 8.sp),
                                                    child: SendEmail(
                                                        contactList,
                                                        widget.id,
                                                        dataQuote[
                                                            "quotes_email"],
                                                        ""));
                                              });
                                        },
                                        clipBehavior: Clip.hardEdge,
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColors.whiteColor,
                                          splashFactory: NoSplash.splashFactory,
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0))),
                                        ),
                                        child: Icon(Icons.email_outlined,
                                            color: AppColors.primaryColor),
                                      ),
                                    ),
                                  ),
                                ),

                                //edit
                                if (dataQuote["quotestage"] == "Accepted")
                                  Container()
                                else
                                  Tooltip(
                                      message: 'Edit Quote',
                                      child: Card(
                                        elevation: 5,
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0))),
                                        child: SizedBox(
                                          height: query.height * 0.05,
                                          width: query.width * 0.10,
                                          child: TextButton(
                                              style: ButtonStyle(
                                                  foregroundColor: MaterialStateProperty.all<Color>(
                                                      AppColors.primaryColor),
                                                  shape: MaterialStateProperty.all<
                                                          RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  10.0),
                                                          side: BorderSide(
                                                              color: AppColors
                                                                  .transparent,
                                                              width: 0)))),
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            AddQuotePage(true,
                                                                "", "edit",
                                                                dataQuote:
                                                                    dataQuote,
                                                                itemList:
                                                                    itemList))).then(
                                                    (value) {
                                                  setState(() {});
                                                });
                                              },
                                              child: Icon(Icons.edit_outlined,
                                                  color: AppColors.primaryColor)),
                                        ),
                                      )),

                                //copy
                                Tooltip(
                                    message: 'Duplicate Quote',
                                    child: Card(
                                      elevation: 5,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0))),
                                      child: SizedBox(
                                        height: query.height * 0.05,
                                        width: query.width * 0.10,
                                        child: TextButton(
                                            style: ButtonStyle(
                                                foregroundColor: MaterialStateProperty.all<Color>(
                                                    AppColors.primaryColor),
                                                shape: MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(
                                                            10.0),
                                                        side: BorderSide(
                                                            color: AppColors
                                                                .transparent,
                                                            width: 0)))),
                                            onPressed: () {
                                              callNextScreen(
                                                  context,
                                                  AddQuotePage(true, "", "copy",
                                                      dataQuote: dataQuote,
                                                      itemList: itemList));
                                            },
                                            child: Icon(Icons.content_copy,
                                                color: AppColors.primaryColor)),
                                      ),
                                    )),

                                //job create
                                if (dataQuote["quotestage"] == "Accepted")
                                  Container()
                                else
                                  Tooltip(
                                      message: 'Generate Job',
                                      child: Card(
                                        elevation: 5,
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0))),
                                        child: SizedBox(
                                          height: query.height * 0.05,
                                          width: query.width * 0.10,
                                          child: TextButton(
                                              style: ButtonStyle(
                                                  foregroundColor: MaterialStateProperty.all<Color>(
                                                      AppColors.primaryColor),
                                                  shape: MaterialStateProperty.all<
                                                          RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  10.0),
                                                          side: BorderSide(
                                                              color: AppColors
                                                                  .transparent,
                                                              width: 0)))),
                                              onPressed: () {
                                                callNextScreen(
                                                    context,
                                                    AddJobPage(
                                                        quoteItem:
                                                            widget.quoteData));
                                              },
                                              child: Icon(Icons.sync_rounded,
                                                  color: AppColors.primaryColor)),
                                        ),
                                      ))
                              ],
                            ),
                            SizedBox(height: 13.h),
                            ExpansionTile(
                              initiallyExpanded: false,
                              iconColor: AppColors.primaryColor,
                              onExpansionChanged: (value) {
                                Provider.of<WidgetChange>(context,
                                        listen: false)
                                    .isExpansionTileFirst(value);
                              },
                              textColor: AppColors.blackColor,
                              collapsedBackgroundColor: AppColors.whiteColor,
                              title: Text(LabelString.lblPersonalDetail,
                                  style: Provider.of<WidgetChange>(context,
                                              listen: true)
                                          .isExpansionOne
                                      ? GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                              fontSize: 14.sp,
                                              color: AppColors.primaryColor,
                                              fontWeight: FontWeight.w500))
                                      : TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500)),
                              trailing: SvgPicture.asset(
                                Provider.of<WidgetChange>(context, listen: true)
                                        .isExpansionOne
                                    ? ImageString.imgAccordion
                                    : ImageString.imgAccordionClose,
                                height: 16.h,
                                width: 16.w,
                              ),
                              backgroundColor: AppColors.whiteColor,
                              children: [buildPersonalDetail(dataQuote)],
                            ),
                            SizedBox(height: 14.h),
                            ExpansionTile(
                                iconColor: AppColors.primaryColor,
                                onExpansionChanged: (value) {
                                  Provider.of<WidgetChange>(context,
                                          listen: false)
                                      .isExpansionTileSecond(value);
                                },
                                initiallyExpanded: true,
                                textColor: AppColors.blackColor,
                                collapsedBackgroundColor: AppColors.whiteColor,
                                title: Text(LabelString.lblProductDetail,
                                    style: Provider.of<WidgetChange>(context,
                                                listen: true)
                                            .isExpansionTwo
                                        ? GoogleFonts.roboto(
                                            textStyle: TextStyle(
                                                fontSize: 14.sp,
                                                color: AppColors.primaryColor,
                                                fontWeight: FontWeight.w500))
                                        : TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500)),
                                backgroundColor: AppColors.whiteColor,
                                trailing: SvgPicture.asset(
                                  Provider.of<WidgetChange>(context,
                                              listen: true)
                                          .isExpansionTwo
                                      ? ImageString.imgAccordion
                                      : ImageString.imgAccordionClose,
                                  height: 16.h,
                                  width: 16.h,
                                ),
                                children: [
                                  buildProductDetail(dataQuote, itemList)
                                ]),
                            SizedBox(height: 15.h),
                            Container(
                              color: Colors.transparent,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  //hdndiscountTotal
                                  //BottomSheetDataTile("Sub Total", "£${(double.parse(dataQuote["hdnsubTotal"])+double.parse(dataQuote["hdndiscountTotal"])).formatAmount()}",CustomTextStyle.labelFontHintText),
                                  BottomSheetDataTile(
                                      LabelString.lblSubTotal,
                                      "£${(double.parse(dataQuote["hdnsubTotal"]))}",
                                      CustomTextStyle.labelFontHintText),
                                  SizedBox(height: 7.h),
                                  BottomSheetDataTile(
                                      LabelString.lblDiscountAmount,
                                      "£${dataQuote["hdndiscountTotal"].toString().formatAmount}",
                                      CustomTextStyle.labelFontHintText),
                                  SizedBox(height: 7.h),
                                  //Item total which is subtotal minus discount amount
                                  //BottomSheetDataTile("Items Total", "£${((dataQuote["hdnsubTotal"].toString().formatDouble()-dataQuote["hdndiscountTotal"].toString().formatDouble())+double.parse(dataQuote["hdndiscountTotal"])).toString().formatAmount}",CustomTextStyle.labelFontHintText),
                                  BottomSheetDataTile(
                                      LabelString.lblItemsTotal,
                                      "£${((dataQuote["hdnsubTotal"].toString().formatDouble() - dataQuote["hdndiscountTotal"].toString().formatDouble())).toString().formatAmount}",
                                      CustomTextStyle.labelFontHintText),
                                  SizedBox(height: 7.h),
                                  BottomSheetDataTile(
                                      LabelString.lblVatTotal,
                                      "£${dataQuote["pre_tax_total"].toString().formatAmount}",
                                      CustomTextStyle.labelFontHintText),
                                  SizedBox(height: 7.h),
                                  BottomSheetDataTile(
                                      LabelString.lblDepositAmount,
                                      "£${dataQuote["quotes_deposite_amount"].toString().formatAmount}",
                                      CustomTextStyle.labelFontHintText),
                                  SizedBox(height: 7.h),
                                  Divider(
                                      color: AppColors.hintFontColor,
                                      thickness: 1.sp,
                                      endIndent: 8.sp,
                                      indent: 8.sp),
                                  SizedBox(height: 1.h),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 14.sp, vertical: 5.sp),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(LabelString.lblTotalProfit,
                                            style: GoogleFonts.roboto(
                                                textStyle: TextStyle(
                                                    fontSize: 14.sp,
                                                    color:
                                                        AppColors.primaryColor,
                                                    fontWeight:
                                                        FontWeight.w400))),
                                        Text(
                                            "£${dataQuote["hdnprofitTotal"].toString().formatAmount}",
                                            style:
                                                CustomTextStyle.commonTextBlue),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 0.5.h),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 14.sp, vertical: 5.sp),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(LabelString.lblGrandTotal,
                                            style: GoogleFonts.roboto(
                                                textStyle: TextStyle(
                                                    fontSize: 14.sp,
                                                    color:
                                                        AppColors.primaryColor,
                                                    fontWeight:
                                                        FontWeight.w600))),
                                        Text(
                                            "£${dataQuote["hdnGrandTotal"].toString().formatAmount}",
                                            style: GoogleFonts.roboto(
                                                textStyle: TextStyle(
                                                    fontSize: 24.sp,
                                                    color:
                                                        AppColors.primaryColor,
                                                    fontWeight:
                                                        FontWeight.w800))),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 1.h),
                                ],
                              ),
                            )
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
            Visibility(
                visible: isLoading,
                child: Align(
                    alignment: Alignment.center,
                    child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                        child: Container(
                          height: query.height,
                          width: query.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0)),
                          child: loadingView(),
                        )))),
          ],
        ));
  }

  buildProductDetail(dataQuote, List<dynamic> itemList) {
    return Container(
      color: AppColors.primaryColorLawOpacityBack,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 5.sp),
        child: ListView.separated(
            shrinkWrap: true,
            reverse: false,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: itemList.length,
            itemBuilder: (context, index) {
              return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r)),
                elevation: 3,
                child: Column(
                  children: [
                    // SizedBox(height: 7.h),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 11.sp, vertical: 10.sp),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Container(
                              height: 80.h,
                              width: 80.w,
                              color: AppColors.backWhiteColor,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 11.sp, vertical: 10.sp),
                                child: itemList[index]["imagename"] == "_"
                                    ? SizedBox(
                                        height: 50.h,
                                        width: 60.w,
                                        child: SvgPicture.asset(
                                            ImageString.imgPlaceHolder))
                                    : Image.network(
                                        "${ImageBaseUrl.productImageBaseUrl}${itemList[index]["imagename"].toString().replaceAll("&ndash;", "–")}",
                                        height: 50.h,
                                        width: 60.w,
                                        fit: BoxFit.contain,
                                      ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            itemList[index]["prod_name"] == null
                                ? "Installation (1st & 2nd fix)"
                                : itemList[index]["prod_name"]
                                    .toString()
                                    .replaceAll("&amp;", "&"),
                            style: TextStyle(
                                fontSize: 14.sp, fontWeight: FontWeight.w400),
                          ),
                        ),
                        Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                shape: BoxShape.circle,
                              ),
                              child: itemList[index]["quantity"] == "1.000"
                                  ? // Condition for set item and items keywork
                                  Text(
                                      "${itemList[index]["quantity"].toString().substring(0, itemList[index]["quantity"].toString().indexOf("."))} ",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.roboto(
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ))
                                  : Text(
                                      "${itemList[index]["quantity"].toString().substring(0, itemList[index]["quantity"].toString().indexOf("."))} ",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.roboto(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      )),
                            ),

                            IconButton(
                                iconSize: 20.h,
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Dialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          elevation: 0,
                                          child: itemDescription(
                                              itemList[index]["prod_name"] ??
                                                  "Installation (1st & 2nd fix)",
                                              itemList[index][
                                                      "pro_short_description"] ??
                                                  "",
                                              itemList[index]));
                                    },
                                  );
                                },
                                icon: Icon(
                                  Icons.info_outline,
                                  color: AppColors.blackColor,
                                )),
                            // const Text(""),
                          ],
                        ),
                        SizedBox(
                          width: 5.sp,
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.sp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (itemList[index]["required_document"] != "")
                            TextButton(
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
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              20.0),
                                                      child: Text(
                                                          "Attachments - ",
                                                          style: CustomTextStyle
                                                              .labelBoldFontText),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: IconButton(
                                                        icon: Icon(Icons.close,
                                                            color: AppColors
                                                                .blackColor),
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context),
                                                        padding:
                                                            EdgeInsets.zero,
                                                        splashRadius: 10.0),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              // Text(LabelString.lblAttachment,
                                              //   style: CustomTextStyle
                                              //       .labelBoldFontText),
                                              Padding(
                                                  padding: const EdgeInsets.all(
                                                      20.0),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                        itemList[index][
                                                                "required_document"]
                                                            .toString()
                                                            .replaceAll("###",
                                                                "\n-  -  -\n"),
                                                        style: CustomTextStyle
                                                            .labelText),
                                                  )),
                                            ],
                                          ));
                                    },
                                  );
                                },
                                child: Text(LabelString.lblAttachedDocument,
                                    style: GoogleFonts.roboto(
                                        textStyle: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400))))
                          else
                            (Container(height: 1.h)),

                          //View location button will be visible only when user had entered location
                          if (itemList[index]["product_location"] != "")
                            TextButton(
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
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            20.0),
                                                    child: Text("Locations",
                                                        style: CustomTextStyle
                                                            .labelBoldFontText),
                                                  ),
                                                ),
                                                Align(
                                                  alignment: Alignment.topRight,
                                                  child: IconButton(
                                                    icon: Icon(Icons.close,
                                                        color: AppColors
                                                            .blackColor),
                                                    onPressed: () =>
                                                        Navigator.pop(context),
                                                    padding: EdgeInsets.zero,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            // Text(LabelString.lblLocations,
                                            //     style: CustomTextStyle
                                            //         .labelBoldFontText),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(20.0),
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                    itemList[index]
                                                            ["product_location"]
                                                        .toString()
                                                        .replaceAll("###",
                                                            "\n-  -  -\n"),
                                                    style: CustomTextStyle
                                                        .labelText),
                                              ),
                                            ),
                                          ],
                                        ));
                                  },
                                );
                              },
                              child: Text(LabelString.lblViewLocation,
                                  style: CustomTextStyle.commonTextBlue),
                            )
                          else
                            (Container(height: 1.h)),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                Container(height: 10.h)),
      ),
    );
  }

  Container buildPersonalDetail(dataQuote) {
    return Container(
      color: AppColors.primaryColorLawOpacityBack,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.sp, vertical: 10.sp),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 6.h),
            Text(dataQuote["subject"].toString(),
                style: CustomTextStyle.labelMediumBoldFontText),
            SizedBox(height: 6.h),
            Text(dataQuote["quotes_company"].toString(),
                style: CustomTextStyle.labelText),
            SizedBox(height: 5.h),
            Wrap(
              alignment: WrapAlignment.start,
              children: [
                InkWell(
                    onTap: () => sendMail(dataQuote["quotes_email"], context),
                    child: Text(dataQuote["quotes_email"],
                        style: TextStyle(
                            fontSize: 14.sp, color: AppColors.primaryColor))),
                dataQuote["quote_mobile_number"] == ""
                    ? Container()
                    : Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.sp),
                        child: Container(
                            color: AppColors.hintFontColor,
                            height: 12.h,
                            width: 2.w)),
                InkWell(
                    onTap: () => callFromApp(
                        dataQuote["quote_mobile_number"].toString()),
                    child: Text(dataQuote["quote_mobile_number"],
                        style: CustomTextStyle.labelText)),
              ],
            ),
            SizedBox(height: 5.h),
            QuoteTileField(
                LabelString.lblPremisesType, dataQuote["premises_type"]),
            QuoteTileField(LabelString.lblSystemType, dataQuote["system_type"]),
            QuoteTileField(
                LabelString.lblGradeNumber, dataQuote["grade_number"]),
            QuoteTileField(
                LabelString.lblSignallingType, dataQuote["signalling_type"]),
            QuoteTileField(
                LabelString.lblQuotePayment, dataQuote["quotes_payment"]),
            SizedBox(height: 9.h),
            RichText(
              text: TextSpan(
                  text: "${LabelString.lblInvoiceAddress} : ",
                  style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w500)),
                  children: [
                    TextSpan(
                        text:
                            "\n${dataQuote["bill_street"]}, ${dataQuote["bill_city"]}, ${dataQuote["bill_country"]}, ${dataQuote["bill_code"]}",
                        style: CustomTextStyle.labelText)
                  ]),
            ),
            SizedBox(height: 6.h),
            RichText(
              text: TextSpan(
                  text: "${LabelString.lblInstallationAddress} : ",
                  style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w500)),
                  children: [
                    TextSpan(
                        text:
                            "\n${dataQuote["ship_street"]}, ${dataQuote["ship_city"]}, ${dataQuote["ship_country"]}, ${dataQuote["ship_code"]}",
                        style: CustomTextStyle.labelText)
                  ]),
            ),
          ],
        ),
      ),
    );
  }

  //Item Description dialog
  Widget itemDescription(String productName, String description, itemList) {
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
                    style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black))),
                IconButton(
                    highlightColor: AppColors.transparent,
                    splashColor: AppColors.transparent,
                    onPressed: () => Navigator.pop(context),
                    icon:
                        Icon(Icons.close_rounded, color: AppColors.blackColor)),
              ],
            ),
            SizedBox(height: 10.h),
            Text(productName,
                style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black))),
            SizedBox(height: 10.h),
            Text(description, style: CustomTextStyle.labelText),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.only(right: 30.sp),
              child: Column(
                children: [
                  ContactTileField(LabelString.lblCostPrice,
                      "£${itemList["costprice"].toString().formatAmount}",
                      textAlign: TextAlign.end),
                  //Use listPrice as sellingPrice
                  ContactTileField(LabelString.lblSellingPrice,
                      "£${itemList["listprice"].toString().formatAmount}",
                      textAlign: TextAlign.end),
                  ContactTileField(LabelString.lblQty,
                      "${itemList["quantity"].toString().substring(0, itemList["quantity"].toString().indexOf("."))} Items",
                      textAlign: TextAlign.end),
                  ContactTileField(LabelString.lblDiscPrice,
                      "£${itemList["discount_amount"].toString().formatAmount}",
                      textAlign: TextAlign.end),

                  ///Amount calculation
//(listPrice * quantity)- discount
                  ContactTileField(LabelString.lblAmount,
                      "£${((double.parse(itemList["listprice"])) * (double.parse(itemList["quantity"])) - (double.parse(itemList["discount_amount"]))).formatAmount()}",
                      textAlign: TextAlign.end),

                  ///Profit calculation
//(listPrice-costPrice)*quantity
                  //finalProfit == "-0.00" ? "0.00" : finalProfit,
                  ContactTileField(
                      LabelString.lblProfit,
                      "£${(((double.parse(itemList["listprice"]) - double.parse(itemList["costprice"])) * double.parse(itemList["quantity"])) - (double.parse(itemList["discount_amount"]))).formatAmount()}" ==
                              "-0.00"
                          ? "0.00"
                          : "£${(((double.parse(itemList["listprice"]) - double.parse(itemList["costprice"])) * double.parse(itemList["quantity"])) - (double.parse(itemList["discount_amount"]))).formatAmount()}",
                      textAlign: TextAlign.end),
                ],
              ),
            ),
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
                style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w500))),
          ),
          Expanded(
              child: Text(
                  textAlign: textAlign,
                  fieldDetail!,
                  style: CustomTextStyle.labelText))
        ],
      ),
    );
  }
}
