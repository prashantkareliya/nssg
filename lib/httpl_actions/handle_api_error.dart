import '../constants/strings.dart';

class HandleAPI {
  static String handleAPIError(e) {
    try {
      if (e.toString().contains(
          "type 'Null' is not a subtype of type 'Map<String, dynamic>'")) {
        return ErrorString.noInternet;
      }
      return e.toString();
    } catch (e) {
      return ErrorString.somethingWentWrong;
    }
  }
}
