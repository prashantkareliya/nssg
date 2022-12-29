import 'package:nssg/httpl_actions/app_http.dart';

import '../../../constants/constants.dart';

class ContactDataSource extends HttpActions {

  Future<dynamic> getContactList(Map<String, dynamic> paraMeters) async {
    final response =
        await getMethod(ApiEndPoint.getContactListApi, queryParams: paraMeters);
    print("getContactListApi $response");
    return response;
  }
}
