import '../constants/strings.dart';

class HandleAPI {
  static String handleAPIError(e) {
    try {
      if (e.toString().contains(
          "(OS Error: No address associated with hostname, errno = 7)")) {
        return ErrorString.noInternet;
      }
      return e.toString();
    } catch (e) {
      return ErrorString.somethingWentWrong;
    }
  }
}
