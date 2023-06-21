import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nssg/components/svg_extension.dart';
import 'package:nssg/constants/navigation.dart';
import 'package:nssg/constants/strings.dart';
import 'package:nssg/screens/contact/contact_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:sizer/sizer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../components/custom_button.dart';
import '../../../components/custom_radio_button.dart';
import '../../../components/custom_rounded_container.dart';
import '../../../components/custom_text_styles.dart';
import '../../../components/global_api_call.dart';
import '../../../constants/constants.dart';
import '../../../httpl_actions/app_http.dart';
import '../../../httpl_actions/handle_api_error.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/helpers.dart';
import '../../../utils/preferences.dart';
import '../../../utils/widgetChange.dart';
import '../../../utils/widgets.dart';
import '../../contact/contact_datasource.dart';
import '../../contact/contact_repository.dart';
import '../../contact/get_contact/contact_bloc_dir/get_contact_bloc.dart';
import '../../contact/get_contact/contact_model_dir/get_contact_response_model.dart';
import '../bloc/product_list_bloc.dart';
import 'add_item_screen.dart';
import 'build_item_screen.dart';

///First step to create quote
class AddQuotePage extends StatefulWidget {
  bool isBack;
  String? contactId;
  String? firstName;
  String? lastName;
  var contactDetail;

  var dataQuote;
  List<dynamic>? itemList;
  var contractList;

  AddQuotePage(this.isBack, this.firstName, this.lastName,
      {Key? key,
      this.contactId,
      this.contactDetail,
      this.dataQuote,
      this.itemList,
      this.contractList})
      : super(key: key);

  @override
  State<AddQuotePage> createState() =>
      _AddQuotePageState(dataQuote, itemList, contractList);
}

class _AddQuotePageState extends State<AddQuotePage> {
  PageController pageController = PageController();

  //For manage stem container number
  StreamController<int> streamController = StreamController<int>.broadcast();
  List<Result>? contactItems = []; //this list for API call
  List contactData = []; // this list for set data in contact
  List siteAddressList = [];

  String? contactId;
  String? contactEmail;
  String? contactCompany;
  String? mobileNumber;
  String? telephoneNumber;
  Future<dynamic>? getFields;

  //object for estimated installation amount
  String? eAmount = "0.0";

  String? engineerNumbers;

  String? timeType;

  //Radio selection strings
  String contactSelect = "";
  String premisesTypeSelect = "";
  String systemTypeSelect = "";
  String gradeFireSelect = "";
  String signallingTypeSelect = "";
  String quotePaymentSelection = "";
  String termsItemSelection = "";

  var dropdownvalue;

  var dataQuote;
  List<dynamic>? itemList = [];
  var contractList;

  _AddQuotePageState(this.dataQuote, this.itemList, this.contractList);

  @override
  void initState() {
    super.initState();
    getContactList();

    print(itemList);
    print(dataQuote);
    //for create quote after the create contact
    //set contact by default in auto complete textField in create quote screen

    if (!widget.isBack) {
      print(widget.contactDetail.id);
      getSiteAddressList();
      contactId = widget.contactDetail.id;
      contactCompany = widget.contactDetail.contactCompany;
      mobileNumber = widget.contactDetail.mobile;
      telephoneNumber = widget.contactDetail.phone;
      contactEmail = widget.contactDetail.email;

      invoiceAddress = widget.contactDetail.mailingstreet;
      invoiceCity = widget.contactDetail.mailingcity;
      invoiceCountry = widget.contactDetail.mailingcountry;
      invoicePostal = widget.contactDetail.mailingzip;

      installationAddress = widget.contactDetail.otherstreet;
      installationCity = widget.contactDetail.othercity;
      installationCountry = widget.contactDetail.othercountry;
      installationPostal = widget.contactDetail.otherzip;
    } else if (dataQuote != null) {
      contactId = dataQuote["contact_id"];
      contactCompany = dataQuote["quotes_company"];
      mobileNumber = dataQuote["quote_mobile_number"];
      telephoneNumber = dataQuote["quote_telephone_number"];
      contactEmail = dataQuote["quotes_email"];

      invoiceAddress = dataQuote["bill_street"];
      invoiceCity = dataQuote["bill_city"];
      invoiceCountry = dataQuote["bill_country"];
      invoicePostal = dataQuote["bill_pobox"];

      installationAddress = dataQuote["ship_street"];
      installationCity = dataQuote["ship_city"];
      installationCountry = dataQuote["ship_country"];
      installationPostal = dataQuote["ship_pobox"];
    } else if (contractList != null) {
      contactId = contractList.scRelatedTo;
      contactCompany = contractList.serConCompany;
      mobileNumber = contractList.mobileNumber;
      telephoneNumber = contractList.telephoneNumber;
      contactEmail = contractList.email;

      invoiceAddress = contractList.serConInvAddress;
      invoiceCity = contractList.serConInvCity;
      invoiceCountry = contractList.serConInvCountry;
      invoicePostal = contractList.serConInvPostcode;

      installationAddress = contractList.serConAddress;
      installationCity = contractList.serConCity;
      installationCountry = contractList.serConCountry;
      installationPostal = contractList.postcode;
    }

    if (widget.lastName == "edit" || widget.lastName == "contract") {
      getSiteAddressList();
      //dropdownvalue = dataQuote["quotestage"].toString().toMap();
    }
    context.read<ProductListBloc>().add(ClearProductToListEvent());
  }

  GetContactBloc contactBloc =
      GetContactBloc(ContactRepository(contactDataSource: ContactDataSource()));
  bool isLoading = false;

  //In this method Calling get contact API
  getContactList() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    Map<String, dynamic> queryParameters = {
      'operation': 'query',
      'sessionName':
          preferences.getString(PreferenceString.sessionName).toString(),
      'query': Constants.of().apiKeyContact, //2017
      'module_name': 'Contacts'
    };
    contactBloc.add(GetContactListEvent(queryParameters));
  }

  //In this set contact list for select contact field
  getContact() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? contact = preferences.getString(PreferenceString.contactList);
    contactData = jsonDecode(contact!);
  }

  //Call api for get site address if any contact has two site address.
  // fill value in dropdown button
  Future getSiteAddressList() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    Map<String, dynamic> queryParameters = {
      'operation': "retrieve_related",
      'id':
          widget.isBack ? contactId : widget.contactId.toString(), //"12x5558",
      'relatedType': "SitesAddress",
      'relatedLabel': "Sites Address",
      'sessionName':
          preferences.getString(PreferenceString.sessionName).toString(),
    };
    final response = await HttpActions()
        .getMethod(ApiEndPoint.getContactListApi, queryParams: queryParameters);
    debugPrint("getContactDetailApiDropdown --- $response");

    if (response["success"] == true) {
      siteAddressList = response["result"];
    }
  }

  TextEditingController invoiceSearchController = TextEditingController();

  //Address information's textField controllers(invoice Address)
  String invoiceAddress = "";
  String invoiceCity = "";
  String invoiceCountry = "";
  String invoicePostal = "";
  String installationAddress = "";
  String installationCity = "";
  String installationCountry = "";
  String installationPostal = "";

  //This lists for add quote dropdown fields
  //Here we use radio button instead of dropdown
  List<RadioModel> numbersOfEng = <RadioModel>[]; //step 1
  List<RadioModel> installationTiming = <RadioModel>[]; //step 1
  List<RadioModel> premisesType = <RadioModel>[]; //step 2
  List<RadioModel> systemType = <RadioModel>[]; //step 3
  List<RadioModel> gradeAndFire = <RadioModel>[]; //step 4
  List<RadioModel> signallingType = <RadioModel>[]; //step 4
  List<RadioModel> quotePayment = <RadioModel>[]; //step 5
  List<RadioModel> termsList = <RadioModel>[]; //step 5
  String page = "0";

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    getFields = getQuoteFields("Quotes", context);

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 1,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leadingWidth: 50.w,
        leading: InkWell(
          highlightColor: AppColors.transparent,
          splashColor: AppColors.transparent,
          onTap: () {
            if (page == "0") {
              Navigator.pop(context);
            } else {
              pageController.previousPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.decelerate);
            }
          },
          child: Icon(Icons.arrow_back_ios_outlined,
              color: AppColors.blackColor, size: 16.sp),
        ),
        title: Text(
            widget.lastName == "edit"
                ? LabelString.lblEditQuote
                : LabelString.lblAddNewQuote,
            style: CustomTextStyle.labelMediumBoldFontText),
      ),
      body: BlocListener<GetContactBloc, GetContactState>(
        bloc: contactBloc,
        listener: (context, state) {
          if (state is ContactLoadFail) {
            Helpers.showSnackBar(context, state.error.toString());
          }

          if (state is ContactsLoaded) {
            contactItems = state.contactList;
            isDelete = false;
            preferences.setPreference(
                PreferenceString.contactList, jsonEncode(state.contactList));
            getContact();
          }
        },
        child: BlocBuilder<GetContactBloc, GetContactState>(
          bloc: contactBloc,
          builder: (context, state) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 10),
                  child: StreamBuilder<int>(
                    initialData: 0,
                    stream: streamController.stream,
                    builder: (context, snapshot) {
                      return Column(
                        children: [
                          //Round Container with step number
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                snapshot.data! <= 0
                                    ? Container(width: 19.5.w)
                                    : InkWell(
                                        onTap: () => pageController
                                            .jumpToPage(snapshot.data! - 1),
                                        child: RoundedContainer(
                                            containerText: "",
                                            stepText: snapshot.data.toString(),
                                            isEnable: false,
                                            isDone: true)),
                                InkWell(
                                    onTap: () => pageController
                                        .jumpToPage(snapshot.data!),
                                    child: RoundedContainer(
                                        containerText:
                                            (snapshot.data! + 1).toString(),
                                        stepText:
                                            (snapshot.data! + 1).toString(),
                                        isEnable: true,
                                        isDone: false)),
                                snapshot.data! >= 2
                                    ? Container()
                                    : InkWell(
                                        onTap: () => pageController
                                            .jumpToPage(snapshot.data! + 1),
                                        child: RoundedContainer(
                                            containerText:
                                                (snapshot.data! + 2).toString(),
                                            stepText:
                                                (snapshot.data! + 2).toString(),
                                            isEnable: false,
                                            isDone: false))
                              ]),
                          SizedBox(height: 2.h),

                          //Linear progress indicator which set below steps container
                          StepProgressIndicator(
                            padding: 0.0,
                            totalSteps: 3,
                            size: 2.sp,
                            currentStep: snapshot.data!,
                            selectedColor: AppColors.primaryColor,
                            unselectedColor: AppColors.transparent,
                            customColor: (index) {
                              if (index == snapshot.data) {
                                return AppColors.primaryColor;
                              } else {
                                return index == 5
                                    ? AppColors.redColor
                                    : Colors.transparent;
                              }
                            },
                          ),

                          Padding(
                            padding: EdgeInsets.only(
                                left: 10.sp, right: 10.sp, top: 8.sp),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(LabelString.lblQuoteDetails,
                                    style: GoogleFonts.roboto(
                                        textStyle: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w700))),
                                Row(
                                  children: [
                                    Text(LabelString.lblStep,
                                        style: CustomTextStyle.commonText),
                                    Text(" ${snapshot.data! + 1}/3",
                                        style: GoogleFonts.roboto(
                                            textStyle: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w400))),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ),
                FutureBuilder<dynamic>(
                  //Call API for set quote fields
                  future: getFields,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var fieldsData = snapshot.data["result"];
                      return Expanded(
                        child: InkWell(
                          onTap: () => FocusScope.of(context).unfocus(),
                          highlightColor: AppColors.transparent,
                          splashColor: AppColors.transparent,
                          focusColor: AppColors.transparent,
                          child: PageView(
                            scrollDirection: Axis.horizontal,
                            pageSnapping: true,
                            physics: const BouncingScrollPhysics(),
                            controller: pageController,
                            onPageChanged: (number) {
                              streamController.add(number);
                              Provider.of<WidgetChange>(context, listen: false)
                                  .pageNumber(number.toString());
                              page = Provider.of<WidgetChange>(context,
                                      listen: false)
                                  .pageNo;
                            },
                            children: [
                              //Premises type and contact selection design
                              buildStepOne(context, query, fieldsData),

                              //System type selection design
                              buildStepTwo(context, query, fieldsData),

                              //Grade - Signalling type design
                              buildStepThree(context, query, fieldsData),
                            ],
                          ),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      final message = HandleAPI.handleAPIError(snapshot.error);
                      return Text(message);
                    }
                    return SizedBox(height: 70.h, child: loadingView());
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  ///step 1- Premises type and select contact
  Padding buildStepOne(BuildContext context, Size query, stepOneData) {
    ValueNotifier<bool> notifier = ValueNotifier(false);
    //Contact name shows in all different conditions.
    String contactName = "";
    if (dataQuote != null) {
      contactName = dataQuote["contact_name"];
    } else if (contractList != null) {
      contactName = contractList.subject.toString().contains("-")
          ? contractList.subject
              .toString()
              .substring(0, contractList.subject.toString().indexOf("-"))
          : contractList.subject.toString();
    } else {
      contactName = "${widget.firstName}${widget.lastName}";
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 12.sp),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Design Auto filled contact
            Autocomplete(
              initialValue: TextEditingValue(text: contactName),
              fieldViewBuilder: (context, textEditingController, focusNode,
                  VoidCallback onFieldSubmitted) {
                FocusNode focus = focusNode;
                if (dataQuote != null) {
                  contactSelect = dataQuote["contact_name"];
                } else if (contractList != null) {
                  contactSelect = contractList.subject.toString().contains("-")
                      ? contractList.subject.toString().substring(
                          0, contractList.subject.toString().indexOf("-"))
                      : contractList.subject.toString();
                }
                //dataQuote != null ? contactSelect = dataQuote["contact_name"] : "";
                textEditingController.text = contactSelect;
                return TextField(
                  autofocus:
                      widget.isBack || dataQuote != null || contractList != null
                          ? false
                          : true,
                  style:
                      TextStyle(color: AppColors.blackColor, fontSize: 16.sp),
                  textCapitalization: TextCapitalization.none,
                  textInputAction: TextInputAction.next,
                  maxLines: 1,
                  keyboardType: TextInputType.name,
                  cursorColor: AppColors.blackColor,
                  decoration: InputDecoration(
                      suffixIcon:
                          Icon(Icons.search, color: AppColors.blackColor),
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
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.only(left: 12.sp),
                      hintText: LabelString.lblTypeToSearch,
                      hintStyle: GoogleFonts.roboto(
                          textStyle: TextStyle(
                              fontSize: 16.sp, color: AppColors.hintFontColor)),
                      counterText: ""),
                  controller: textEditingController,
                  focusNode: focus,
                  onEditingComplete: () {},
                  onSubmitted: (String value) {},
                  onChanged: (value) {
                    focus = focusNode;
                    focus.requestFocus();
                  },
                );
              },
              optionsBuilder: (TextEditingValue textEditingValue) async {
                if (textEditingValue.text.isEmpty) {
                  return const Iterable<String>.empty();
                } else {
                  List<String> matchesContact = <String>[];
                  matchesContact.addAll(contactData.map((e) {
                    return "${e["firstname"].trim()} ${e["lastname"].trim()} - ${e["otherstreet"]}";
                  }));

                  matchesContact = matchesContact
                      .where((element) => element
                          .toLowerCase()
                          .contains(textEditingValue.text.toLowerCase().trim()))
                      .toList();
                  return matchesContact;
                }
              },
              onSelected: (selection) async {
                FocusScope.of(context).unfocus();
                getSiteAddressList();
                for (int i = 0; i < contactData.length; i++) {
                  if (selection ==
                      "${contactData[i]["firstname"]} ${contactData[i]["lastname"]} - ${contactData[i]["otherstreet"]}") {
                    contactId = contactData[i]["id"];
                    contactCompany = contactData[i]["contact_company"];
                    mobileNumber = contactData[i]["mobile"];
                    telephoneNumber = contactData[i]["phone"];
                    contactEmail = contactData[i]["email"];
                    contactSelect = selection;

                    //When select contact, set address in fields
                    invoiceAddress = contactData[i]["mailingstreet"];
                    invoiceCity = contactData[i]["mailingcity"];
                    invoiceCountry = contactData[i]["mailingcountry"];
                    invoicePostal = contactData[i]["mailingzip"];

                    installationAddress = contactData[i]["otherstreet"];
                    installationCity = contactData[i]["othercity"];
                    installationCountry = contactData[i]["othercountry"];
                    installationPostal = contactData[i]["otherzip"];
                  }
                }
              },
            ),

            //View Contact Button
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                highlightColor: AppColors.transparent,
                splashColor: AppColors.transparent,
                onTap: () {
                  if (contactId != null) {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: ContactDetail(
                                contactId, "quote", dropdownvalue ?? [],
                                dataQuote: dataQuote,
                                contactList: contractList)));
                  } else {
                    Helpers.showSnackBar(context, ErrorString.selectOneContact,
                        isError: true);
                  }
                },
                child: Padding(
                  padding: EdgeInsets.only(top: 9.sp),
                  child: Text(LabelString.lblViewContacts,
                      style: CustomTextStyle.commonTextBlue),
                ),
              ),
            ),
            //if site will not empty then shows dropdown otherwise it will be hide.
            if (siteAddressList.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(top: 9.sp, left: 3.sp, right: 3.sp),
                child: Row(
                  children: [
                    Expanded(
                      child: DropdownButton<Map>(
                          itemHeight: 60.0,
                          style: CustomTextStyle.labelBoldFontText,
                          elevation: 0,
                          icon:
                              Icon(Icons.arrow_drop_down_rounded, size: 24.sp),
                          iconEnabledColor: AppColors.blackColor,
                          iconDisabledColor: AppColors.hintFontColor,
                          underline: Container(
                              height: 1.0, color: AppColors.primaryColor),
                          isDense: false,
                          isExpanded: true,
                          hint: Text(LabelString.lblSelectSiteAddress,
                              style: CustomTextStyle.labelFontHintText),
                          items: siteAddressList.map((item) {
                            return DropdownMenuItem<Map>(
                                value: item,
                                child: Text(
                                    "${item['name']}-${item['address'].toString().replaceAll("\n", ", ")}",
                                    style: CustomTextStyle.labelFontText));
                          }).toList(),
                          onChanged: (newVal) {
                            setState(() {
                              dropdownvalue = newVal;
                            });
                          },
                          value: dropdownvalue),
                    ),
                    InkWell(
                        highlightColor: AppColors.transparent,
                        splashColor: AppColors.transparent,
                        onTap: () {
                          setState(() {
                            dropdownvalue = null;
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.all(4.sp),
                          child: Icon(Icons.close, color: AppColors.blackColor),
                        ))
                  ],
                ),
              ),
            SizedBox(height: 10.h),
            Text(LabelString.lblPremisesType,
                style: CustomTextStyle.labelMediumBoldFontText),
            SizedBox(height: 10.h),
            Wrap(
              spacing: 15.sp,
              direction: Axis.horizontal,
              alignment: WrapAlignment.spaceBetween,
              runSpacing: 15.sp,
              children: List.generate(
                stepOneData["premises_type"].length,
                (index) {
                  if (dataQuote != null && dataQuote["premises_type"] != "") {
                    premisesType.add(RadioModel(
                        stepOneData["premises_type"][index]["label"]
                                .toString()
                                .contains(dataQuote["premises_type"])
                            ? true
                            : false,
                        stepOneData["premises_type"][index]["label"]));
                    premisesTypeSelect = dataQuote["premises_type"];
                  } else if (contractList != null &&
                      contractList.scPremisesType != "") {
                    premisesType.add(RadioModel(
                        stepOneData["premises_type"][index]["label"]
                                .toString()
                                .contains(contractList.scPremisesType)
                            ? true
                            : false,
                        stepOneData["premises_type"][index]["label"]));
                    premisesTypeSelect = contractList.scPremisesType;
                  } else {
                    premisesType.add(RadioModel(
                        false, stepOneData["premises_type"][index]["label"]));
                    premisesTypeSelect =
                        stepOneData["premises_type"][index]["label"];
                  }

                  //dataQuote != null ? dataQuote["premises_type"] : ;
                  return InkWell(
                    splashColor: AppColors.transparent,
                    highlightColor: AppColors.transparent,
                    onTap: () {
                      for (var element in premisesType) {
                        element.isSelected = false;
                      }
                      // Provider.of<WidgetChange>(context, listen: false).isSelectPremisesType();

                      premisesType[index].isSelected = true;
                      // Provider.of<WidgetChange>(context, listen: false).isSetPremises;

                      notifier.value = !notifier.value;
                      if (contactId != null) {
                        pageController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.decelerate);
                      }
                    },
                    child: ValueListenableBuilder(
                        valueListenable: notifier,
                        builder:
                            (BuildContext context, bool val, Widget? child) {
                          return Container(
                            height: 0.15.sh,
                            width: 0.42.sw,
                            decoration: BoxDecoration(
                                color: premisesType[index].isSelected
                                    ? AppColors.primaryColorLawOpacity
                                    : AppColors.whiteColor,
                                border: Border.all(
                                    color: premisesType[index].isSelected
                                        ? AppColors.primaryColor
                                        : AppColors.borderColor,
                                    width: 1),
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(height: 1.h),
                                      SvgExtension(
                                          iconColor:
                                              premisesType[index].isSelected
                                                  ? AppColors.primaryColor
                                                  : AppColors.blackColor,
                                          itemName:
                                              premisesType[index].buttonText),
                                      SizedBox(height: 1.h),
                                      Text(premisesType[index].buttonText,
                                          style: premisesType[index].isSelected
                                              ? CustomTextStyle.commonTextBlue
                                              : CustomTextStyle.commonText),
                                      SizedBox(height: 1.h)
                                    ]),
                                Visibility(
                                  visible: premisesType[index].isSelected
                                      ? true
                                      : false,
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
                          );
                        }),
                  );
                },
              ),
            ),
            SizedBox(height: 2.0.h),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.sp, horizontal: 11.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 140.w,
                    height: 44.h,
                    child: CustomButton(
                        //cancel button
                        title: ButtonString.btnCancel,
                        onClick: () => Navigator.of(context).pop(),
                        buttonColor: AppColors.redColor),
                  ),
                  SizedBox(
                    width: 140.w,
                    height: 44.h,
                    child: CustomButton(
                        //next button
                        title: ButtonString.btnNext,
                        onClick: () {
                          if (contactId != null) {
                            FocusScope.of(context).unfocus();
                            pageController.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.decelerate);
                          } else {
                            Helpers.showSnackBar(
                                context, ErrorString.selectOneContact,
                                isError: true);
                          }
                        },
                        buttonColor: AppColors.primaryColor),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  ///step 2- system type
  SingleChildScrollView buildStepTwo(
      BuildContext context, Size query, stepTwoData) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.only(right: 12.sp, left: 12.sp, bottom: 12.sp),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 10.h),
            Text(LabelString.lblSystemType,
                style: CustomTextStyle.labelBoldFontTextSmall),
            SizedBox(height: 10.h),
            Wrap(
              spacing: 15.sp,
              direction: Axis.horizontal,
              alignment: WrapAlignment.spaceBetween,
              runSpacing: 15.sp,
              children: List.generate(
                stepTwoData["system_type"].length - 9,
                (index) {
                  String systemTypeLabel =
                      stepTwoData["system_type"][index]["label"].toString();
                  if (widget.lastName == "edit" &&
                      dataQuote["system_type"] != "") {
                    systemType.add(RadioModel(
                        dataQuote["system_type"].toString().contains(
                                stepTwoData["system_type"][index]["label"])
                            ? true
                            : false,
                        stepTwoData["system_type"][index]["label"]));
                  } else if (widget.lastName == "contract" &&
                      contractList.scSystemType != "") {
                    systemType.add(RadioModel(
                        contractList.scSystemType.toString().contains(
                                stepTwoData["system_type"][index]["label"])
                            ? true
                            : false,
                        stepTwoData["system_type"][index]["label"]));
                  } else {
                    systemType.add(RadioModel(
                        false, stepTwoData["system_type"][index]["label"]));
                  }

                  return InkWell(
                    splashColor: AppColors.transparent,
                    highlightColor: AppColors.transparent,
                    onTap: () {
                      for (var element in systemType) {
                        element.isSelected = false;
                      }
                      //  Provider.of<WidgetChange>(context, listen: false).isSelectSystemType();
                      systemType[index].isSelected = true;
                      setState(() {});
                      //  Provider.of<WidgetChange>(context, listen: false).isSetSystem;
                      systemTypeSelect =
                          stepTwoData["system_type"][index]["label"];

                      print(systemTypeSelect);
                      if (systemTypeSelect.contains("CCTV") ||
                          systemTypeSelect.contains("Access Control") ||
                          systemTypeSelect.contains("Keyholding")) {
                        if (dataQuote != null) {
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
                                  invoiceAddress,
                                  invoiceCity,
                                  invoiceCountry,
                                  invoicePostal,
                                  installationAddress,
                                  installationCity,
                                  installationCountry,
                                  installationPostal,
                                  contactId,
                                  contactCompany,
                                  mobileNumber,
                                  telephoneNumber,
                                  stepTwoData['quotes_terms'],
                                  contactEmail,
                                  (dropdownvalue ?? {}) as Map,
                                  itemList: itemList,
                                  dataQuote: dataQuote,
                                  widget.lastName));
                        } else if (contractList != null) {
                          callNextScreen(
                              context,
                              AddItemDetail(
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
                                  invoiceAddress,
                                  invoiceCity,
                                  invoiceCountry,
                                  invoicePostal,
                                  installationAddress,
                                  installationCity,
                                  installationCountry,
                                  installationPostal,
                                  contactId,
                                  contactCompany,
                                  mobileNumber,
                                  telephoneNumber,
                                  stepTwoData['quotes_terms'],
                                  contactEmail,
                                  (dropdownvalue ?? {}) as Map,
                                  widget.lastName,
                                  contractList: contractList,
                                  quoteTypeContract: widget.firstName));
                        } else {
                          callNextScreen(
                              context,
                              AddItemDetail(
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
                                  invoiceAddress,
                                  invoiceCity,
                                  invoiceCountry,
                                  invoicePostal,
                                  installationAddress,
                                  installationCity,
                                  installationCountry,
                                  installationPostal,
                                  contactId,
                                  contactCompany,
                                  mobileNumber,
                                  telephoneNumber,
                                  stepTwoData['quotes_terms'],
                                  contactEmail,
                                  (dropdownvalue ?? {}) as Map,
                                  widget.lastName));
                        }
                      } else {
                        pageController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.decelerate);
                      }
                    },
                    child: Container(
                      height: 0.15.sh,
                      width: 0.42.sw,
                      decoration: BoxDecoration(
                          color: systemType[index].isSelected
                              ? AppColors.primaryColorLawOpacity
                              : AppColors.whiteColor,
                          border: Border.all(
                              color: systemType[index].isSelected
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
                                    itemName: stepTwoData["system_type"][index]
                                        ["label"],
                                    iconColor: systemType[index].isSelected
                                        ? AppColors.primaryColor
                                        : AppColors.blackColor),
                                SizedBox(height: 1.h),
                                SizedBox(
                                  width: query.width * 0.3,
                                  child: Text(
                                      RegExp(":").hasMatch(systemTypeLabel)
                                          ? systemTypeLabel
                                              .substring(
                                                  0,
                                                  systemTypeLabel.indexOf(":") +
                                                      2)
                                              .replaceAll(":", "")
                                          : systemTypeLabel,
                                      textAlign: TextAlign.center,
                                      style: systemType[index].isSelected
                                          ? CustomTextStyle.commonTextBlue
                                          : CustomTextStyle.commonText),
                                ),
                                SizedBox(height: 1.h),
                              ]),
                          Visibility(
                            visible:
                                systemType[index].isSelected ? true : false,
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
            SizedBox(height: 10.h),
            SizedBox(
                width: query.width * 0.4,
                height: query.height * 0.06,
                child: BorderButton(
                    btnString: ButtonString.btnPrevious,
                    onClick: () {
                      pageController.previousPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.decelerate);
                    })),
          ],
        ),
      ),
    );
  }

  ///step 3 Grade - Signalling type selection
  SingleChildScrollView buildStepThree(context, Size query, stepThreeData) {
    List dataGrade = stepThreeData["grade_number"];
    ValueNotifier<bool> notifier = ValueNotifier(false);
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          //show grade section only when system type contains "Intruder"
          systemTypeSelect.contains("Intruder")
              ? Column(
                  children: [
                    SizedBox(height: 10.h),
                    Text(LabelString.lblGradeNumber,
                        textAlign: TextAlign.center,
                        style: CustomTextStyle.labelBoldFontTextSmall),
                    SizedBox(height: 10.h),
                    Wrap(
                      spacing: 15.sp,
                      direction: Axis.horizontal,
                      alignment: WrapAlignment.spaceBetween,
                      runSpacing: 15.sp,
                      children: List.generate(
                        2,
                        (index) {
                          if (dataQuote != null &&
                              dataQuote["grade_number"] != null) {
                            gradeAndFire.add(RadioModel(
                                dataQuote["grade_number"].toString().contains(
                                        stepThreeData["grade_number"][index]
                                            ["label"])
                                    ? true
                                    : false,
                                dataGrade[index]["label"]));
                          } else if (contractList != null &&
                              contractList.scSecurityGrade != null) {
                            gradeAndFire.add(RadioModel(
                                contractList.scSecurityGrade
                                        .toString()
                                        .contains(stepThreeData["grade_number"]
                                            [index]["label"])
                                    ? true
                                    : false,
                                dataGrade[index]["label"]));
                          } else {
                            gradeAndFire.add(
                                RadioModel(false, dataGrade[index]["label"]));
                          }

                          return InkWell(
                              splashColor: AppColors.transparent,
                              highlightColor: AppColors.transparent,
                              onTap: () {
                                for (var element in gradeAndFire) {
                                  element.isSelected = false;
                                }

                                // Provider.of<WidgetChange>(context, listen: false).isSelectGrade();
                                gradeAndFire[index].isSelected = true;
                                notifier.value = !notifier.value;
                                // Provider.of<WidgetChange>(context, listen: false).isSetGrade;

                                gradeFireSelect = dataGrade[index]["label"];

                                if (signallingTypeSelect.isNotEmpty &&
                                    gradeFireSelect.isNotEmpty) {
                                  if (dataQuote != null) {
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
                                            invoiceAddress,
                                            invoiceCity,
                                            invoiceCountry,
                                            invoicePostal,
                                            installationAddress,
                                            installationCity,
                                            installationCountry,
                                            installationPostal,
                                            contactId,
                                            contactCompany,
                                            mobileNumber,
                                            telephoneNumber,
                                            stepThreeData['quotes_terms'],
                                            contactEmail,
                                            (dropdownvalue ?? {}) as Map,
                                            widget.lastName,
                                            itemList: itemList,
                                            dataQuote: dataQuote));
                                  } else if (contractList != null) {
                                    callNextScreen(
                                        context,
                                        AddItemDetail(
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
                                            invoiceAddress,
                                            invoiceCity,
                                            invoiceCountry,
                                            invoicePostal,
                                            installationAddress,
                                            installationCity,
                                            installationCountry,
                                            installationPostal,
                                            contactId,
                                            contactCompany,
                                            mobileNumber,
                                            telephoneNumber,
                                            stepThreeData['quotes_terms'],
                                            contactEmail,
                                            (dropdownvalue ?? {}) as Map,
                                            widget.lastName,
                                            contractList: contractList,
                                            quoteTypeContract:
                                                widget.firstName));
                                  } else {
                                    callNextScreen(
                                        context,
                                        AddItemDetail(
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
                                            invoiceAddress,
                                            invoiceCity,
                                            invoiceCountry,
                                            invoicePostal,
                                            installationAddress,
                                            installationCity,
                                            installationCountry,
                                            installationPostal,
                                            contactId,
                                            contactCompany,
                                            mobileNumber,
                                            telephoneNumber,
                                            stepThreeData['quotes_terms'],
                                            contactEmail,
                                            (dropdownvalue ?? {}) as Map,
                                            widget.lastName));
                                  }
                                }
                              },
                              child: ValueListenableBuilder(
                                valueListenable: notifier,
                                builder: (BuildContext context, bool val,
                                    Widget? child) {
                                  return Container(
                                    height: 0.15.sh,
                                    width: 0.42.sw,
                                    decoration: BoxDecoration(
                                        color: gradeAndFire[index].isSelected
                                            ? AppColors.primaryColorLawOpacity
                                            : AppColors.whiteColor,
                                        border: Border.all(
                                            color:
                                                gradeAndFire[index].isSelected
                                                    ? AppColors.primaryColor
                                                    : AppColors.borderColor,
                                            width: 1),
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              //Condition for skip grade and signalling type
                                              SizedBox(height: 10.h),
                                              SvgExtension(
                                                  itemName: systemTypeSelect ==
                                                          "Fire System: BS 5839-1: 2017 + SP203-1"
                                                      ? dataGrade
                                                              .getRange(2, 7)
                                                              .toList()[index]
                                                          ["label"]
                                                      : dataGrade[index]
                                                          ["label"],
                                                  iconColor: gradeAndFire[index]
                                                          .isSelected
                                                      ? AppColors.primaryColor
                                                      : AppColors.blackColor),
                                              SizedBox(height: 10.h),
                                              Text(
                                                  systemTypeSelect ==
                                                          "Fire System: BS 5839-1: 2017 + SP203-1"
                                                      ? dataGrade
                                                              .getRange(2, 7)
                                                              .toList()[index]
                                                          ["label"]
                                                      : dataGrade[index]
                                                          ["label"],
                                                  style: gradeAndFire[index]
                                                          .isSelected
                                                      ? CustomTextStyle
                                                          .commonTextBlue
                                                      : CustomTextStyle
                                                          .commonText),
                                              SizedBox(height: 10.h),
                                            ]),
                                        Visibility(
                                          visible:
                                              gradeAndFire[index].isSelected
                                                  ? true
                                                  : false,
                                          child: Positioned(
                                            right: 10,
                                            top: 5,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          80.0),
                                                  color: AppColors.greenColor),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: Icon(Icons.done,
                                                    color: AppColors.whiteColor,
                                                    size: 14.sp),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ));
                        },
                      ),
                    ),
                  ],
                )
              : Container(),
          SizedBox(height: 20.h),
          Text(LabelString.lblSignallingType,
              textAlign: TextAlign.center,
              style: CustomTextStyle.labelMediumBoldFontText),
          SizedBox(height: 20.h),
          Wrap(
            spacing: 15.sp,
            direction: Axis.horizontal,
            alignment: WrapAlignment.spaceBetween,
            runSpacing: 15.sp,
            children: List.generate(
              // stepFourData["signalling_type"].length
              12,
              (index) {
                if (dataQuote != null && dataQuote["grade_number"] != null) {
                  signallingType.add(RadioModel(
                      dataQuote["signalling_type"].toString().contains(
                              stepThreeData["signalling_type"][index]["label"])
                          ? true
                          : false,
                      stepThreeData["signalling_type"][index]["label"]));
                } else if (contractList != null &&
                    contractList.scPrimarySignalType != null) {
                  signallingType.add(RadioModel(
                      contractList.scPrimarySignalType.toString().contains(
                              stepThreeData["signalling_type"][index]["label"])
                          ? true
                          : false,
                      stepThreeData["signalling_type"][index]["label"]));
                } else {
                  signallingType.add(RadioModel(
                      false, stepThreeData["signalling_type"][index]["label"]));
                }

                return InkWell(
                    splashColor: AppColors.transparent,
                    highlightColor: AppColors.transparent,
                    onTap: () {
                      for (var element in signallingType) {
                        element.isSelected = false;
                      }
                      //Provider.of<WidgetChange>(context, listen: false).isSelectSignallingType();
                      signallingType[index].isSelected = true;
                      notifier.value = !notifier.value;
                      //Provider.of<WidgetChange>(context, listen: false).isSetSignallingType;
                      signallingTypeSelect =
                          stepThreeData["signalling_type"][index]["label"];

                      if (signallingTypeSelect.isNotEmpty) {
                        if (dataQuote != null) {
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
                                  invoiceAddress,
                                  invoiceCity,
                                  invoiceCountry,
                                  invoicePostal,
                                  installationAddress,
                                  installationCity,
                                  installationCountry,
                                  installationPostal,
                                  contactId,
                                  contactCompany,
                                  mobileNumber,
                                  telephoneNumber,
                                  stepThreeData['quotes_terms'],
                                  contactEmail,
                                  (dropdownvalue ?? {}) as Map,
                                  widget.lastName,
                                  itemList: itemList,
                                  dataQuote: dataQuote));
                        } else if (contractList != null) {
                          callNextScreen(
                              context,
                              AddItemDetail(
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
                                  invoiceAddress,
                                  invoiceCity,
                                  invoiceCountry,
                                  invoicePostal,
                                  installationAddress,
                                  installationCity,
                                  installationCountry,
                                  installationPostal,
                                  contactId,
                                  contactCompany,
                                  mobileNumber,
                                  telephoneNumber,
                                  stepThreeData['quotes_terms'],
                                  contactEmail,
                                  (dropdownvalue ?? {}) as Map,
                                  widget.lastName,
                                  contractList: contractList,
                                  quoteTypeContract: widget.firstName));
                        } else {
                          callNextScreen(
                              context,
                              AddItemDetail(
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
                                  invoiceAddress,
                                  invoiceCity,
                                  invoiceCountry,
                                  invoicePostal,
                                  installationAddress,
                                  installationCity,
                                  installationCountry,
                                  installationPostal,
                                  contactId,
                                  contactCompany,
                                  mobileNumber,
                                  telephoneNumber,
                                  stepThreeData['quotes_terms'],
                                  contactEmail,
                                  (dropdownvalue ?? {}) as Map,
                                  widget.lastName));
                        }
                      }
                    },
                    child: ValueListenableBuilder(
                      valueListenable: notifier,
                      builder: (BuildContext context, bool val, Widget? child) {
                        return Container(
                          height: 0.15.sh,
                          width: 0.42.sw,
                          decoration: BoxDecoration(
                              color: signallingType[index].isSelected
                                  ? AppColors.primaryColorLawOpacity
                                  : AppColors.whiteColor,
                              border: Border.all(
                                  color: signallingType[index].isSelected
                                      ? AppColors.primaryColor
                                      : AppColors.borderColor,
                                  width: 1),
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(height: 1.h),
                                      SvgExtension(
                                          itemName:
                                              stepThreeData["signalling_type"]
                                                  [index]["label"],
                                          iconColor:
                                              signallingType[index].isSelected
                                                  ? AppColors.primaryColor
                                                  : AppColors.blackColor),
                                      SizedBox(height: 1.h),
                                      SizedBox(
                                        width: query.width * 0.35,
                                        child: Text(
                                            stepThreeData["signalling_type"]
                                                [index]["label"],
                                            textAlign: TextAlign.center,
                                            style: signallingType[index]
                                                    .isSelected
                                                ? CustomTextStyle.commonTextBlue
                                                : CustomTextStyle.commonText),
                                      ),
                                      SizedBox(height: 1.h),
                                    ]),
                              ),
                              Visibility(
                                visible: signallingType[index].isSelected
                                    ? true
                                    : false,
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
                        );
                      },
                    ));
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.sp, vertical: 15.sp),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(
                  width: query.width * 0.4,
                  height: query.height * 0.06,
                  child: BorderButton(
                      btnString: ButtonString.btnPrevious,
                      onClick: () {
                        pageController.previousPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.decelerate);
                      })),
            ]),
          )
        ],
      ),
    );
  }
}
