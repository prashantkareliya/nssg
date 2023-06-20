import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/constants.dart';
import '../constants/strings.dart';
import '../httpl_actions/app_http.dart';

//Calling API for fetch detail of single contact
Future<dynamic> getQuoteFields(String passElementType, BuildContext context) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();

  Map<String, dynamic> queryParameters = {
    'operation': "describe",
    'sessionName': preferences.getString(PreferenceString.sessionName).toString(),
    'elementType': passElementType,
    'appversion': Constants.of().appversion};

  final response = await HttpActions().getMethod(ApiEndPoint.getQuoteListApi, queryParams: queryParameters);
  debugPrint("getQuoteFieldsAPI --- $response");
  if(response["success"] == false){
    Navigator.pushNamedAndRemoveUntil(context,'/',(_) => false);
  }
  return response;
}

//Calling API for fetch detail of single contact
Future<dynamic> getContactDetail(contactId, BuildContext context) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();

  Map<String, dynamic> queryParameters = {
    'operation': "retrieve",
    'sessionName': preferences.getString(PreferenceString.sessionName).toString(),
    'id': contactId.toString()};

  final response = await HttpActions() .getMethod(ApiEndPoint.getContactListApi, queryParams: queryParameters);
  debugPrint("getContactDetailApi --- $response");
  if(response["success"] == false){
    Navigator.pushNamedAndRemoveUntil(context,'/',(_) => false);
  }
  return response;
}


Future<dynamic> getItemFields(String? systemType, String manufactureSelect) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();

  if(manufactureSelect == 'noMfg'){
    Map<String, dynamic> queryParameters = {
      'operation': 'describe',
      'sessionName': preferences.getString(PreferenceString.sessionName).toString(),
      'elementType': "Products",
      'appversion': Constants.of().appversion,
      'systemtype': systemType.toString()};

    final response = await HttpActions().getMethod(ApiEndPoint.getItemDetailListApi, queryParams: queryParameters);
    debugPrint("getItemDetailsAPI --- $response");
    return response;
  }else{
    Map<String, dynamic> queryParameters = {
      'operation': 'describe',
      'sessionName': preferences.getString(PreferenceString.sessionName).toString(),
      'elementType': "Products",
      'appversion': Constants.of().appversion,
      'systemtype': systemType.toString(),
      'manufacturer': manufactureSelect.toString().replaceAll("&", "%26")
    };
    final response = await HttpActions().getMethod(ApiEndPoint.getItemDetailListApi, queryParams: queryParameters);
    debugPrint("getItemDetailsAPI --- $response");
    return response;
  }
}

Future<dynamic> getData() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  Map<String, dynamic> queryParameters = {
    'operation': "query",
    'sessionName': preferences.getString(PreferenceString.sessionName).toString(),
    'query': Constants.of().apiKeyContract,
    'module_name': "ServiceContracts"};
  final response = await HttpActions().getMethod(ApiEndPoint.mainApiEnd, queryParams: queryParameters);
  debugPrint("get Contract Detail Api --- $response");

  return response;
}