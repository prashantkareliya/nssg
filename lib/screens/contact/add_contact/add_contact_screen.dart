import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:nssg/constants/navigation.dart';
import 'package:nssg/screens/qoute/add_quote/add_quote_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../../components/custom_appbar.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_dialog.dart';
import '../../../components/custom_rounded_container.dart';
import '../../../components/custom_text_styles.dart';
import '../../../components/custom_textfield.dart';
import '../../../constants/constants.dart';
import '../../../constants/strings.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/helpers.dart';
import '../../../utils/widgetChange.dart';
import '../../../utils/widgets.dart';
import '../../dashboard/root_screen.dart';
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
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController officePhoneController = TextEditingController();
  TextEditingController mobilePhoneController = TextEditingController();
  TextEditingController primaryEmailController = TextEditingController();
  TextEditingController secondaryEmailController = TextEditingController();

  //Address information's textField controllers(invoice Address)
  TextEditingController invoiceAddressController = TextEditingController();
  TextEditingController invoiceCityController = TextEditingController();
  TextEditingController invoiceCountryController = TextEditingController();
  TextEditingController invoicePostalController = TextEditingController();

  //Address information's textField controllers(installation Address)
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

  var contactDetailData;

  @override
  void initState() {
    super.initState();
    if (widget.contactId != "NoId") {
      getContactDetailApi();
    }
  }

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
              if (state is LoadedAddContact) {
                if (state.isPositive) {
                  print(state.contactDetail);
                  removeAndCallNextScreen(
                      context,
                      AddQuotePage(
                        false,
                        firstNameController.text,
                        lastNameController.text,
                        contactId: state.contactId,
                        contactDetail: state.contactDetail
                      ));
                } else {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (c) => const RootScreen()),
                      (route) => false);
                }
              }
              if (state is GetContactData) {
                contactDetailData = state.contactData;

                firstNameController.text =
                    state.contactData.firstname.toString();
                lastNameController.text = state.contactData.lastname.toString();
                companyNameController.text =
                    state.contactData.contactCompany.toString();
                officePhoneController.text = state.contactData.phone.toString();
                mobilePhoneController.text =
                    state.contactData.mobile.toString();
                primaryEmailController.text =
                    state.contactData.email.toString();
                secondaryEmailController.text =
                    state.contactData.secondaryemail.toString();

                invoiceAddressController.text =
                    state.contactData.mailingstreet.toString();
                invoiceCityController.text =
                    state.contactData.mailingcity.toString();
                invoiceCountryController.text =
                    state.contactData.mailingcountry.toString();
                invoicePostalController.text =
                    state.contactData.mailingzip.toString();

                installationAddressController.text =
                    state.contactData.otherstreet.toString();
                installationCityController.text =
                    state.contactData.othercity.toString();
                installationCountryController.text =
                    state.contactData.othercountry.toString();
                installationPostalController.text =
                    state.contactData.otherzip.toString();
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
                if (state is GetContactData) {
                  isLoading = false;
                }
                //FutureBuilder for get single contact detail and set data in textField controller
                return Expanded(
                  child: isLoading
                      ? loadingView()
                      : PageView(
                          pageSnapping: true,
                          physics: contactBasicDetailFormKey.currentState?.validate() == true ||
                                  widget.contactId != "NoId"
                              ? const BouncingScrollPhysics()
                              : const NeverScrollableScrollPhysics(),
                          controller: pageController,
                          onPageChanged: (number) {
                            streamController.add(number);
                          },
                          children: [buildStepOne(query), buildStepTwo(query)],
                        ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  //stepOne design
  Padding buildStepOne(Size query) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.sp),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: contactBasicDetailFormKey,
          child: Column(
            children: [
              Consumer<WidgetChange>(
                builder: (context, value, child) => CustomTextField(
                  keyboardType: TextInputType.multiline,
                  readOnly: false,
                  controller: firstNameController,
                  obscureText: false,
                  hint: LabelString.lblFirstName,
                  titleText: LabelString.lblFirstName,
                  star: "*",
                  isRequired: true,
                  maxLines: 1,
                  minLines: 1,
                  textInputAction: TextInputAction.next,

                ),
              ),
              CustomTextField(
                  keyboardType: TextInputType.name,
                  readOnly: false,
                  controller: lastNameController,
                  obscureText: false,
                  hint: LabelString.lblLastName,
                  titleText: LabelString.lblLastName,
                  maxLines: 1,
                  minLines: 1,
                  textInputAction: TextInputAction.next,
                  isRequired: false),
              CustomTextField(
                  keyboardType: TextInputType.name,
                  readOnly: false,
                  controller: companyNameController,
                  obscureText: false,
                  hint: LabelString.lblCompanyName,
                  titleText: LabelString.lblCompanyName,
                  maxLines: 1,
                  minLines: 1,
                  textInputAction: TextInputAction.next,
                  isRequired: false),
              CustomTextField(
                  keyboardType: TextInputType.number,
                  readOnly: false,
                  controller: mobilePhoneController,
                  obscureText: false,
                  hint: LabelString.lblMobilePhone,
                  titleText: LabelString.lblMobilePhone,
                  maxLines: 1,
                  minLines: 1,
                  textInputAction: TextInputAction.next,
                  isRequired: false),
              CustomTextField(
                  keyboardType: TextInputType.number,
                  readOnly: false,
                  controller: officePhoneController,
                  obscureText: false,
                  hint: LabelString.lblOfficePhone,
                  titleText: LabelString.lblOfficePhone,
                  maxLines: 1,
                  minLines: 1,
                  textInputAction: TextInputAction.next,
                  isRequired: false),
              CustomTextField(
                  keyboardType: TextInputType.emailAddress,
                  readOnly: false,
                  controller: primaryEmailController,
                  obscureText: false,
                  hint: LabelString.lblPrimaryEmail,
                  titleText: LabelString.lblPrimaryEmail,
                  textInputAction: TextInputAction.next,
                  maxLines: 1,
                  minLines: 1,
                  star: "*",
                  isRequired: true),
              CustomTextField(
                  keyboardType: TextInputType.emailAddress,
                  readOnly: false,
                  controller: secondaryEmailController,
                  obscureText: false,
                  hint: LabelString.lblSecondaryEmail,
                  titleText: LabelString.lblSecondaryEmail,
                  maxLines: 1,
                  minLines: 1,
                  textInputAction: TextInputAction.next,
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
                          FocusScope.of(context).unfocus();
                          if (contactBasicDetailFormKey.currentState?.validate() ==true) {
                            /*if (primaryEmailController.text.isValidEmail &&
                                secondaryEmailController.text.isValidEmail) {
                              pageController.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.decelerate);
                            } else {
                              Helpers.showSnackBar(
                                  context, ErrorString.emailNotValid,
                                  isError: true);
                            }*/
                            pageController.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.decelerate);
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
      ),
    );
  }

  //stepTwo design
  buildStepTwo(Size query) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.sp),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Center(
                child: Text(LabelString.lblInvoiceAddressDetails,
                    style: CustomTextStyle.labelBoldFontTextBlue)),
            SizedBox(height: 2.0.h),
            /*Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(LabelString.lblAddressSearch,
                    style: CustomTextStyle.labelFontText),
                SizedBox(height: 1.h),
                autoComplete("invoice"),
              ],
            ),*/
            autoComplete("invoice"),
            SizedBox(height: 2.h),
            CustomTextField(
              keyboardType: TextInputType.name,
              readOnly: false,
              controller: invoiceAddressController,
              obscureText: false,
              hint: LabelString.lblTypeAddress,
              titleText: LabelString.lblInvoiceAddress,
              isRequired: true,
              textInputAction: TextInputAction.none,
              minLines: 1,
              maxLines: 4,
            ),
            CustomTextField(
              keyboardType: TextInputType.name,
              readOnly: false,
              controller: invoiceCityController,
              obscureText: false,
              hint: LabelString.lblInvoiceCity,
              titleText: LabelString.lblInvoiceCity,
              textInputAction: TextInputAction.next,
              isRequired: true,
              maxLines: 1,
              minLines: 1,
            ),
            CustomTextField(
              keyboardType: TextInputType.name,
              readOnly: false,
              controller: invoiceCountryController,
              obscureText: false,
              hint: LabelString.lblInvoiceCountry,
              titleText: LabelString.lblInvoiceCountry,
              textInputAction: TextInputAction.next,
              isRequired: true,
              maxLines: 1,
              minLines: 1,
            ),
            CustomTextField(
              keyboardType: TextInputType.name,
              readOnly: false,
              controller: invoicePostalController,
              obscureText: false,
              hint: LabelString.lblInvoicePostalCode,
              titleText: LabelString.lblInvoicePostalCode,
              textInputAction: TextInputAction.next,
              isRequired: true,
              maxLines: 1,
              minLines: 1,
            ),
            SizedBox(height: 1.0.h),
            Center(
              child: Text(LabelString.lblInstallationAddressDetails,
                  style: CustomTextStyle.labelBoldFontTextBlue),
            ),
            SizedBox(height: 2.0.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                /* Row(
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
                ),*/
                Padding(
                  padding: EdgeInsets.only(right: 8.sp),
                  child: InkWell(
                    onTap: () => copyAddressFields(),
                    child: Image.asset(ImageString.icCopy, height: 3.h),
                  ),
                ),
                SizedBox(height: 1.h),
                autoComplete("installation"),
                SizedBox(height: 2.h),
              ],
            ),
            CustomTextField(
              keyboardType: TextInputType.name,
              readOnly: false,
              controller: installationAddressController,
              obscureText: false,
              hint: LabelString.lblTypeAddress,
              titleText: LabelString.lblInstallationAddress,
              textInputAction: TextInputAction.none,
              isRequired: true,
              minLines: 1,
              maxLines: 4,
            ),
            CustomTextField(
              keyboardType: TextInputType.name,
              readOnly: false,
              controller: installationCityController,
              obscureText: false,
              hint: LabelString.lblInstallationCity,
              titleText: LabelString.lblInstallationCity,
              textInputAction: TextInputAction.next,
              maxLines: 1,
              minLines: 1,
              isRequired: true,
            ),
            CustomTextField(
              keyboardType: TextInputType.name,
              readOnly: false,
              controller: installationCountryController,
              obscureText: false,
              hint: LabelString.lblInstallationCountry,
              titleText: LabelString.lblInstallationCountry,
              textInputAction: TextInputAction.next,
              maxLines: 1,
              minLines: 1,
              isRequired: true,
            ),
            CustomTextField(
              keyboardType: TextInputType.name,
              readOnly: false,
              controller: installationPostalController,
              obscureText: false,
              hint: LabelString.lblInstallationPostalCode,
              titleText: LabelString.lblInstallationPostalCode,
              textInputAction: TextInputAction.next,
              maxLines: 1,
              minLines: 1,
              isRequired: true,
            ),
            buildButtons(query),
          ],
        ),
      ),
    );
  }

  //previous and submit button
  Padding buildButtons(Size query) {
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
              child: BorderButton(
                  btnString: ButtonString.btnPrevious,
                  onClick: () => pageController.previousPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.decelerate))),
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
                          Message.createQuote,

                          //Yes button//
                          () {
                            // createContactApiCall();
                            Navigator.pop(context, true);
                            // Navigator.pop(context);
                            // callNextScreen(
                            //     context,
                            //     AddQuotePage(false, firstNameController.text,
                            //         lastNameController.text));
                          },

                          //No button//
                          () {
                            // createContactApiCall();
                            Navigator.pop(context, false);
                            // Navigator.of(context).pushAndRemoveUntil(
                            //     MaterialPageRoute(
                            //         builder: (c) => const RootScreen()),
                            //     (route) => false);
                          },
                        ),
                      ).then((value) {
                        if (value is bool) {
                          createContactApiCall(value);
                        }
                      });
                    },
                    title: ButtonString.btnSubmit)
                : CustomButton(
                    //update button
                    title: ButtonString.btnUpdate,
                    onClick: () {
                      updateContact();
                      Navigator.pop(context);
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (c) => const RootScreen()),
                          (route) => false);
                    },
                    buttonColor: AppColors.primaryColor),
          )
        ],
      ),
    );
  }

  //Autocomplete textField for fill address fields
  Widget autoComplete(String autoCompleteType) {
    return Autocomplete(
      fieldViewBuilder: (context, textEditingController, focusNode,
          VoidCallback onFieldSubmitted) {
        return TextField(
          style: TextStyle(color: AppColors.blackColor),
          textCapitalization: TextCapitalization.none,
          textInputAction: TextInputAction.next,
          maxLines: 1,
          cursorColor: AppColors.blackColor,
          decoration: InputDecoration(
              suffixIcon: Icon(Icons.search, color: AppColors.blackColor),
              border: UnderlineInputBorder(
                  borderSide: BorderSide(width: 1, color: AppColors.primaryColor)),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(width: 1, color: AppColors.primaryColor)),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(width: 1, color: AppColors.primaryColor)),
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.only(left: 12.sp, top: 12.sp, bottom: 12),
              hintText: LabelString.lblTypeToSearch,
              hintStyle: CustomTextStyle.labelFontHintText,
              counterText: "",
              labelStyle: CustomTextStyle.labelFontHintText,
              labelText: LabelString.lblAddressSearch),
          controller: textEditingController,
          focusNode: focusNode,
          onEditingComplete: () {
            textEditingController.clear();
            FocusScope.of(context).unfocus();
          },
          onSubmitted: (String value) {},

        );
      },
      optionsBuilder: (TextEditingValue textEditingValue) async {
        if (textEditingValue.text.length <= 3) {
          return const Iterable<String>.empty();
        } else {
          //API call for get ID
          var url = "https://api.getAddress.io/autocomplete/${textEditingValue.text.toString()}?api-key=vyPYLl9QWkWvc5BsPwNl4g36069&all=true";

          final response = await http.get(Uri.parse(url),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8'
              });
          final responseJson = json.decode(response.body);
          if (responseJson["suggestions"] != null) {
            addressList = responseJson["suggestions"];
          } else {
            if (mounted)
              Helpers.showSnackBar(context, responseJson["Message"].toString());
          }
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
            var url = "https://api.getAddress.io/get/$addressId?api-key=vyPYLl9QWkWvc5BsPwNl4g36069";

            final response = await http.get(Uri.parse(url));
            final responseJson = json.decode(response.body);

            //set address detail in field
            if (response.statusCode == 200) {
              if (autoCompleteType == "invoice") {
                invoiceAddressController.text = "${responseJson["line_1"]}  ${responseJson["line_2"]}";
                invoiceCityController.text = "${responseJson["town_or_city"]}";
                invoiceCountryController.text = "${responseJson["county"]}";
                invoicePostalController.text = "${responseJson["postcode"]}";
              } else {
                installationAddressController.text = "${responseJson["line_1"]}  ${responseJson["line_2"]}";
                installationCityController.text = "${responseJson["town_or_city"]}";
                installationCountryController.text = "${responseJson["county"]}";
                installationPostalController.text = "${responseJson["postcode"]}";
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
                if (invoiceAddressController.text.isNotEmpty) {
                  installationAddressController.text =
                      invoiceAddressController.text;
                }
              },
            ));

    Clipboard.setData(ClipboardData(text: invoiceCityController.text)).then(
      (value) => Clipboard.getData(Clipboard.kTextPlain).then(
        (value) {
          if (invoiceCityController.text.isNotEmpty) {
            installationCityController.text = invoiceCityController.text;
          }
        },
      ),
    );

    Clipboard.setData(ClipboardData(text: invoiceCountryController.text)).then(
      (value) => Clipboard.getData(Clipboard.kTextPlain).then(
        (value) {
          if (invoiceCountryController.text.isNotEmpty) {
            installationCountryController.text = invoiceCountryController.text;
          }
        },
      ),
    );

    Clipboard.setData(ClipboardData(text: invoicePostalController.text)).then(
      (value) => Clipboard.getData(Clipboard.kTextPlain).then(
        (value) {
          if (invoicePostalController.text.isNotEmpty) {
            installationPostalController.text = invoicePostalController.text;
          }
        },
      ),
    );
  }

  //calling create contact API
  void createContactApiCall(bool isPositive) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    //for create data in json format
    ContactDetailData contactDetailData = ContactDetailData(
        firstNameController.text.trim(),
        lastNameController.text.trim(),
        companyNameController.text.trim(),
        officePhoneController.text.replaceAll("+", "%2B"),
        mobilePhoneController.text.replaceAll("+", "%2B"),
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
      'sessionName': preferences.getString(PreferenceString.sessionName).toString(),
      'element': jsonContactDetail,
      'elementType': 'Contacts',
    };

    addContactBloc.add(AddContactDetailEvent(queryParameters, isPositive));
  }

  Future<void> getContactDetailApi() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    Map<String, dynamic> queryParameters = {
      'operation': "retrieve",
      'sessionName':
          preferences.getString(PreferenceString.sessionName).toString(),
      'id': widget.contactId.toString(),
    };

    addContactBloc.add(GetContactDetailEvent(queryParameters));
  }

  Future<void> updateContact() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    //for create data in json format
    UpdateContactData updateContactData = UpdateContactData(
      contactDetailData.salutationtype.toString(),
      firstNameController.text.trim(),
      contactDetailData.contactNo.toString(),
      officePhoneController.text.trim().replaceAll("+", "%2B"),
      lastNameController.text.trim(),
      mobilePhoneController.text.trim().replaceAll("+", "%2B"),
      contactDetailData.accountId.toString(),
      contactDetailData.homephone.toString(),
      contactDetailData.leadsource.toString(),
      contactDetailData.otherphone.toString(),
      contactDetailData.title.toString(),
      contactDetailData.fax.toString(),
      contactDetailData.department.toString(),
      contactDetailData.birthday.toString(),
      primaryEmailController.text.trim(),
      contactDetailData.contactId.toString(),
      contactDetailData.assistant.toString(),
      secondaryEmailController.text.trim(),
      contactDetailData.assistantphone.toString(),
      contactDetailData.donotcall.toString(),
      contactDetailData.emailoptout.toString(),
      contactDetailData.assignedUserId.toString(),
      contactDetailData.reference.toString(),
      contactDetailData.notifyOwner.toString(),
      contactDetailData.modifiedby.toString(),
      contactDetailData.isconvertedfromlead.toString(),
      companyNameController.text.trim(),
      invoiceAddressController.text.trim(),
      invoiceCityController.text.trim(),
      contactDetailData.mailingstate.toString(),
      contactDetailData.otherstate.toString(),
      invoicePostalController.text.trim(),
      invoiceCountryController.text.trim(),
      contactDetailData.mailingpobox.toString(),
      contactDetailData.otherpobox.toString(),
      contactDetailData.description.toString(),
      contactDetailData.imagename.toString(),
      installationAddressController.text.trim(),
      installationCityController.text.trim(),
      installationPostalController.text.trim(),
      installationCountryController.text.trim(),
      widget.contactId.toString(),
      contactDetailData.assignedUserName.toString(),
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
