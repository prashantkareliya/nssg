
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'nav_bar_items.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationState(NavbarItem.contacts, 0));

  void getNavBarItem(NavbarItem navbarItem) {
    switch (navbarItem) {
      case NavbarItem.contacts:
        emit(const NavigationState(NavbarItem.contacts, 0));
        break;
      case NavbarItem.quotes:
        emit(const NavigationState(NavbarItem.quotes, 1));
        break;
    }
  }
}
