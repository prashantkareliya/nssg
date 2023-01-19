import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import 'package:nssg/constants/navigation.dart';
import 'package:nssg/screens/dashboard/root_screen.dart';
import 'package:nssg/utils/extention_text.dart';
import 'package:nssg/utils/widgetChange.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_text_styles.dart';
import '../../../components/custom_textfield.dart';
import '../../../constants/strings.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/helpers.dart';
import '../../../utils/preferences.dart';
import '../../../utils/widgets.dart';
import 'login_bloc_dir/login_bloc.dart';
import 'login_data_dir/login_datasource.dart';
import 'login_data_dir/login_repository.dart';

// ignore: must_be_immutable
class LoginScreen extends StatefulWidget {
  String isLogin;

  LoginScreen(this.isLogin, {Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //controller for email | password fields
  TextEditingController userNameController =
      TextEditingController(text: "dn@nssg.co.uk");
  TextEditingController passwordController =
      TextEditingController(text: "dave@12345");

  final loginFormKey = GlobalKey<FormState>();

  //controller for pin number fields
  TextEditingController newTextEditingController = TextEditingController();
  FocusNode focusNode = FocusNode();

  //Variable for login with pin screen's username
  String? userName = "xxxx@gmail.com";

  LoginBloc loginBloc =
      LoginBloc(LoginRepository(authDataSource: LoginDataSource()));
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.isLogin == "isLogin") {
      getUserName();
    }
  }

  @override
  void dispose() {
    super.dispose();
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context).size;
    return Scaffold(
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
            Helpers.showSnackBar(context, state.msg.toString());
            moveToNextScreen();
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
            return getBody(context, query);
          },
        ),
      ),
    );
  }

  Form getBody(BuildContext context, Size query) {
    return Form(
        key: loginFormKey,
        child: SingleChildScrollView(
          child: Container(
            width: buildResponsiveWidth(context),
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ImageString.imgBack),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: query.height * 0.12,
                  horizontal: query.width * 0.05),
              child: Container(
                decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius:
                        const BorderRadius.all(Radius.circular(10.0))),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: query.width * 0.07),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(height: 3.h),
                      Image.asset(ImageString.imgLogoSplash,
                          height: query.height * 0.25),
                      //email | password field visibility
                      Visibility(
                        visible: widget.isLogin == "isLogin" ? false : true,
                        child: Column(
                          children: [
                            buildEmailInput(),
                            buildPasswordInput(),
                          ],
                        ),
                      ),
                      //pin number fields visibility
                      Visibility(
                        visible: widget.isLogin == "isLogin" ? true : false,
                        child: Column(
                          children: [
                            Text(userName!,
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
                          child: isLoading
                              ? loadingView()
                              : widget.isLogin == "isLogin"
                                  ? CustomButton(
                                      title: ButtonString
                                          .btnLoginWithOtherAccount
                                          .toUpperCase(),
                                      onClick: () {
                                        setState(() {
                                          widget.isLogin = "isNotLogin";
                                          preferences.removeKeyFromPreference(
                                              PreferenceString.sessionName);
                                        });
                                      })
                                  : CustomButton(
                                      title:
                                          ButtonString.btnLogin.toUpperCase(),
                                      onClick: () => validateAndDoLogin(),
                                    )),
                      buildPowerLabel(),
                      SizedBox(height: query.height * 0.001)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
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
  validateAndDoLogin() async {
    if (loginFormKey.currentState?.validate() == true) {
      if (userNameController.text.toString().isValidEmail) {
        Map<String, dynamic> queryParameters = {
          'username': userNameController.text.trim(),
          'password': passwordController.text.trim(),
          'accesskey': 'S8QzomH4Q4QYxaFb',
        };
        loginBloc.add(LoginUserEvent(queryParameters));
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
          Map<String, dynamic> queryParameters = {
            'username': userName.toString(),
            'loginpin': result.toString(), //2017
            'accesskey': 'S8QzomH4Q4QYxaFb',
          };
          loginBloc.add(LoginUserEvent(queryParameters));
        },
      ),
    );
  }

  //Move to root screen where write code for the bottom tab
  void moveToNextScreen() {
    removeAndCallNextScreen(context, const RootScreen());
  }

  Future<void> getUserName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userName = preferences.getString(PreferenceString.userName).toString();
  }
}
