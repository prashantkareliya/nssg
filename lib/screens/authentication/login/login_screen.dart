import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import 'package:nssg/constants/navigation.dart';
import 'package:nssg/screens/authentication/login/login_datasource.dart';
import 'package:nssg/screens/authentication/login/models/login_repository.dart';
import 'package:nssg/screens/dashboard/root_screen.dart';
import 'package:nssg/utils/extention_text.dart';
import 'package:nssg/utils/widgetChange.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_text_styles.dart';
import '../../../components/custom_textfield.dart';
import '../../../constants/strings.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/helpers.dart';
import 'bloc/login_bloc.dart';
import 'models/request_login_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isVisibleText = false;

  @override
  void initState() {
    super.initState();
    initialization();
  }

  //method for remove native splash screen
  void initialization() async {
    await Future.delayed(const Duration(seconds: 1));
    FlutterNativeSplash.remove();
  }

  //controller for email | password fields
  TextEditingController userNameController =
      TextEditingController(text: "test@gmail.com");
  TextEditingController passwordController =
      TextEditingController(text: "00000");
  final loginFormKey = GlobalKey<FormState>();

  //controller for pin number fields
  TextEditingController newTextEditingController = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  void dispose() {
    newTextEditingController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  LoginBloc loginBloc =
      LoginBloc(LoginRepository());

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return Scaffold(
      body: Form(
          key: loginFormKey,
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(ImageString.imgBack),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromRGBO(40, 89, 155, 1),
                    Color.fromRGBO(42, 39, 96, 1)
                  ],
                )),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 80.sp, horizontal: 20.sp),
                  child: Container(
                    /*width: query.width,
                  height: query.height * 0.74,*/
                    decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.asset(ImageString.imgLogoSplash),
                          //email | password field visibility
                          Visibility(
                            visible: true,
                            child: Column(
                              children: [
                                buildEmailInput(),
                                SizedBox(height: 3.h),
                                buildPasswordInput(),
                              ],
                            ),
                          ),
                          //pin number fields visibility
                          Visibility(
                            visible: false,
                            child: Column(
                              children: [
                                Text("abcd@gmail.com",
                                    style: CustomTextStyle.labelFontHintText),
                                SizedBox(height: 3.h),
                                Text(LabelString.lblEnterPinNumber,
                                    style: CustomTextStyle.labelText),
                                SizedBox(height: 3.h),
                                buildPinNumber(),
                              ],
                            ),
                          ),

                          //Login Button
                          SizedBox(
                            width: query.width,
                            height: 7.h,
                            child: CustomButton(
                              title: ButtonString.btnLogin.toUpperCase(),
                              onClick: () {
                                validateAndDoLogin();
                              },
                            ),
                          ),
                          buildPowerLabel(),
                          SizedBox(height: query.height * 0.001)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )),
    );
  }

  //enter email field
  Widget buildEmailInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          keyboardType: TextInputType.name,
          readOnly: false,
          controller: userNameController,
          obscureText: false,
          hint: "abcd@gmail.com",
          titleText: LabelString.lblEmailAddress,
          isRequired: true,
        ),
      ],
    );
  }

  //enter password field
  Widget buildPasswordInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
            keyboardType: TextInputType.name,
            readOnly: false,
            controller: passwordController,
            obscureText:
                Provider.of<WidgetChange>(context, listen: false).isVisibleText,
            hint: "* * * * * * *",
            titleText: LabelString.lblPassword,
            isRequired: true,
            suffixWidget: Padding(
              padding: EdgeInsets.only(right: 2.sp),
              child: IconButton(
                onPressed: () {
                  Provider.of<WidgetChange>(context, listen: false)
                      .textVisibility();
                },
                icon: Provider.of<WidgetChange>(context, listen: true)
                        .isVisibleText
                    ? Image.asset(ImageString.icImageVisible)
                    : Image.asset(ImageString.icImageInVisible),
              ),
            )),
      ],
    );
  }

  Widget buildPowerLabel() {
    return Text(LabelString.lblPoweredBy,
        style: CustomTextStyle.labelFontHintText);
  }

  //login button validation for email login
  validateAndDoLogin() {
    if (loginFormKey.currentState?.validate() == true) {
      if (userNameController.text.toString().isValidEmail) {
        Map<String, String> queryParameters = {
          'username': 'dn@nssg.co.uk',
          'password': 'dave@12345',
          'accesskey': 'S8QzomH4Q4QYxaFb',
        };
        loginBloc.add(LoginUserEvent(queryParameters));

        //moveToNextScreen();
      } else {
        Helpers.showSnackBar(context, ErrorString.emailNotValid, isError: true);
      }
    }
  }

  //Pin number for login with pin
  Widget buildPinNumber() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: PinCodeFields(
        length: 4,
        borderColor: AppColors.fontColor,
        textStyle: TextStyle(fontSize: 15.sp, color: AppColors.fontColor),
        activeBorderColor: AppColors.fontColor,
        obscureText: true,
        controller: newTextEditingController,
        focusNode: focusNode,
        keyboardType: TextInputType.number,
        animationCurve: Curves.easeInOut,
        switchInAnimationCurve: Curves.easeIn,
        switchOutAnimationCurve: Curves.easeOut,
        onComplete: (result) {
          // Your logic with code
          print(result);
          moveToNextScreen();
        },
      ),
    );
  }

  //Move to root screen where write code for the bottom tab
  void moveToNextScreen() {
    callNextScreen(context, const RootScreen());
  }
}
