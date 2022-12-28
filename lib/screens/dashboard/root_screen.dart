import 'package:flutter/material.dart';
import 'package:nssg/components/custom_text_styles.dart';
import 'package:nssg/utils/app_colors.dart';
import 'package:sizer/sizer.dart';
import '../../components/bottom_navigationbar/nav_bar_items.dart';
import '../../components/bottom_navigationbar/navigation_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/strings.dart';
import '../contact/contact_screen.dart';
import '../qoute/quotes_screen.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  RootScreenState createState() => RootScreenState();
}

class RootScreenState extends State<RootScreen> {
  Color? backColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backWhiteColor,
      bottomNavigationBar: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
          return Container(
            height: 8.h,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: (Radius.circular(20.0)),
                  topRight: (Radius.circular(20.0))),
            ),
            child: BottomNavigationBar(
              currentIndex: state.index,
              backgroundColor: Colors.transparent,
              showUnselectedLabels: true,
              elevation: 0,
              iconSize: 20.sp,
              selectedLabelStyle: CustomTextStyle.commonText,
              unselectedLabelStyle: CustomTextStyle.commonText,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.group), label: LabelString.lblContact),
                BottomNavigationBarItem(
                    icon: Icon(Icons.access_time_filled),
                    label: LabelString.lblQuotes),
              ],
              onTap: (index) {
                if (index == 0) {
                  BlocProvider.of<NavigationCubit>(context)
                      .getNavBarItem(NavbarItem.contacts);
                } else if (index == 1) {
                  BlocProvider.of<NavigationCubit>(context)
                      .getNavBarItem(NavbarItem.quotes);
                }
              },
            ),
          );
        },
      ),
      body: BlocBuilder<NavigationCubit, NavigationState>(
          builder: (context, state) {
        if (state.navbarItem == NavbarItem.contacts) {
          return const ContactScreen();
        } else if (state.navbarItem == NavbarItem.quotes) {
          return const QuoteScreen();
        }
        return Container();
      }),
    );
  }
}
