import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:nssg/screens/contact/contact_screen.dart';
import 'package:nssg/screens/qoute/quotes_screen.dart';
// import 'package:sizer/sizer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../components/custom_text_styles.dart';
import '../../constants/strings.dart';
import '../contracts/contracts_screen.dart';
import 'bottom_navbar_bloc.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  BottomNavBarBloc? bottomNavBarBloc;

  @override
  void initState() {
    super.initState();
    initialization();
    bottomNavBarBloc = BottomNavBarBloc();
  }

//method for remove native splash screen
  void initialization() async {
    await Future.delayed(const Duration(seconds: 1));
    FlutterNativeSplash.remove();
  }

  @override
  void dispose() {
    bottomNavBarBloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<NavBarItem>(
        stream: bottomNavBarBloc?.itemStream,
        initialData: bottomNavBarBloc?.defaultItem,
        builder: (BuildContext context, AsyncSnapshot<NavBarItem> snapshot) {
          switch (snapshot.data!) {
            case NavBarItem.contact:
              return const ContactScreen();

            case NavBarItem.quote:
              return const QuoteScreen();

            case NavBarItem.contracts:
              return const ContractListScreen();
          }
        },
      ),
      bottomNavigationBar: StreamBuilder(
        stream: bottomNavBarBloc?.itemStream,
        initialData: bottomNavBarBloc?.defaultItem,
        builder: (BuildContext context, AsyncSnapshot<NavBarItem> snapshot) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: (Radius.circular(20.0)),
                  topRight: (Radius.circular(20.0))),
            ),
            child: BottomNavigationBar(
              currentIndex: snapshot.data!.index,
              backgroundColor: Colors.transparent,
              showUnselectedLabels: true,
              elevation: 0,
              iconSize: 20.sp,
              selectedLabelStyle: CustomTextStyle.commonText,
              unselectedLabelStyle: CustomTextStyle.commonText,
              onTap: bottomNavBarBloc?.pickItem,
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.group_rounded,
                    ),
                    label: LabelString.lblContact),
                BottomNavigationBarItem(
                    icon: Icon(Icons.help_rounded),
                    label: LabelString.lblQuotes),
                BottomNavigationBarItem(
                    icon: ImageIcon(AssetImage("assets/images/contract.png")),
                    label: LabelString.lblContracts),
              ],
            ),
          );
        },
      ),
    );
  }
}
