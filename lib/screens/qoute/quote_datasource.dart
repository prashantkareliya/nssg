import 'package:flutter/material.dart';
import 'package:nssg/httpl_actions/app_http.dart';

import '../../constants/constants.dart';

class QuoteDatasource extends HttpActions {
  Future<dynamic> getQuoteList(Map<String, dynamic> parameters) async {
    final response =
        await getMethod(ApiEndPoint.getQuoteListApi, queryParams: parameters);
    debugPrint("getQuoteListApi $response");
    return response;
  }

  Future<dynamic> createQuote(Map<String, dynamic> paraMeters) async {
    final response = await postMethodQueryParams(ApiEndPoint.getQuoteListApi, data: paraMeters);
    debugPrint("create Quote --- $response");
    return response;
  }
}
