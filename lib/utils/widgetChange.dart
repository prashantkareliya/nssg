import 'package:flutter/material.dart';

class WidgetChange extends ChangeNotifier {
  bool isVisibleText = true;
  bool isAppbarShow = true;
  bool isReminderCheck = false;
  bool isSetTime = false;
  bool isSetPremises = false;
  bool isSetEngineer = false;

  //list for dropdown
  var items = ['None', 'Mr.', 'Mrs.', 'Miss'];
  var selectItem;

  //method for password visibility
  void textVisibility() {
    isVisibleText = !isVisibleText;
    notifyListeners();
  }

  //Appbar and search show - hide method
  void appbarVisibility() {
    isAppbarShow = !isAppbarShow;
    notifyListeners();
  }

  //Dropdown Value change method
  selectItemValue(value) {
    selectItem = value;
    notifyListeners();
  }

  //Method for remind email on add quote screen
  void isReminder() {
    isReminderCheck = !isReminderCheck;
    notifyListeners();
  }

  void isSelectTime() {
    isSetTime = !isSetTime;
    notifyListeners();
  }

  void isSelectPremisesType() {
    isSetPremises = !isSetPremises;
    notifyListeners();
  }

  void isSelectEngineers() {
    isSetEngineer = !isSetEngineer;
    notifyListeners();
  }
}
