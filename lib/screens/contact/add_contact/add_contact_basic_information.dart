import 'package:flutter/material.dart';
import 'package:nssg/components/custom_appbar.dart';
import 'package:nssg/components/custom_text_styles.dart';
import 'package:nssg/utils/app_colors.dart';
import 'package:nssg/utils/extention_text.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../components/custom_button.dart';
import '../../../components/custom_textfield.dart';
import '../../../components/custom_rounded_container.dart';
import '../../../constants/navigation.dart';
import '../../../constants/strings.dart';
import '../../../utils/helpers.dart';
import '../../../utils/widgetChange.dart';
import 'add_contact_address_information.dart';

class AddContactBasicInformationPage extends StatefulWidget {
  const AddContactBasicInformationPage({Key? key}) : super(key: key);

  @override
  State<AddContactBasicInformationPage> createState() =>
      _AddContactBasicInformationPageState();
}

class _AddContactBasicInformationPageState
    extends State<AddContactBasicInformationPage> {
  StepperType stepperType = StepperType.horizontal;
  int selectedStep = 1;
  final contactBasicDetailFormKey = GlobalKey<FormState>();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController officePhoneController = TextEditingController();
  TextEditingController mobilePhoneController = TextEditingController();
  TextEditingController primaryEmailController = TextEditingController();
  TextEditingController secondaryEmailController = TextEditingController();

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
                            isEnable: true,
                            isDone: false),
                        RoundedContainer(
                            containerText: "2",
                            stepText: "2",
                            isEnable: false,
                            isDone: false),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 12.sp, vertical: 6.sp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(LabelString.lblBasicInformation,
                              style: CustomTextStyle.labelBoldFontTextSmall),
                          Row(
                            children: [
                              Text(LabelString.lblStep,
                                  style: CustomTextStyle.commonText),
                              Text(" 1/2",
                                  style: CustomTextStyle.commonTextBlue),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 1.0.h),
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
                        buildButtons(query),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Padding buildButtons(Size query) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.sp, horizontal: 2.0.sp),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
            width: query.width * 0.4,
            height: query.height * 0.06,
            child: CustomButton(
                buttonColor: AppColors.redColor,
                onClick: () => Navigator.pop(context),
                title: ButtonString.btnCancel),
          ),
          SizedBox(
            width: query.width * 0.4,
            height: query.height * 0.06,
            child: CustomButton(
              buttonColor: AppColors.primaryColor,
              onClick: () {
                if (contactBasicDetailFormKey.currentState?.validate() ==
                    true) {
                  if (primaryEmailController.text.toString().isValidEmail) {
                    callNextScreen(
                        context,
                        AddContactAddressInfoPage(
                            firstNameController.text.trim(),
                            lastNameController.text.trim(),
                            companyNameController.text.trim(),
                            officePhoneController.text.trim(),
                            mobilePhoneController.text.trim(),
                            primaryEmailController.text.trim(),
                            secondaryEmailController.text.trim()));
                  } else {
                    Helpers.showSnackBar(context, ErrorString.emailNotValid,
                        isError: true);
                  }
                }
              },
              title: ButtonString.btnNext,
            ),
          )
        ],
      ),
    );
  }
}
