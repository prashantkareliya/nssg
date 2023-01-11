import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:nssg/utils/widgetChange.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'constants/strings.dart';
import 'screens/authentication/login/login_screen.dart';

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
    return Sizer(builder: (context, orientation, deviceType) {
      return MultiProvider(
        providers: [ChangeNotifierProvider.value(value: WidgetChange())],
        child: MaterialApp(
          title: 'National Security System ',
          theme: ThemeData(primarySwatch: Colors.indigo),
          home: const CheckingScreen(),
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
          MaterialPageRoute(builder: (c) => LoginScreen("isLogin")),
          (route) => false);
    } else {
      // callNextScreen(context, LoginScreen("isNotLogin"));
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (c) => LoginScreen("isNotLogin")),
          (route) => false);
    }
  }
}
