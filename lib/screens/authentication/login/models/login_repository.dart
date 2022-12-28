import 'package:nssg/screens/authentication/login/login_datasource.dart';
import 'package:nssg/screens/authentication/login/models/response_login_model.dart';

import '../../../../constants/constants.dart';
import '../../../../httpl_actions/api_result.dart';
import '../../../../httpl_actions/handle_api_error.dart';

class LoginRepository {


  LoginDataSource? _authDataSource;

  Future<ApiResult<UserData>> loginUser() async {
    try {
      final result =
          await _authDataSource?.loginUser();

      UserData userData = UserData.fromJson(result as Map<String, dynamic>);

      if (userData.status == ResponseStatus.success) {
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
