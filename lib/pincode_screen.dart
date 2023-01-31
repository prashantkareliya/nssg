import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nssg/components/custom_text_styles.dart';
import 'package:nssg/constants/strings.dart';
import 'package:nssg/utils/app_colors.dart';
import 'package:passcode_screen/circle.dart';
import 'package:passcode_screen/keyboard.dart';
import 'package:passcode_screen/passcode_screen.dart';
import 'package:sizer/sizer.dart';

const storedPasscode = '123456';

class PinCodeScreen extends StatefulWidget {
  const PinCodeScreen({Key? key}) : super(key: key);

  @override
  State<PinCodeScreen> createState() => _PinCodeScreenState();
}

class _PinCodeScreenState extends State<PinCodeScreen> {
  final StreamController<bool> _verificationNotifier =
      StreamController<bool>.broadcast();

  bool isAuthenticated = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Container(

        child: PasscodeScreen(
          circleUIConfig: CircleUIConfig(borderColor: AppColors.blackColor, fillColor: AppColors.blackColor, circleSize: 10.sp),
          keyboardUIConfig: KeyboardUIConfig(
            primaryColor: AppColors.whiteColor,
            digitBorderWidth: 0,
            digitFillColor: AppColors.primaryColorLawOpacity,
          ),
          title: Text(
            'Enter your Passcode to unlock',
            textAlign: TextAlign.center,
            style: CustomTextStyle.labelMediumBoldFontText,
          ),
          passwordEnteredCallback: _onPasscodeEntered,
          deleteButton: Text(
            'Delete',
            style: CustomTextStyle.labelBoldFontText,
            semanticsLabel: 'Delete',
          ),
          shouldTriggerVerification: _verificationNotifier.stream,
          backgroundColor: AppColors.whiteColor,
          cancelCallback: _onPasscodeCancelled,
          digits: ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0'],
          passwordDigits: 4,
          cancelButton: Text(
            ButtonString.btnCancel,
            style: CustomTextStyle.labelText,
          ),
        ),
      ),
    );
  }

  _onPasscodeEntered(String enteredPasscode) {
    bool isValid = storedPasscode == enteredPasscode;
    _verificationNotifier.add(isValid);
    if (isValid) {
      setState(() {
        this.isAuthenticated = isValid;
      });
    }
  }

  _onPasscodeCancelled() {
    Navigator.maybePop(context);
  }

  @override
  void dispose() {
    _verificationNotifier.close();
    super.dispose();
  }
}
