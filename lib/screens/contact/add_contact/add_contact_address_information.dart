import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nssg/screens/contact/add_contact/add_contact_bloc_dir/add_contact_bloc.dart';
import 'package:nssg/screens/contact/add_contact/add_contact_model_dir/fill_update_contact_data_model.dart';
import 'package:nssg/utils/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../../../constants/constants.dart';
import '../../../constants/navigation.dart';
import '../../../utils/helpers.dart';
import '../../dashboard/root_screen.dart';
import '../../qoute/add_quote.dart';
import '../contact_datasource.dart';
import '../contact_repository.dart';
import 'add_contact_basic_information.dart';
import 'add_contact_model_dir/fill_contact_data_model.dart';

import '../../../components/custom_appbar.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_dialog.dart';
import '../../../components/custom_text_styles.dart';
import '../../../components/custom_textfield.dart';
import '../../../components/custom_rounded_container.dart';
import '../../../constants/strings.dart';
import '../../../utils/app_colors.dart';

// ignore: must_be_immutable
class AddContactAddressInfoPage extends StatefulWidget {
  String firstName;
  String lastName;
  String companyName;
  String officePhone;
  String mobilePhone;
  String primaryEmail;
  String secondaryEmail;
  var contactId;

  AddContactAddressInfoPage(
      this.firstName,
      this.lastName,
      this.companyName,
      this.officePhone,
      this.mobilePhone,
      this.primaryEmail,
      this.secondaryEmail,
      this.contactId,
      {Key? key})
      : super(key: key);

  @override
  State<AddContactAddressInfoPage> createState() =>
      _AddContactAddressInfoPageState();
}

class _AddContactAddressInfoPageState extends State<AddContactAddressInfoPage> {
  TextEditingController invoiceSearchController = TextEditingController();
  TextEditingController invoiceAddressController = TextEditingController();
  TextEditingController invoiceCityController = TextEditingController();
  TextEditingController invoiceCountryController = TextEditingController();
  TextEditingController invoicePostalController = TextEditingController();

  TextEditingController installationSearchController = TextEditingController();
  TextEditingController installationAddressController = TextEditingController();
  TextEditingController installationCityController = TextEditingController();
  TextEditingController installationCountryController = TextEditingController();
  TextEditingController installationPostalController = TextEditingController();

  String pasteAddress = "";
  String pasteCity = "";
  String pasteCountry = "";
  String pastePostalCode = "";

  AddContactBloc addContactBloc =
      AddContactBloc(ContactRepository(contactDataSource: ContactDataSource()));
  bool isLoading = false;
  List addressList = [];

  Future<dynamic>? getDetail;

  @override
  void initState() {
    super.initState();
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
        elevation: 1,
        title: widget.contactId == "NoId"
            ? LabelString.lblAddNewContact
            : LabelString.lblEditContact,
        titleTextStyle: CustomTextStyle.labelBoldFontText,
        isBack: true,
        searchWidget: Container(),
        backgroundColor: AppColors.whiteColor,
      ),
      body: BlocListener<AddContactBloc, AddContactState>(
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
            if(state is UpdatedContactData){
              isLoading = false;
            }
            return SizedBox(
              height: query.height,
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
                  child: FutureBuilder<dynamic>(
                    future: getDetail,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (count == 0) {
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
                        } else {
                          print("count $count");
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            buildStepper(),
                            SizedBox(height: 1.0.h),
                            textFiledForAddAddress(query,snapshot.data["result"])
                          ],
                        );
                      } else if (snapshot.hasError) {}
                      return loadingView();
                    },
                  )),
            );
          },
        ),
      ),
    );
  }

  //Design custom stepper for progress
  Column buildStepper() {
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          RoundedContainer(
              containerText: "1", stepText: "1", isEnable: false, isDone: true),
          RoundedContainer(
              containerText: "2", stepText: "2", isEnable: true, isDone: false)
        ]),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 6.sp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(LabelString.lblAddressInformation,
                  style: CustomTextStyle.labelBoldFontTextSmall),
              Row(
                children: [
                  Text(LabelString.lblStep, style: CustomTextStyle.commonText),
                  Text(" 2/2", style: CustomTextStyle.commonTextBlue),
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  //Add address's TextFields for create new contact
  Expanded textFiledForAddAddress(Size query, data ) {
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
          buildButtons(query, data ),
        ],
      ),
    );
  }

  //Bottom buttons
  Padding buildButtons(Size query, data) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.sp, horizontal: 2.0.sp),
      child: isLoading
          ? loadingView()
          : Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  width: query.width * 0.4,
                  height: query.height * 0.06,
                  child: TextButton(
                      style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(
                              AppColors.primaryColor),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: BorderSide(
                                          color: AppColors.primaryColor,
                                          width: 2)))),
                      onPressed: () => Navigator.pop(context),
                      child: Text(ButtonString.btnPrevious,
                          style: CustomTextStyle.commonTextBlue)),
                ),
                SizedBox(
                    width: query.width * 0.4,
                    height: query.height * 0.06,
                    child: widget.contactId == "NoId"
                        ? CustomButton(
                            buttonColor: AppColors.primaryColor,
                            onClick: () {
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
                                    removeAndCallNextScreen(
                                        context, AddQuotePage(true));
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

  //Call create new contact api
  void createContactApiCall() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    //for create data in json format
    ContactDetailData contactDetailData = ContactDetailData(
        widget.firstName.toString(),
        widget.lastName.toString(),
        widget.companyName.toString(),
        widget.officePhone.toString(),
        widget.mobilePhone.toString(),
        widget.primaryEmail.toString(),
        widget.secondaryEmail.toString(),
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

  //For Address autofill
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

  //Call API for update existing contact
  void updateContact(data) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    //for create data in json format
    UpdateContactData updateContactData = UpdateContactData(
        widget.firstName.toString(),
        data["contact_no"].toString(),
        widget.officePhone.toString(),
        widget.lastName.toString(),
        widget.mobilePhone.toString(),
        data["account_id"].toString(),
        data["homephone"].toString(),
        data["leadsource"].toString(),
        data["otherphone"].toString(),
        data["title"].toString(),
        data["fax"].toString(),
        data["department"].toString(),
        data["birthday"].toString(),
        widget.primaryEmail.toString(),
        data["contact_id"].toString(),
        data["assistant"].toString(),
        widget.secondaryEmail.toString(),
        data["assistantphone"].toString(),
        data["donotcall"].toString(),
        data["emailoptout"].toString(),
        data["assigned_user_id"].toString(),
        data["reference"].toString(),
        data["notify_owner"].toString(),

        data["modifiedby"].toString(),

        data["isconvertedfromlead"].toString(),
        widget.companyName.toString(),
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

/*
1st call - https://api.getAddress.io/autocomplete/KT1 3EG?api-key=S9VYw_n6IE6VlQkZktafRA37641
 {
            "address": "2 Hawks Road, Kingston upon Thames, Surrey",
            "url": "/get/MTY1MGFiMTMzNjJlY2IyIDIyNTYxNTUwIGQwYTQ1MjFiNjhlMzA2YQ==",
            "id": "MTY1MGFiMTMzNjJlY2IyIDIyNTYxNTUwIGQwYTQ1MjFiNjhlMzA2YQ=="
        },

then call - https://api.getAddress.io/get/MTY1MGFiMTMzNjJlY2IyIDIyNTYxNTUwIGQwYTQ1MjFiNjhlMzA2YQ==?api-key=S9VYw_n6IE6VlQkZktafRA37641

* */
