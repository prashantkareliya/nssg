import 'package:nssg/screens/qoute/get_product/product_datasource.dart';
import 'package:nssg/screens/qoute/get_product/product_model_dir/get_product_response_model.dart';

import '../../../constants/constants.dart';
import '../../../httpl_actions/api_result.dart';
import '../../../httpl_actions/handle_api_error.dart';
import 'product_model_dir/get_sub_product_data.dart';

class ProductRepository {
  ProductRepository({required ProductDatasource productDatasource})
      : _quoteDatasource = productDatasource;

  final ProductDatasource _quoteDatasource;

  Future<ApiResult<GetProductData>> getProduct(Map<String, dynamic> paraMeters) async {
    try {
      final result = await _quoteDatasource.getProductList(paraMeters);

      GetProductData getProductData = GetProductData.fromJson(result);

      if (getProductData.success.toString() == ResponseStatus.success) {
        return ApiResult.success(data: getProductData);
      } else {
        return ApiResult.failure(error: getProductData.toString());
      }
    } catch (e) {
      final message = HandleAPI.handleAPIError(e);
      return ApiResult.failure(error: message);
    }
  }

  Future<ApiResult<GetSubProductData>> getSubProduct(Map<String, dynamic> paraMeters) async {
    try {
      final result = await _quoteDatasource.getSubProductList(paraMeters);

      GetSubProductData getSubProductData = GetSubProductData.fromJson(result);

      if (getSubProductData.success.toString() == ResponseStatus.success) {
        return ApiResult.success(data: getSubProductData);
      } else {
        return ApiResult.failure(error: getSubProductData.toString());
      }
    } catch (e) {
      final message = HandleAPI.handleAPIError(e);
      return ApiResult.failure(error: message);
    }
  }
}