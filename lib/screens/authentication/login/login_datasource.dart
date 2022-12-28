import 'package:nssg/screens/authentication/login/models/request_login_model.dart';

import '../../../httpl_actions/app_http.dart';

class LoginDataSource extends HttpActions {

  Future<dynamic> loginUser() async {


    final response = await postMethodQueryParams();
    print("login $response");
    return response;
  }
}
