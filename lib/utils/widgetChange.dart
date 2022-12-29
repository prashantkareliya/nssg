import 'package:flutter/material.dart';

class WidgetChange extends ChangeNotifier {
  bool isVisibleText = true;
  bool isAppbarShow = true;

  //list for dropdown
  var items = ['None', 'Mr.', 'Mrs.', 'Miss'];
  var selectItem;

  //method for password visibility
  void textVisibility() {
    isVisibleText = !isVisibleText;
    notifyListeners();
  }

  //Appbar and search show - hide
  void appbarVisibility() {
    isAppbarShow = !isAppbarShow;
    notifyListeners();
  }

  //Dropdown change
  selectItemValue(value) {
    selectItem = value;
    notifyListeners();
  }
}
