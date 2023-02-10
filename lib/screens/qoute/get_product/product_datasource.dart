
import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../httpl_actions/app_http.dart';

class ProductDatasource extends HttpActions {
  Future<dynamic> getProductList(Map<String, dynamic> parameters) async {
    final response = await getMethod(ApiEndPoint.getProductListApi, queryParams: parameters);
    debugPrint("getProductListApi $response");
    return response;
  }
}