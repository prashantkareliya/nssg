import 'package:nssg/screens/qoute/quote_datasource.dart';

import '../../constants/constants.dart';
import '../../httpl_actions/api_result.dart';
import '../../httpl_actions/handle_api_error.dart';
import 'get_quote/quote_model_dir/get_quote_response_model.dart';

class QuoteRepository {
  QuoteRepository({required QuoteDatasource quoteDatasource})
      : _quoteDatasource = quoteDatasource;

  final QuoteDatasource _quoteDatasource;

  Future<ApiResult<GetQuoteData>> getQuote(
      Map<String, dynamic> paraMeters) async {
    try {
      final result = await _quoteDatasource.getQuoteList(paraMeters);

      GetQuoteData getQuoteData = GetQuoteData.fromJson(result);

      if (getQuoteData.success.toString() == ResponseStatus.success) {
        return ApiResult.success(data: getQuoteData);
      } else {
        return ApiResult.failure(error: getQuoteData.error.toString());
      }
    } catch (e) {
      final message = HandleAPI.handleAPIError(e);
      return ApiResult.failure(error: message);
    }
  }
}
