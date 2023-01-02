import 'package:flutter/material.dart';

import '../../../../constants/constants.dart';
import '../../../../httpl_actions/app_http.dart';

class LoginDataSource extends HttpActions {

  Future<dynamic> loginUser(Map<String, dynamic> paraMeters) async {
    final response = await getMethod(ApiEndPoint.loginApi, queryParams: paraMeters);
    debugPrint("login $response");
    return response;
  }
}
