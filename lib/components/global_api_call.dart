import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/constants.dart';
import '../constants/strings.dart';
import '../httpl_actions/app_http.dart';

//Calling API for fetch detail of single contact
Future<dynamic> getQuoteFields(String passElementType) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();

  Map<String, dynamic> queryParameters = {
    'operation': "describe",
    'sessionName':
        preferences.getString(PreferenceString.sessionName).toString(),
    'elementType': passElementType,
    'appversion': Constants.of().appversion
  };
  final response = await HttpActions()
      .getMethod(ApiEndPoint.getQuoteListApi, queryParams: queryParameters);
  debugPrint("getQuoteFieldsAPI --- $response");
  return response;
}

//Calling API for fetch detail of single contact
Future<dynamic> getContactDetail(contactId) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();

  Map<String, dynamic> queryParameters = {
    'operation': "retrieve",
    'sessionName':
        preferences.getString(PreferenceString.sessionName).toString(),
    'id': contactId.toString()
  };
  final response = await HttpActions()
      .getMethod(ApiEndPoint.getContactListApi, queryParams: queryParameters);

  debugPrint("getContactDetailApi --- $response");
  return response;
}

Future<dynamic> getItemFields(String? systemType, String mfg) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();

  if(mfg == 'noMfg'){
    Map<String, dynamic> queryParameters = {
      'operation': 'describe',
      'sessionName': preferences.getString(PreferenceString.sessionName).toString(),
      'elementType': "Products",
      'appversion': Constants.of().appversion,
      'systemtype': systemType.toString(),
    };
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
      'manufacturer': mfg.toString()
    };
    final response = await HttpActions().getMethod(ApiEndPoint.getItemDetailListApi, queryParams: queryParameters);
    debugPrint("getItemDetailsAPI --- $response");
    return response;
  }


}