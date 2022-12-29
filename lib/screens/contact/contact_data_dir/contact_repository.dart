import 'package:nssg/screens/contact/contact_data_dir/contact_datasource.dart';
import 'package:nssg/screens/contact/contact_model_dir/contact_response_model.dart';

import '../../../constants/constants.dart';
import '../../../httpl_actions/api_result.dart';
import '../../../httpl_actions/handle_api_error.dart';

class ContactRepository {
  ContactRepository({required ContactDataSource contactDataSource})
      : _contactDataSource = contactDataSource;

  final ContactDataSource _contactDataSource;

  Future<ApiResult<GetContactData>> getContact(
      Map<String, dynamic> paraMeters) async {
    try {
      final result = await _contactDataSource.getContactList(paraMeters);

      GetContactData getContactData = GetContactData.fromJson(result);

      if (getContactData.success.toString() == ResponseStatus.success) {
        return ApiResult.success(data: getContactData);
      } else {
        return ApiResult.failure(error: getContactData.success.toString());
      }
    } catch (e) {
      final message = HandleAPI.handleAPIError(e);
      return ApiResult.failure(error: message);
    }
  }
}
