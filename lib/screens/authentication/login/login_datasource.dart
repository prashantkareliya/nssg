
import '../../../httpl_actions/app_http.dart';
import 'bloc/login_bloc.dart';

class LoginDataSource extends HttpActions {
  LoginDataSource(super.context);


  Future<dynamic> loginUser() async {
    LoginUserEvent? loginUserEvent;
    final response = await postMethodQueryParams(endPoint,
        queryParameters: loginUserEvent?.queryParameters);
    print("login $response");
    return response;
  }
}
