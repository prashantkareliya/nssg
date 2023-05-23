import 'package:flutter/material.dart';
import 'package:nssg/httpl_actions/app_http.dart';

import '../../constants/constants.dart';

class JobDataSource extends HttpActions {

  Future<dynamic> createJob(Map<String, dynamic> paraMeters) async {
    final response = await  postMethod(ApiEndPoint.mainApiEnd, data: paraMeters);
    debugPrint("job create API response --- $response");
    return response;
  }
}