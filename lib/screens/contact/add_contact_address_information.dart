import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../components/custom_appbar.dart';
import '../../components/custom_button.dart';
import '../../components/custom_dialog.dart';
import '../../components/custom_text_styles.dart';
import '../../components/custom_textfield.dart';
import '../../components/cutom_rounded_container.dart';
import '../../constants/navigation.dart';
import '../../constants/strings.dart';
import '../../utils/app_colors.dart';
import '../qoute/add_quote.dart';

class AddContactAddressInfoPage extends StatefulWidget {
  const AddContactAddressInfoPage({Key? key}) : super(key: key);

  @override
  State<AddContactAddressInfoPage> createState() =>
      _AddContactAddressInfoPageState();
}

class _AddContactAddressInfoPageState extends State<AddContactAddressInfoPage> {
  TextEditingController invoiceSearchController = TextEditingController();
  TextEditingController invoiceAddressController = TextEditingController();
  TextEditingController invoiceCityController = TextEditingController();
  TextEditingController invoiceCountryController = TextEditingController();
  TextEditingController invoicePostalCodeController = TextEditingController();

  TextEditingController installationSearchController = TextEditingController();
  TextEditingController installationAddressController = TextEditingController();
  TextEditingController installationCityController = TextEditingController();
  TextEditingController installationCountryController = TextEditingController();
  TextEditingController installationPostalCodeController =
      TextEditingController();

  String pasteValue = '';

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
      body: SizedBox(
        height: query.height,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RoundedContainer(
                            containerText: "1",
                            stepText: "1",
                            isEnable: false,
                            isDone: true),
                        RoundedContainer(
                            containerText: "2",
                            stepText: "2",
                            isEnable: true,
                            isDone: false)
                      ]),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.sp, vertical: 6.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(LabelString.lblAddressInformation,
                            style: CustomTextStyle.labelBoldFontTextSmall),
                        Row(
                          children: [
                            Text(LabelString.lblStep,
                                style: CustomTextStyle.commonText),
                            Text(" 2/2", style: CustomTextStyle.commonTextBlue),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 1.0.h),
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 10.sp),
                  shrinkWrap: true,
                  children: [
                    Center(
                      child: Text(LabelString.lblInvoiceAddressDetails,
                          style: CustomTextStyle.labelBoldFontTextBlue),
                    ),
                    SizedBox(height: 2.0.h),
                    CustomTextField(
                      /* copyWidget: InkWell(
                        onTap: () {},
                        child: Image.asset(ImageString.icCopy),
                      ),*/
                      keyboardType: TextInputType.name,
                      readOnly: false,
                      controller: invoiceSearchController,
                      obscureText: false,
                      hint: LabelString.lblTypeToSearch,
                      titleText: LabelString.lblAddressSearch,
                      isRequired: false,
                      suffixWidget:
                          Icon(Icons.search, color: AppColors.blackColor),
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
                      controller: invoicePostalCodeController,
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
                          FlutterClipboard.copy(
                            invoiceAddressController.text.trim(),
                          ).then((value) {
                            FlutterClipboard.paste().then((value) {
                              installationAddressController.text = value;
                              pasteValue = value;
                            });
                          });
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
                      suffixWidget:
                          Icon(Icons.search, color: AppColors.blackColor),
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
                      controller: installationPostalCodeController,
                      obscureText: false,
                      hint: LabelString.lblInstallationPostalCode,
                      titleText: LabelString.lblInstallationPostalCode,
                      isRequired: true,
                    ),
                    buildButtons(query),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Padding buildButtons(Size query) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.sp, horizontal: 2.0.sp),
      child: Row(
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
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(
                                color: AppColors.primaryColor, width: 2)))),
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
                          () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                            removeAndCallNextScreen(
                                context, const AddQuotePage());
                          },
                        ));
              },
              title: ButtonString.btnSubmit,
            ),
          )
        ],
      ),
    );
  }

  void _copyText(String textAddress, String textCity, String textCountry,
      String textPostalCode) {
    FlutterClipboard.copy(
      invoiceAddressController.text.trim(),
    ).then((value) {
      FlutterClipboard.paste().then((value) {
        installationAddressController.text = value;
        pasteValue = value;
      });
    });

    FlutterClipboard.copy(
      invoiceCityController.text.trim(),
    ).then((value) {
      FlutterClipboard.paste().then((value) {
        installationCityController.text = value;
        pasteValue = value;
      });
    });
  }
}
