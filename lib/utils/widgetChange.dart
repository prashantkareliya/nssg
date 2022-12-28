import 'package:flutter/material.dart';

class WidgetChange extends ChangeNotifier {
  bool isVisibleText = true;

  List<bool> showQty = [
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  //method for password visibility
  void textVisibility() {
    isVisibleText = !isVisibleText;
    notifyListeners();
  }

  //method for Edit-Delete button visibility
  void buttonVisibility(int index) {
    showQty[index] = !showQty[index];
    notifyListeners();
  }
}
