import 'package:flutter/material.dart';

class WidgetChange extends ChangeNotifier {
  bool isVisibleText = true;
  bool isAppbarShow = true;
  bool isReminderCheck = true;
  bool isSetTime = false;
  bool isSetPremises = false;
  bool isSetEngineer = false;
  bool isSetSystem = false;
  bool isSetGrade = false;
  bool isSetSignallingType = false;
  bool isQuotePayment = false;
  bool isTerms = false;
  bool isSelectTemplateOption = false;
  bool isSelectManufacture = false;
  bool isSelectSystemTypeItemDetail = false;
  bool isSelectCategoryItemDetail = false;
  bool isExpansionOne = false;
  bool isExpansionTwo = true;

  bool isDeposit = false;
  String isTermsBS = "";
  String pageNo = "";

  var count = 1;

  String? updateContactId;
  String? updateSearchText;

  int get getCounter => count;

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

  //select hours or day
  void isSelectTime() {
    isSetTime = !isSetTime;
    notifyListeners();
  }

  //For premises type radio button
  void isSelectPremisesType() {
    isSetPremises = !isSetPremises;
    notifyListeners();
  }

  //For select numbers of engineer
  void isSelectEngineers() {
    isSetEngineer = !isSetEngineer;
    notifyListeners();
  }

  //For select system type
  void isSelectSystemType() {
    isSetSystem = !isSetSystem;
    notifyListeners();
  }

  //For select Grade
  void isSelectGrade() {
    isSetGrade = !isSetGrade;
    notifyListeners();
  }

  //For select Signalling type
  void isSelectSignallingType() {
    isSetSignallingType = !isSetSignallingType;
    notifyListeners();
  }

  //For select payment type, deposit or not
  void isSelectQuotePayment() {
    isQuotePayment = !isQuotePayment;
    notifyListeners();
  }

  //For select terms
  void isSelectTerms() {
    isTerms = !isTerms;
    notifyListeners();
  }

  //For select Manufacture Type
  void isManufacture() {
    isSelectManufacture = !isSelectManufacture;
    notifyListeners();
  }

  //For select system type
  void isSystemTypeItemDetail() {
    isSelectSystemTypeItemDetail = !isSelectSystemTypeItemDetail;
    notifyListeners();
  }

  void isCategoryItemDetail() {
    isSelectCategoryItemDetail = !isSelectCategoryItemDetail;
    notifyListeners();
  }

  void isTemplateOption() {
    isSelectTemplateOption = !isSelectTemplateOption;
    notifyListeners();
  }

  //add item
  void incrementCounter() {
    count += 1;
    notifyListeners();
  }

  //remove item
  void decrementCounter() {
    count -= 1;
    notifyListeners();
  }

  //For quote detail's accordion design
  void isExpansionTileFirst(bool value) {
    isExpansionOne = value;
    notifyListeners();
  }

  //For quote detail's accordion design
  void isExpansionTileSecond(bool value) {
    isExpansionTwo = value;
    notifyListeners();
  }

  //save value in setContactId variable
  void updateContact(String id) {
    updateContactId = id;
    notifyListeners();
  }

  //For search in contact and quote listing page
  void updateSearch(String searchKey) {
    updateSearchText = searchKey;
    notifyListeners();
  }

  void isDepositAmount(bool value) {
    isDeposit = value;
    notifyListeners();
  }

  void isTermsSelect(String value) {
   isTermsBS = value;
    notifyListeners();
  }

  void pageNumber(String number) {
    pageNo = number;
    notifyListeners();
  }
}
