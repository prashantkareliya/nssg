import 'package:nssg/screens/authentication/login/login_datasource.dart';
import 'package:nssg/screens/authentication/login/models/response_login_model.dart';

import '../../../../constants/constants.dart';
import '../../../../httpl_actions/api_result.dart';
import '../../../../httpl_actions/handle_api_error.dart';

class LoginRepository {

  LoginRepository({
    required LoginDataSource authDataSource,
  }) : _authDataSource = authDataSource;

  final LoginDataSource _authDataSource;

  Future<ApiResult<UserData>> loginUser(Map<String, dynamic> paraMeters) async {

      final result =
      await _authDataSource.loginUser(paraMeters);

      UserData userData = UserData.fromJson(result);

      if (userData.status == ResponseStatus.success) {
        return ApiResult.success(data: userData);
      } else {
        return ApiResult.failure(error: userData.msg.toString());
      }

  }
}
