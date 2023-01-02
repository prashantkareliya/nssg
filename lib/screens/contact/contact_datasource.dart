import 'package:flutter/material.dart';
import 'package:nssg/httpl_actions/app_http.dart';

import '../../constants/constants.dart';

class ContactDataSource extends HttpActions {

  Future<dynamic> getContactList(Map<String, dynamic> paraMeters) async {
    final response =
        await getMethod(ApiEndPoint.getContactListApi, queryParams: paraMeters);
    debugPrint("getContactListApi $response");
    return response;
  }

  Future<dynamic> createContact(Map<String, dynamic> paraMeters) async {
    final response = await postMethod(ApiEndPoint.getContactListApi, queryParams: paraMeters);
    debugPrint("getContactListApi --- $response");
    return response;
  }

  Future<dynamic> deleteContact(Map<String, dynamic> paraMeters) async {
    final response = await postMethod(ApiEndPoint.getContactListApi, queryParams: paraMeters);
    debugPrint("deleteContactListApi --- $response");
    return response;
  }
}
