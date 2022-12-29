import '../../../../constants/constants.dart';
import '../../../../httpl_actions/api_result.dart';
import '../../../../httpl_actions/handle_api_error.dart';
import '../login_models_dir/response_login_model.dart';
import 'login_datasource.dart';

class LoginRepository {
  LoginRepository({
    required LoginDataSource authDataSource,
  }) : _authDataSource = authDataSource;

  final LoginDataSource _authDataSource;

  Future<ApiResult<UserData>> loginUser(Map<String, dynamic> paraMeters) async {
    try {
      final result = await _authDataSource.loginUser(paraMeters);

      UserData userData = UserData.fromJson(result);

      if (userData.success.toString() == ResponseStatus.success) {
        return ApiResult.success(data: userData);
      } else {
        return ApiResult.failure(error: userData.msg.toString());
      }
    } catch (e) {
      final message = HandleAPI.handleAPIError(e);
      return ApiResult.failure(error: message);
    }
  }
}
