import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nssg/screens/qoute/bloc/product_list_bloc.dart';
import 'package:nssg/utils/app_colors.dart';
import 'package:nssg/utils/widgetChange.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constants/strings.dart';
import 'pincode_screen.dart';
import 'screens/authentication/login/login_screen.dart';
import 'screens/engineersApp/engineersApp/engineer_dashboard/engineer_root_screen.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((value) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MultiProvider(
            providers: [ChangeNotifierProvider.value(value: WidgetChange())],
            child: BlocProvider(
              create: (context) => ProductListBloc(),
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'National Security System ',
                theme: ThemeData(
                    pageTransitionsTheme: const PageTransitionsTheme(builders: {
                      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
                      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
                    }),
                    colorScheme: ColorScheme.fromSwatch().copyWith(
                        primary: AppColors.primaryColor, secondary: AppColors.primaryColor)),
                home: const CheckingScreen(),
              ),
            ),
          );
        });
  }
}

//Make this class for move login with username password of login with pin
class CheckingScreen extends StatefulWidget {
  const CheckingScreen({Key? key}) : super(key: key);

  @override
  State<CheckingScreen> createState() => _CheckingScreenState();
}

class _CheckingScreenState extends State<CheckingScreen> {
  @override
  void initState() {
    super.initState();
    initialization();
    getPreference();
  }

  //method for remove native splash screen
  void initialization() async {
    await Future.delayed(const Duration(seconds: 1));
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }

  void getPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    moveNextScreen(preferences);
  }

  //checking sessionName null or not
  void moveNextScreen(SharedPreferences preferences) {
    if (preferences.getString(PreferenceString.sessionName) != null) {
      //callNextScreen(context, LoginScreen("isLogin"));
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (c) => const PinCodeScreen() /*const EngineerRootScreen()*/),
          (route) => false);
    } else {
      // callNextScreen(context, LoginScreen("isNotLogin"));
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (c) => LoginScreen("isNotLogin")), (route) => false);
    }
  }
}
