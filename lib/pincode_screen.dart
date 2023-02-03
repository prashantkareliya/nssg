import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nssg/components/custom_text_styles.dart';
import 'package:nssg/constants/strings.dart';
import 'package:nssg/screens/authentication/login/login_bloc_dir/login_bloc.dart';
import 'package:nssg/screens/authentication/login/login_data_dir/login_datasource.dart';
import 'package:nssg/screens/authentication/login/login_data_dir/login_repository.dart';
import 'package:nssg/screens/dashboard/root_screen.dart';
import 'package:nssg/utils/app_colors.dart';
import 'package:nssg/utils/helpers.dart';
import 'package:nssg/utils/preferences.dart';
import 'package:nssg/utils/widgets.dart';
import 'package:passcode_screen/circle.dart';
import 'package:passcode_screen/keyboard.dart';
import 'package:passcode_screen/passcode_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import 'constants/navigation.dart';

const storedPasscode = '2017';

class PinCodeScreen extends StatefulWidget {
  const PinCodeScreen({Key? key}) : super(key: key);

  @override
  State<PinCodeScreen> createState() => _PinCodeScreenState();
}

class _PinCodeScreenState extends State<PinCodeScreen> {
  final StreamController<bool> _verificationNotifier = StreamController<bool>.broadcast();

  bool isAuthenticated = false;
  LoginBloc loginBloc =
      LoginBloc(LoginRepository(authDataSource: LoginDataSource()));
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: BlocListener<LoginBloc, LoginState>(
        bloc: loginBloc,
        listener: (context, state) {
          if (state is LoginLoadFailure) {
            Helpers.showSnackBar(context, state.error.toString());
          }

          if (state is LoginLoaded) {
            preferences.setPreference(PreferenceString.userId, state.userId);
            preferences.setPreference(PreferenceString.sessionName, state.sessionName);
            preferences.setPreference(PreferenceString.userName, state.userName);
            //Helpers.showSnackBar(context, state.msg.toString());
            removeAndCallNextScreen(context, const RootScreen());
          }
        },
        child: BlocBuilder<LoginBloc, LoginState>(
          bloc: loginBloc,
          builder: (context, state) {
            if (state is LoginLoading) {
              isLoading = state.isBusy;
            }

            if (state is LoginLoadFailure) {
              isLoading = false;
            }
            return AbsorbPointer(
              absorbing: isLoading,
              child: Stack(
                children: [
                  PasscodeScreen(
                    circleUIConfig: CircleUIConfig(
                        borderColor: AppColors.blackColor,
                        fillColor: AppColors.blackColor,
                        circleSize: 10.sp),
                    keyboardUIConfig: KeyboardUIConfig(
                      primaryColor: AppColors.primaryColorLawOpacity,
                      digitBorderWidth: 2,
                      digitFillColor: AppColors.primaryColorLawOpacity),
                    title: Text(
                      Message.enterYourPasscodeToUnlock,
                      textAlign: TextAlign.center,
                      style: CustomTextStyle.labelMediumBoldFontText,
                    ),

                    passwordEnteredCallback: _onPasscodeEntered,
                    deleteButton: Icon(Icons.backspace, color: AppColors.blackColor),
                    shouldTriggerVerification: _verificationNotifier.stream,
                    backgroundColor: AppColors.backWhiteColor,
                    cancelCallback: _onPasscodeCancelled,
                    digits: const ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0'],
                    passwordDigits: 4,
                    cancelButton: Text(
                      "",
                      style: CustomTextStyle.labelText,
                    ),
                  ),
                  Visibility(
                    visible: isLoading,
                    child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: 8.h,
                          width: 25.w,
                          decoration: BoxDecoration(
                              color: Colors.white10,
                            borderRadius: BorderRadius.circular(10.0)
                          ),
                          child: loadingView(),
                        )),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  _onPasscodeEntered(String enteredPasscode) {
    bool isValid = storedPasscode == enteredPasscode;
    _verificationNotifier.add(isValid);
    if (isValid) {
      callApi(enteredPasscode);
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

  callApi(String enteredPasscode) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    Map<String, dynamic> queryParameters = {
      'username': preferences.getString(PreferenceString.userName).toString(),
      'loginpin': enteredPasscode.toString(), //2017
      'accesskey': 'S8QzomH4Q4QYxaFb',
    };
    loginBloc.add(LoginUserEvent(queryParameters));
  }
}
