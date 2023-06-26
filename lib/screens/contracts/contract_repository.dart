import '../../constants/constants.dart';
import '../../httpl_actions/api_result.dart';
import '../../httpl_actions/handle_api_error.dart';
import '../contact/add_contact/add_contact_bloc_dir/add_contact_bloc.dart';
import 'contract_datasource.dart';
import 'get_contract/contract_model_dir/get_contract_response_model.dart';

class ContractRepository {
  ContractRepository({required ContractDataSource contractDataSource})
      : _contractDataSource = contractDataSource;

  final ContractDataSource _contractDataSource;

  Future<ApiResult<GetContractData>> getContract(Map<String, dynamic> paraMeters) async {
    try {
      final result = await _contractDataSource.getContractList(paraMeters);

      GetContractData getContractData = GetContractData.fromJson(result);

      if (getContractData.success.toString() == ResponseStatus.success) {
        return ApiResult.success(data: getContractData);
      } else {
        return ApiResult.failure(error: getContractData.success.toString());
      }
    } catch (e) {
      final message = HandleAPI.handleAPIError(e);
      return ApiResult.failure(error: message);
    }
  }
}
