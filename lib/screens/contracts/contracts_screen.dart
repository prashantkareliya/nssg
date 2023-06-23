import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../../components/custom_text_styles.dart';
import '../../constants/constants.dart';
import '../../constants/strings.dart';
import '../../utils/app_colors.dart';
import '../../utils/helpers.dart';
import '../../utils/widgetChange.dart';
import '../../utils/widgets.dart';
import '../contracts/get_contract/contract_model_dir/get_contract_response_model.dart';
import 'contract_datasource.dart';
import 'contract_repository.dart';
import 'get_contract/contract_bloc_dir/get_contract_bloc.dart';
import 'quote_type_selection_screen.dart';

class ContractListScreen extends StatefulWidget {
  const ContractListScreen({Key? key}) : super(key: key);

  @override
  State<ContractListScreen> createState() => _ContractListScreenState();
}

class _ContractListScreenState extends State<ContractListScreen> {
  int _page = 0;
  bool _hasNextPage = true;
  int _totalSize = 0;

  // Used to display loading indicators when _firstLoad function is running
  bool _isFirstLoadRunning = false;
  bool _isLoadMoreRunning = false;
  late ScrollController _controller;

  List<Result>? contractItems = [];
  int count = 0;
  TextEditingController searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
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
      'operation': "query",
      'sessionName': preferences.getString(PreferenceString.sessionName).toString(),
      'query': Constants.of().apiKeyContract,
      'module_name': "ServiceContracts",
      'page': _page
    };
    contractBloc.add(GetContractListEvent(queryParameters));
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
        'operation': "query",
        'sessionName': preferences.getString(PreferenceString.sessionName).toString(),
        'query': Constants.of().apiKeyContract,
        'module_name': "ServiceContracts",
        'page': _page};
      contractBloc.add(GetContractListEvent(queryParameters));
    }
  }

  GetContractBloc contractBloc = GetContractBloc(
      ContractRepository(contractDataSource: ContractDataSource()));
  bool isLoading = false;

  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backWhiteColor,
        body: Column(
          children: [
              buildAppbar(context),
              buildSearchBar(context),
            buildContractList(context)
          ],
        )
      ),
    );
  }

  //Design appbar field
  AnimatedOpacity buildAppbar(BuildContext context) {
    return AnimatedOpacity(
      opacity: Provider.of<WidgetChange>(context, listen: true).isAppbarShow ? 1 : 0,
      duration: const Duration(milliseconds: 500));
  }

  //Design search field
  AnimatedOpacity buildSearchBar(BuildContext context) {
    return AnimatedOpacity(
      opacity: Provider.of<WidgetChange>(context, listen: true).isAppbarShow ? 1 : 1,
      duration: const Duration(milliseconds: 500),
      child: Visibility(
        visible: Provider.of<WidgetChange>(context, listen: true).isAppbarShow ? true : true,
        child: Padding(
          padding: EdgeInsets.only(right: 15.sp, top: 8.sp, left: 0.sp, bottom: 8),
          child: Padding(
            padding: EdgeInsets.only(bottom: 0.sp),
            child: Row(
              children: [
                SizedBox(width: 5.w),
                Expanded(
                  child: Consumer<WidgetChange>(
                    builder: (context, updateKey, search) {
                      return TextField(controller: searchCtrl,
                          onChanged: (value) async {
                            if(searchCtrl.text.isNotEmpty){
                              SharedPreferences preferences = await SharedPreferences.getInstance();

                              Map<String, dynamic> queryParameters = {
                                'operation': "query",
                                'sessionName': preferences.getString(PreferenceString.sessionName).toString(),
                                'query': Constants.of().apiKeyContract,
                                'module_name': "ServiceContracts",
                                'search_param' : searchCtrl.text};
                              contractBloc.add(GetContractListEvent(queryParameters));
                            }else {
                              firstTimeLoad();
                            }
                          },
                          keyboardType: TextInputType.text,
                          autofocus: false,
                          decoration: InputDecoration(
                              hintText: LabelString.lblSearch,
                              suffixIcon: Container(
                                  decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(5),
                                          bottomRight: Radius.circular(5))),
                                  child: Icon(Icons.search,
                                      color: AppColors.whiteColor,
                                      size: 15.sp)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(width: 2, color: AppColors.primaryColor)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(width: 2, color: AppColors.primaryColor)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(width: 2, color: AppColors.primaryColor)),
                              contentPadding: EdgeInsets.only(left: 10.sp, top: 0, bottom: 0)));
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

  BlocListener<GetContractBloc, GetContractState> buildContractList(BuildContext context) {
    return BlocListener<GetContractBloc, GetContractState>(
        bloc: contractBloc,
      listener: (context, state) {
        if (state is ContractsLoadFail) {
          Helpers.showSnackBar(context, state.error.toString());
        }
        if (state is ContractsLoaded) {
          _isFirstLoadRunning = false;
          _isLoadMoreRunning = false;
          _totalSize = state.contractList!.length;

          if (state.contractList!.isEmpty) {
            //_hasNextPage = false;
          } else {
            if (_page == 0) {
              contractItems = state.contractList;
            } else {
              contractItems!.addAll(state.contractList!);
            }
          }
          if (contractItems!.length == _totalSize) {
            // _hasNextPage = false;
          }
        }
      },
    child: BlocBuilder<GetContractBloc, GetContractState>(
      bloc: contractBloc,
      builder: (context, state) {

          if (state is ContractLoadingState) {
            isLoading = state.isBusy;
          }
          if (state is ContractsLoaded) {
            isLoading = false;
          }
          if (state is ContractsLoadFail) {
            isLoading = false;
          }
    
      return Expanded(
        child: _isFirstLoadRunning && isLoading ? loadingView() : RefreshIndicator(
        onRefresh: () => firstTimeLoad(),
        child: Column(
          children: [
            Expanded(
              child: AnimationLimiter(
                child: ListView.separated(
                  controller: _controller,
                  padding: EdgeInsets.only(top: 10.sp),
                  physics: const BouncingScrollPhysics(),
                  itemCount: contractItems!.length,
                  itemBuilder: (context, index) {
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        curve: Curves.decelerate,
                        child: FadeInAnimation(
                          child: Padding(
                            padding: EdgeInsets.only(left: 15.sp, right: 15.sp, bottom: 5.sp),
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: Container(decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.circular(12.sp)))),
                                Slidable(
                                  enabled: contractItems![index].subject == "" ? false : true,
                                  endActionPane: ActionPane(
                                    extentRatio: 0.15,
                                    motion: const ScrollMotion(),
                                    children: [CustomSlidableAction(
                                      borderRadius: const BorderRadius.only(
                                        bottomRight: Radius.circular(20.0),
                                        topRight: Radius.circular(20.0)),
                                      padding: EdgeInsets.zero,
                                      autoClose: true,
                                      onPressed: (value) {
                                        Navigator.push(context,
                                          MaterialPageRoute(builder: (context) => QuoteTypeSelection(contractItems![index])));
                                      },
                                      backgroundColor: AppColors.primaryColor,
                                      foregroundColor: AppColors.redColor,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          RotatedBox(quarterTurns: -1,
                                              child: Text(textAlign: TextAlign.center,
                                                  ButtonString.btnCreateQuote,
                                                  style: GoogleFonts.roboto(textStyle: const TextStyle(color: Colors.white)))),
                                          SizedBox(height: 0.8.h),
                                          const Icon(Icons.add_circle_outline, color: Colors.white),
                                        ],
                                      ),
                                    ),
                                    ],
                                  ),
                                  child: Card(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.sp)),
                                    margin: EdgeInsets.zero,
                                    elevation: 2,
                                    child: InkWell(
                                      onTap: () {},
                                      child: Container(width: MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                            color: AppColors.whiteColor,
                                            borderRadius: BorderRadius.circular(12.sp)),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(vertical: 8.sp, horizontal: 15.sp),
                                          child: Column(mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(height: 1.0.h),
                                              //if Contact name of quote is null then we set subject from the list and remove text after the "-"
                                              InkWell(
                                                onTap: () {},
                                                child: Text.rich(
                                                  TextSpan(text: "",
                                                    style: GoogleFonts.roboto(
                                                        textStyle: TextStyle(
                                                            fontSize: 15.sp,
                                                            color: AppColors.fontColor,
                                                            fontWeight: FontWeight.bold)),
                                                    children: [
                                                      TextSpan(text: contractItems![index].subject,
                                                          style: GoogleFonts.roboto(
                                                              textStyle: TextStyle(fontSize: 13.sp,
                                                                  color: AppColors.fontColor,
                                                                  fontWeight: FontWeight.bold)))
                                                    ],
                                                  ),
                                                ),
                                              ),

                                                  SizedBox(height: 2.5.h),
                                                  Text(contractItems![index].scStatus.toString(),
                                                      style: CustomTextStyle.labelText),
                                                  SizedBox(height: 1.0.h),
                                                  Text.rich(TextSpan(text: contractItems![index].serConAddress ?? "",
                                                      style: CustomTextStyle.labelText,
                                                      children: [
                                                        if (contractItems![index].serConAddress !="" &&
                                                            contractItems![index].serConAddress != null)
                                                          const TextSpan(text: ", "),

                                                        TextSpan(text: contractItems![index].serConCity ?? "",
                                                            style: CustomTextStyle.labelText),
                                                        if (contractItems![index].serConCity != "" &&
                                                            contractItems![index].serConCity != null)
                                                          const TextSpan(text: ", "),

                                                        TextSpan(text: contractItems![index].serConCountry ?? "",
                                                            style: CustomTextStyle.labelText),
                                                        if (contractItems![index].serConCountry != "" &&
                                                            contractItems![index].serConCountry != null)
                                                          const TextSpan(text: ", "),

                                                    TextSpan(text: contractItems![index].postcode ?? "",
                                                        style: CustomTextStyle.labelText)
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: 0.5.h),
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
                  separatorBuilder: (BuildContext context, int index) {
                    return Container(height: 10.sp);
                  })),
            ),
            if (_isLoadMoreRunning == true)
              Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 20),
                  child: Center(child: loadingView())),
          ],
        ),
      ),
    );
  },
),
);
  }}
