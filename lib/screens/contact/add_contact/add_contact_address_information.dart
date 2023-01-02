import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nssg/screens/contact/add_contact/add_contact_bloc_dir/add_contact_bloc.dart';
import 'package:nssg/utils/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../../../constants/navigation.dart';
import '../../../utils/helpers.dart';
import '../../dashboard/root_screen.dart';
import '../../qoute/add_quote.dart';
import '../contact_datasource.dart';
import '../contact_repository.dart';
import 'add_contact_detail_data_model.dart';

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

  AddContactAddressInfoPage(
      this.firstName,
      this.lastName,
      this.companyName,
      this.officePhone,
      this.mobilePhone,
      this.primaryEmail,
      this.secondaryEmail,
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

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: BaseAppBar(
        appBar: AppBar(),
        elevation: 1,
        title: LabelString.lblAddNewContact,
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
            return SizedBox(
              height: query.height,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    buildStepper(),
                    SizedBox(height: 1.0.h),
                    textFiledForAddAddress(query)
                  ],
                ),
              ),
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
  Expanded textFiledForAddAddress(Size query) {
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
          CustomTextField(
            keyboardType: TextInputType.name,
            readOnly: false,
            controller: invoiceSearchController,
            obscureText: false,
            hint: LabelString.lblTypeToSearch,
            titleText: LabelString.lblAddressSearch,
            isRequired: false,
            suffixWidget: Icon(Icons.search, color: AppColors.blackColor),
          ),
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
          CustomTextField(
            copyWidget: InkWell(
              onTap: () {
                copyAddressFields();
              },
              child: Image.asset(ImageString.icCopy),
            ),
            keyboardType: TextInputType.name,
            readOnly: false,
            controller: installationSearchController,
            obscureText: false,
            hint: LabelString.lblTypeToSearch,
            titleText: LabelString.lblAddressSearch,
            isRequired: true,
            suffixWidget: Icon(Icons.search, color: AppColors.blackColor),
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
          buildButtons(query),
        ],
      ),
    );
  }

  //Bottom buttons
  Padding buildButtons(Size query) {
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
                  child: CustomButton(
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
                    title: ButtonString.btnSubmit,
                  ),
                )
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

  void createContactApiCall() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

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
}
