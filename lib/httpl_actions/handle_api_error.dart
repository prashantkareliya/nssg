import '../constants/strings.dart';
import 'package:restart_app/restart_app.dart';


class HandleAPI {
  static String handleAPIError(e) {
    try {
      if (e.toString().contains(
          "type 'Null' is not a subtype of type 'Map<String, dynamic>'")) {
        return ErrorString.noInternet;
      }else if(e.toString().contains("type '(dynamic) => Null' is not a subtype of type '(String, dynamic) => void' of 'action'")){
        Restart.restartApp();
        return ErrorString.reOpenTheApp;
      }
      return e.toString();
    } catch (e) {
      return ErrorString.somethingWentWrong;
    }
  }
}
