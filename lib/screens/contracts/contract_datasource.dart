import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../httpl_actions/app_http.dart';

class ContractDataSource extends HttpActions {
  Future<dynamic> getContractList(Map<String, dynamic> paraMeters) async {
    final response =
    await getMethod(ApiEndPoint.mainApiEnd, queryParams: paraMeters);
    debugPrint("getContractListApi $response");
    return response;
  }
}
