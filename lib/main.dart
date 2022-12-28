import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:nssg/components/bottom_navigationbar/navigation_cubit.dart';
import 'package:nssg/utils/widgetChange.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'screens/authentication/login/login_screen.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((value) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return BlocProvider<NavigationCubit>(
        create: (context) => NavigationCubit(),
        child: MultiProvider(
          providers: [ChangeNotifierProvider.value(value: WidgetChange())],
          child: MaterialApp(
            title: 'National Security System ',
            theme: ThemeData(primarySwatch: Colors.indigo),
            home: LoginScreen(),
          ),
        ),
      );
    });
  }
}
