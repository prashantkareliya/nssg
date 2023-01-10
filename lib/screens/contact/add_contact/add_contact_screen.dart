import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nssg/utils/extention_text.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import '../../../components/custom_appbar.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_dialog.dart';
import '../../../components/custom_rounded_container.dart';
import '../../../components/custom_text_styles.dart';
import '../../../components/custom_textfield.dart';
import '../../../constants/constants.dart';
import '../../../constants/navigation.dart';
import '../../../constants/strings.dart';
import '../../../httpl_actions/app_http.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/helpers.dart';
import '../../../utils/widgetChange.dart';
import '../../../utils/widgets.dart';
import '../../dashboard/root_screen.dart';
import '../../qoute/add_quote.dart';
import '../contact_datasource.dart';
import '../contact_repository.dart';
import 'add_contact_bloc_dir/add_contact_bloc.dart';
import 'add_contact_model_dir/fill_contact_data_model.dart';
import 'add_contact_model_dir/fill_update_contact_data_model.dart';

class AddContactPage extends StatefulWidget {
  var contactId;

  AddContactPage(this.contactId, {Key? key}) : super(key: key);

  @override
  State<AddContactPage> createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  //controller for pageView
  PageController pageController = PageController();

  //streamController for all indicator manage
  StreamController<int> streamController = StreamController<int>.broadcast();

  //key for firstName and primaryEmail validation
  final contactBasicDetailFormKey = GlobalKey<FormState>();

  //Basic information's textField controllers
  TextEditingController firstNameController =
      TextEditingController(text: "test");
  TextEditingController lastNameController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController officePhoneController = TextEditingController();
  TextEditingController mobilePhoneController = TextEditingController();
  TextEditingController primaryEmailController =
      TextEditingController(text: "test@gmail.com");
  TextEditingController secondaryEmailController = TextEditingController();

  //Address information's textField controllers(invoice Address)
  TextEditingController invoiceSearchController = TextEditingController();
  TextEditingController invoiceAddressController = TextEditingController();
  TextEditingController invoiceCityController = TextEditingController();
  TextEditingController invoiceCountryController = TextEditingController();
  TextEditingController invoicePostalController = TextEditingController();

  //Address information's textField controllers(installation Address)
  TextEditingController installationSearchController = TextEditingController();
  TextEditingController installationAddressController = TextEditingController();
  TextEditingController installationCityController = TextEditingController();
  TextEditingController installationCountryController = TextEditingController();
  TextEditingController installationPostalController = TextEditingController();

  //variable for copy and paste address
  String pasteAddress = "";
  String pasteCity = "";
  String pasteCountry = "";
  String pastePostalCode = "";

  //For Contact API
  AddContactBloc addContactBloc =
      AddContactBloc(ContactRepository(contactDataSource: ContactDataSource()));
  bool isLoading = false;
  List addressList = [];

  //for call contact detail api
  Future<dynamic>? getDetail;

  @override
  void initState() {
    super.initState();
    //for call contact detail api
    getDetail = getContactDetail(widget.contactId);
  }

  int count = 0;

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: BaseAppBar(
        appBar: AppBar(),
        //condition for set edit or add contact appbar title
        title: widget.contactId == "NoId"
            ? LabelString.lblAddNewContact
            : LabelString.lblEditContact,
        isBack: true,
        elevation: 1,
        backgroundColor: AppColors.whiteColor,
        searchWidget: Container(),
        titleTextStyle: CustomTextStyle.labelBoldFontText,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
            child: StreamBuilder<int>(
              initialData: 0,
              stream: streamController.stream,
              builder: (context, snapshot1) {
                return Column(
                  children: [
                    //step design
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        snapshot1.data! == 0
                            ? RoundedContainer(
                                containerText: (snapshot1.data! + 1).toString(),
                                stepText: (snapshot1.data! + 1).toString(),
                                isEnable: true,
                                isDone: false)
                            : RoundedContainer(
                                containerText: (snapshot1.data! + 1).toString(),
                                stepText: (snapshot1.data!).toString(),
                                isEnable: false,
                                isDone: true),
                        snapshot1.data! == 1
                            ? RoundedContainer(
                                containerText: (snapshot1.data! + 1).toString(),
                                stepText: (snapshot1.data! + 1).toString(),
                                isEnable: true,
                                isDone: false)
                            : RoundedContainer(
                                containerText: (snapshot1.data! + 2).toString(),
                                stepText: (snapshot1.data! + 2).toString(),
                                isEnable: false,
                                isDone: false)
                      ],
                    ),

                    //basic or address information label
                    Padding(
                      padding:
                          EdgeInsets.only(left: 10.sp, right: 10.sp, top: 8.sp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          (snapshot1.data! + 1) == 1
                              ? Text(LabelString.lblBasicInformation,
                                  style: CustomTextStyle.labelBoldFontTextSmall)
                              : Text(LabelString.lblAddressInformation,
                                  style:
                                      CustomTextStyle.labelBoldFontTextSmall),
                          Row(
                            children: [
                              Text(LabelString.lblStep,
                                  style: CustomTextStyle.commonText),
                              Text("${snapshot1.data! + 1}/2",
                                  style: CustomTextStyle.commonTextBlue),
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
          //bloc for update and create contact
          BlocListener<AddContactBloc, AddContactState>(
            bloc: addContactBloc,
            listener: (context, state) {
              if (state is FailAddContact) {
                Helpers.showSnackBar(context, state.error.toString());
              }
            },
            child: BlocBuilder<AddContactBloc, AddContactState>(
              bloc: addContactBloc,
              builder: (context, state) {
                if (state is LoadingAddContact) {
                  isLoading = state.isBusy;
                }
                if (state is LoadedAddContact) {
                  isLoading = false;
                }
                if (state is FailAddContact) {
                  isLoading = false;
                }
                if (state is UpdatedContactData) {
                  isLoading = false;
                }
                //FutureBuilder for get single contact detail and set data in textField controller
                return FutureBuilder(
                    future: getDetail,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (count == 0) {
                          firstNameController.text =
                              snapshot.data["result"]["firstname"];
                          lastNameController.text =
                              snapshot.data["result"]["lastname"];
                          companyNameController.text =
                              snapshot.data["result"]["contact_company"];
                          officePhoneController.text =
                              snapshot.data["result"]["phone"];
                          mobilePhoneController.text =
                              snapshot.data["result"]["mobile"];
                          primaryEmailController.text =
                              snapshot.data["result"]["email"];
                          secondaryEmailController.text =
                              snapshot.data["result"]["secondaryemail"];

                          invoiceAddressController.text =
                              snapshot.data["result"]["mailingstreet"];
                          invoiceCityController.text =
                              snapshot.data["result"]["mailingcity"];
                          invoiceCountryController.text =
                              snapshot.data["result"]["mailingcountry"];
                          invoicePostalController.text =
                              snapshot.data["result"]["mailingzip"];

                          installationAddressController.text =
                              snapshot.data["result"]["otherstreet"];
                          installationCityController.text =
                              snapshot.data["result"]["othercity"];
                          installationCountryController.text =
                              snapshot.data["result"]["othercountry"];
                          installationPostalController.text =
                              snapshot.data["result"]["otherzip"];
                          count = 1;
                        } else {}
                        return Expanded(
                          //view for add - update field
                          child: PageView(
                            scrollDirection: Axis.horizontal,
                            pageSnapping: true,
                            physics: const BouncingScrollPhysics(),
                            controller: pageController,
                            onPageChanged: (number) {
                              streamController.add(number);
                            },
                            children: [
                              buildStepOne(query, snapshot.data["result"]),
                              buildStepTwo(query, snapshot.data["result"])
                            ],
                          ),
                        );
                      } else if (snapshot.hasError) {
                        Helpers.showSnackBar(
                            context, ErrorString.somethingWentWrong);
                      }

                      return SizedBox(
                          height: query.height / 1.5, child: loadingView());
                    });
              },
            ),
          ),
        ],
      ),
    );
  }

  //stepOne design
  Column buildStepOne(Size query, data) {
    return Column(
      children: [
        SizedBox(height: 0.0.h),
        Expanded(
          child: Form(
            key: contactBasicDetailFormKey,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 10.sp),
              shrinkWrap: true,
              children: [
                Consumer<WidgetChange>(
                  builder: (context, value, child) => CustomTextField(
                    keyboardType: TextInputType.name,
                    readOnly: false,
                    controller: firstNameController,
                    obscureText: false,
                    hint: LabelString.lblFirstName,
                    titleText: LabelString.lblFirstName,
                    isRequired: true,
                    /*prefixIcon: Padding(
                                padding: EdgeInsets.all(4.sp),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: AppColors.backWhiteColor,
                                      borderRadius: BorderRadius.circular(5.0)),
                                  height: 4.8.h,
                                  child: DropdownButton<String>(
                                    value: value.selectItem,
                                    elevation: 0,
                                    hint: Padding(
                                      padding: EdgeInsets.only(left: 5.sp),
                                      child: Text(LabelString.selectField,
                                          style: CustomTextStyle
                                              .labelFontHintText),
                                    ),
                                    style: CustomTextStyle.labelText,
                                    underline: Container(
                                        height: 0, color: Colors.transparent),
                                    onChanged: (String? v) {
                                      value.selectItemValue(v);
                                    },
                                    items: value.items
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 8.sp),
                                          child: Text(value,
                                              style: CustomTextStyle.labelText),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                )),*/
                  ),
                ),
                CustomTextField(
                    keyboardType: TextInputType.name,
                    readOnly: false,
                    controller: lastNameController,
                    obscureText: false,
                    hint: LabelString.lblLastName,
                    titleText: LabelString.lblLastName,
                    isRequired: false),
                CustomTextField(
                    keyboardType: TextInputType.name,
                    readOnly: false,
                    controller: companyNameController,
                    obscureText: false,
                    hint: LabelString.lblCompanyName,
                    titleText: LabelString.lblCompanyName,
                    isRequired: false),
                CustomTextField(
                    keyboardType: TextInputType.number,
                    readOnly: false,
                    controller: officePhoneController,
                    obscureText: false,
                    hint: LabelString.lblOfficePhone,
                    maxLength: 10,
                    titleText: LabelString.lblOfficePhone,
                    isRequired: false),
                CustomTextField(
                    keyboardType: TextInputType.number,
                    readOnly: false,
                    controller: mobilePhoneController,
                    obscureText: false,
                    hint: LabelString.lblMobilePhone,
                    maxLength: 10,
                    titleText: LabelString.lblMobilePhone,
                    isRequired: false),
                CustomTextField(
                    keyboardType: TextInputType.emailAddress,
                    readOnly: false,
                    controller: primaryEmailController,
                    obscureText: false,
                    hint: LabelString.lblPrimaryEmail,
                    titleText: LabelString.lblPrimaryEmail,
                    isRequired: true),
                CustomTextField(
                    keyboardType: TextInputType.emailAddress,
                    readOnly: false,
                    controller: secondaryEmailController,
                    obscureText: false,
                    hint: LabelString.lblSecondaryEmail,
                    titleText: LabelString.lblSecondaryEmail,
                    isRequired: false),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 15.sp, horizontal: 2.0.sp),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      //cancel button
                      SizedBox(
                        width: query.width * 0.4,
                        height: query.height * 0.06,
                        child: CustomButton(
                            buttonColor: AppColors.redColor,
                            onClick: () => Navigator.pop(context),
                            title: ButtonString.btnCancel),
                      ),
                      //next button
                      SizedBox(
                        width: query.width * 0.4,
                        height: query.height * 0.06,
                        child: CustomButton(
                          buttonColor: AppColors.primaryColor,
                          onClick: () {
                            if (contactBasicDetailFormKey.currentState
                                    ?.validate() ==
                                true) {
                              if (primaryEmailController.text
                                  .toString()
                                  .isValidEmail) {
                                pageController.nextPage(
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.decelerate);
                              } else {
                                Helpers.showSnackBar(
                                    context, ErrorString.emailNotValid,
                                    isError: true);
                              }
                            }
                          },
                          title: ButtonString.btnNext,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  //stepTwo design
  Expanded buildStepTwo(Size query, data) {
    return Expanded(
      child: ListView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 10.sp),
        shrinkWrap: true,
        children: [
          Center(
              child: Text(LabelString.lblInvoiceAddressDetails,
                  style: CustomTextStyle.labelBoldFontTextBlue)),
          SizedBox(height: 2.0.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(LabelString.lblAddressSearch,
                  style: CustomTextStyle.labelFontText),
              SizedBox(height: 1.h),
              autoComplete("invoice"),
            ],
          ),
          SizedBox(height: 2.h),
          MultiLineTextField(
            keyboardType: TextInputType.name,
            readOnly: false,
            controller: invoiceAddressController,
            obscureText: false,
            hint: LabelString.lblTypeAddress,
            titleText: LabelString.lblInvoiceAddress,
            isRequired: true,
          ),
          CustomTextField(
            keyboardType: TextInputType.name,
            readOnly: false,
            controller: invoiceCityController,
            obscureText: false,
            hint: LabelString.lblInvoiceCity,
            titleText: LabelString.lblInvoiceCity,
            isRequired: true,
          ),
          CustomTextField(
            keyboardType: TextInputType.name,
            readOnly: false,
            controller: invoiceCountryController,
            obscureText: false,
            hint: LabelString.lblInvoiceCountry,
            titleText: LabelString.lblInvoiceCountry,
            isRequired: true,
          ),
          CustomTextField(
            keyboardType: TextInputType.name,
            readOnly: false,
            controller: invoicePostalController,
            obscureText: false,
            hint: LabelString.lblInvoicePostalCode,
            titleText: LabelString.lblInvoicePostalCode,
            isRequired: true,
          ),
          SizedBox(height: 1.0.h),
          Center(
            child: Text(LabelString.lblInstallationAddressDetails,
                style: CustomTextStyle.labelBoldFontTextBlue),
          ),
          SizedBox(height: 2.0.h),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(LabelString.lblAddressSearch,
                      style: CustomTextStyle.labelFontText),
                  InkWell(
                    onTap: () {
                      copyAddressFields();
                    },
                    child: Image.asset(ImageString.icCopy, height: 2.8.h),
                  ),
                ],
              ),
              SizedBox(height: 1.h),
              autoComplete("installation"),
              SizedBox(height: 2.h),
            ],
          ),
          MultiLineTextField(
            keyboardType: TextInputType.name,
            readOnly: false,
            controller: installationAddressController,
            obscureText: false,
            hint: LabelString.lblTypeAddress,
            titleText: LabelString.lblInstallationAddress,
            isRequired: true,
          ),
          CustomTextField(
            keyboardType: TextInputType.name,
            readOnly: false,
            controller: installationCityController,
            obscureText: false,
            hint: LabelString.lblInstallationCity,
            titleText: LabelString.lblInstallationCity,
            isRequired: true,
          ),
          CustomTextField(
            keyboardType: TextInputType.name,
            readOnly: false,
            controller: installationCountryController,
            obscureText: false,
            hint: LabelString.lblInstallationCountry,
            titleText: LabelString.lblInstallationCountry,
            isRequired: true,
          ),
          CustomTextField(
            keyboardType: TextInputType.name,
            readOnly: false,
            controller: installationPostalController,
            obscureText: false,
            hint: LabelString.lblInstallationPostalCode,
            titleText: LabelString.lblInstallationPostalCode,
            isRequired: true,
          ),
          buildButtons(query, data),
        ],
      ),
    );
  }

  //previous and submit button
  Padding buildButtons(Size query, data) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.sp, horizontal: 2.0.sp),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          //previous button
          SizedBox(
            width: query.width * 0.4,
            height: query.height * 0.06,
            child: TextButton(
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(
                        AppColors.primaryColor),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(
                                color: AppColors.primaryColor, width: 2)))),
                onPressed: () {
                  pageController.previousPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.decelerate);
                },
                child: Text(ButtonString.btnPrevious,
                    style: CustomTextStyle.commonTextBlue)),
          ),
          //submit or update button
          SizedBox(
              width: query.width * 0.4,
              height: query.height * 0.06,
              child: widget.contactId == "NoId"
                  ? CustomButton(
                      buttonColor: AppColors.primaryColor,
                      onClick: () {
                        //opening dialog for ask to add quote or not?
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (ctx) => ValidationDialog(
                            Message.createQoute,

                            //Yes button//
                            () {
                              createContactApiCall();
                              Navigator.pop(context);
                              Navigator.pop(context);
                              callNextScreen(context, AddQuotePage(true));
                            },

                            //No button//
                            () {
                              createContactApiCall();
                              Navigator.pop(context);
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (c) => const RootScreen()),
                                  (route) => false);
                            },
                          ),
                        );
                      },
                      title: ButtonString.btnSubmit)
                  : CustomButton(
                      //update button
                      title: ButtonString.btnUpdate,
                      onClick: () {
                        updateContact(data);
                        Navigator.pop(context);
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (c) => const RootScreen()),
                            (route) => false);
                      },
                      buttonColor: AppColors.primaryColor,
                    ))
        ],
      ),
    );
  }

  //Autocomplete textField for fill address fields
  Widget autoComplete(String autoCompleteType) {
    return Autocomplete(
      fieldViewBuilder: (BuildContext context,
          TextEditingController textEditingController,
          FocusNode focusNode,
          VoidCallback onFieldSubmitted) {
        return TextField(
          style: TextStyle(color: AppColors.blackColor),
          textCapitalization: TextCapitalization.none,
          textInputAction: TextInputAction.next,
          maxLines: 1,
          cursorColor: AppColors.blackColor,
          decoration: InputDecoration(
              suffixIcon: Icon(Icons.search, color: AppColors.blackColor),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide:
                      BorderSide(width: 2, color: AppColors.primaryColor)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide:
                      BorderSide(width: 2, color: AppColors.primaryColor)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide:
                      BorderSide(width: 2, color: AppColors.primaryColor)),
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.only(left: 12.sp),
              hintText: LabelString.lblTypeToSearch,
              hintStyle: CustomTextStyle.labelFontHintText,
              counterText: ""),
          controller: textEditingController,
          focusNode: focusNode,
          onEditingComplete: () {
            textEditingController.clear();
          },
          onSubmitted: (String value) {},
        );
      },
      optionsBuilder: (TextEditingValue textEditingValue) async {
        if (textEditingValue.text.length <= 3) {
          return const Iterable<String>.empty();
        } else {
          //API call for get ID
          var url =
              "https://api.getAddress.io/autocomplete/${textEditingValue.text.toString()}?api-key=S9VYw_n6IE6VlQkZktafRA37641";

          final response = await http.get(Uri.parse(url),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8'
              });
          final responseJson = json.decode(response.body);
          addressList = responseJson["suggestions"];
          List<String> matchesAddress = <String>[];
          matchesAddress
              .addAll(addressList.map((e) => e["address"].toString()));
          return matchesAddress;
        }
      },
      onSelected: (selection) async {
        //For get address ID
        for (int i = 0; i < addressList.length; i++) {
          if (addressList[i]["address"] == selection) {
            String addressId = addressList[i]["id"].toString();
            //Call API for get address detail
            var url =
                "https://api.getAddress.io/get/$addressId?api-key=S9VYw_n6IE6VlQkZktafRA37641";

            final response = await http.get(Uri.parse(url));
            final responseJson = json.decode(response.body);

            //set address detail in field
            if (response.statusCode == 200) {
              if (autoCompleteType == "invoice") {
                invoiceAddressController.text =
                    "${responseJson["line_1"]}  ${responseJson["line_2"]}";
                invoiceCityController.text = "${responseJson["town_or_city"]}";
                invoiceCountryController.text = "${responseJson["county"]}";
                invoicePostalController.text = "${responseJson["postcode"]}";
              } else {
                installationAddressController.text =
                    "${responseJson["line_1"]}  ${responseJson["line_2"]}";
                installationCityController.text =
                    "${responseJson["town_or_city"]}";
                installationCountryController.text =
                    "${responseJson["county"]}";
                installationPostalController.text =
                    "${responseJson["postcode"]}";
              }
            } else {
              Helpers.showSnackBar(context, responseJson["Message"].toString());
            }
          }
        }
      },
    );
  }

  //Method for copy - paste address fields
  void copyAddressFields() {
    Clipboard.setData(ClipboardData(text: invoiceAddressController.text))
        .then((value) => Clipboard.getData(Clipboard.kTextPlain).then(
              (value) {
                installationAddressController.text =
                    invoiceAddressController.text;
              },
            ));

    Clipboard.setData(ClipboardData(text: invoiceCityController.text)).then(
      (value) => Clipboard.getData(Clipboard.kTextPlain).then(
        (value) {
          installationCityController.text = invoiceCityController.text;
        },
      ),
    );

    Clipboard.setData(ClipboardData(text: invoiceCountryController.text)).then(
      (value) => Clipboard.getData(Clipboard.kTextPlain).then(
        (value) {
          installationCountryController.text = invoiceCountryController.text;
        },
      ),
    );

    Clipboard.setData(ClipboardData(text: invoicePostalController.text)).then(
      (value) => Clipboard.getData(Clipboard.kTextPlain).then(
        (value) {
          installationPostalController.text = invoicePostalController.text;
        },
      ),
    );
  }

  //calling create contact API
  void createContactApiCall() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    //for create data in json format
    ContactDetailData contactDetailData = ContactDetailData(
        firstNameController.text.trim(),
        lastNameController.text.trim(),
        companyNameController.text.trim(),
        officePhoneController.text.trim(),
        mobilePhoneController.text.trim(),
        primaryEmailController.text.trim(),
        secondaryEmailController.text.trim(),
        invoiceAddressController.text.trim(),
        invoiceCityController.text.trim(),
        invoiceCountryController.text.trim(),
        invoicePostalController.text.trim(),
        installationAddressController.text.trim(),
        installationCityController.text.trim(),
        installationCountryController.text.trim(),
        installationPostalController.text.trim(),
        preferences.getString(PreferenceString.userId).toString());
    String jsonContactDetail = jsonEncode(contactDetailData);

    debugPrint(" jsonContactDetail add ----- $jsonContactDetail");

    Map<String, dynamic> queryParameters = {
      'operation': "create",
      'sessionName':
          preferences.getString(PreferenceString.sessionName).toString(),
      'element': jsonContactDetail,
      'elementType': 'Contacts',
    };

    addContactBloc.add(AddContactDetailEvent(queryParameters));
  }

  //Calling update contact API
  void updateContact(data) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    //for create data in json format
    UpdateContactData updateContactData = UpdateContactData(
      firstNameController.text.trim(),
      data["contact_no"].toString(),
      officePhoneController.text.trim(),
      lastNameController.text.trim(),
      mobilePhoneController.text.trim(),
      data["account_id"].toString(),
      data["homephone"].toString(),
      data["leadsource"].toString(),
      data["otherphone"].toString(),
      data["title"].toString(),
      data["fax"].toString(),
      data["department"].toString(),
      data["birthday"].toString(),
      primaryEmailController.text.trim(),
      data["contact_id"].toString(),
      data["assistant"].toString(),
      secondaryEmailController.text.trim(),
      data["assistantphone"].toString(),
      data["donotcall"].toString(),
      data["emailoptout"].toString(),
      data["assigned_user_id"].toString(),
      data["reference"].toString(),
      data["notify_owner"].toString(),
      data["modifiedby"].toString(),
      data["isconvertedfromlead"].toString(),
      companyNameController.text.trim(),
      invoiceAddressController.text.trim(),
      invoiceCityController.text.trim(),
      data["mailingstate"].toString(),
      data["otherstate"].toString(),
      invoicePostalController.text.trim(),
      invoiceCountryController.text.trim(),
      data["mailingpobox"].toString(),
      data["otherpobox"].toString(),
      data["description"].toString(),
      data["imagename"].toString(),
      installationAddressController.text.trim(),
      installationCityController.text.trim(),
      installationPostalController.text.trim(),
      installationCountryController.text.trim(),
      widget.contactId.toString(),
      data["assigned_user_name"].toString(),
    );
    String jsonUpdateContactDetail = jsonEncode(updateContactData);

    debugPrint(" jsonContactDetail add ----- $jsonUpdateContactDetail");

    Map<String, dynamic> queryParameters = {
      'operation': "update",
      'sessionName':
          preferences.getString(PreferenceString.sessionName).toString(),
      'element': jsonUpdateContactDetail,
      'appversion': Constants.of().appversion,
    };
    addContactBloc.add(UpdateContactDetailEvent(queryParameters));
  }
}

//Calling API for fetch detail of single contact
Future<dynamic> getContactDetail(contactId) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();

  Map<String, dynamic> queryParameters = {
    'operation': "retrieve",
    'sessionName':
        preferences.getString(PreferenceString.sessionName).toString(),
    'id': contactId.toString()
  };
  final response = await HttpActions()
      .getMethod(ApiEndPoint.getContactListApi, queryParams: queryParameters);

  debugPrint("getContactDetailApi --- $response");
  return response;
}
