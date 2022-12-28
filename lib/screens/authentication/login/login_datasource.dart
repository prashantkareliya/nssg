import 'package:http/http.dart';
import 'package:nssg/screens/authentication/login/models/request_login_model.dart';

import '../../../constants/constants.dart';
import '../../../httpl_actions/app_http.dart';

class LoginDataSource extends HttpActions {

  Future<dynamic> loginUser(Map<String, dynamic> paraMeters) async {
    final response = await getMethod(ApiEndPoint.loginApi, queryParams: paraMeters);
    print("login $response");
    return response;
  }
}
