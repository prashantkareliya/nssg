import 'dart:async';

enum NavBarItem { contact, quote, /*jobList*/ }

class BottomNavBarBloc {
  final StreamController<NavBarItem> _navBarController =
      StreamController<NavBarItem>.broadcast();

  NavBarItem defaultItem = NavBarItem.contact;

  Stream<NavBarItem> get itemStream => _navBarController.stream;

  void pickItem(int i) {
    switch (i) {
      case 0:
        _navBarController.sink.add(NavBarItem.contact);
        break;
      case 1:
        _navBarController.sink.add(NavBarItem.quote);
        break;
      /*case 2:
        _navBarController.sink.add(NavBarItem.jobList);
        break;*/
    }
  }

  close() {
    _navBarController.close();
  }
}
