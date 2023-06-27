import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nssg/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../constants/strings.dart';
import 'engineer_bottom_navbar_bloc.dart';
import 'job_schedule.dart';

class EngineerRootScreen extends StatefulWidget {
  const EngineerRootScreen({super.key});

  @override
  createState() => _EngineerRootScreenState();
}

class _EngineerRootScreenState extends State<EngineerRootScreen> {
  EngineerBottomNavBarBloc? bottomNavBarBloc;

  @override
  void initState() {
    super.initState();
    initialization();
    bottomNavBarBloc = EngineerBottomNavBarBloc();
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
      extendBody: true,
      body: StreamBuilder<NavBarItem>(
        stream: bottomNavBarBloc?.itemStream,
        initialData: bottomNavBarBloc?.defaultItem,
        builder: (BuildContext context, AsyncSnapshot<NavBarItem> snapshot) {
          switch (snapshot.data!) {
            case NavBarItem.home:
              return const JobSchedule();

            case NavBarItem.logout:
              return Container();
          }
        },
      ),
      bottomNavigationBar: StreamBuilder(
        stream: bottomNavBarBloc?.itemStream,
        initialData: bottomNavBarBloc?.defaultItem,
        builder: (BuildContext context, AsyncSnapshot<NavBarItem> snapshot) {
          return Container(
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: const BorderRadius.only(
                  topLeft: (Radius.circular(20.0)),
                  topRight: (Radius.circular(20.0))),
            ),
            child: BottomNavigationBar(
              currentIndex: snapshot.data!.index,
              backgroundColor: AppColors.transparent,
              showUnselectedLabels: true,
              elevation: 0,
              selectedLabelStyle: GoogleFonts.roboto(
                  textStyle: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal)),
              unselectedLabelStyle: GoogleFonts.roboto(
                  textStyle: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal)),
              unselectedItemColor: AppColors.primaryColor,
              onTap: bottomNavBarBloc?.pickItem,
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                    icon: Padding(
                      padding: EdgeInsets.all(5.sp),
                      child: SvgPicture.asset(ImageString.icHome, height: 16.h)),
                    label: EngineerString.lblHome),
                BottomNavigationBarItem(
                    icon: Padding(
                      padding: EdgeInsets.all(0.sp),
                      child: null),
                    label: ""),
                BottomNavigationBarItem(
                    icon: Padding(
                      padding: EdgeInsets.all(0.sp),
                      child: null),
                    label: ""),
                BottomNavigationBarItem(
                    icon: Padding(
                      padding: EdgeInsets.all(0.sp),
                      child: null),
                    label: ""),
                BottomNavigationBarItem(
                    icon: Padding(
                      padding: EdgeInsets.all(5.sp),
                      child: SvgPicture.asset(ImageString.icLogout, height: 16.h)),
                    label: EngineerString.lblLogout),
              ],
            ),
          );
        },
      ),
    );
  }
}
