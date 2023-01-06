import 'package:nssg/screens/contact/contact_datasource.dart';

import '../../constants/constants.dart';
import '../../httpl_actions/api_result.dart';
import '../../httpl_actions/handle_api_error.dart';
import 'add_contact/add_contact_model_dir/add_contact_response_model.dart';
import 'get_contact/contact_model_dir/contact_detail_response.dart';
import 'get_contact/contact_model_dir/get_contact_response_model.dart';
import 'get_contact/contact_model_dir/delete_contact_response_model.dart';

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

  Future<ApiResult<AddContactDetailResponse>> contactAdd(
      Map<String, dynamic> paraMeters) async {
    try {
      final result = await _contactDataSource.createContact(paraMeters);

      AddContactDetailResponse addContactDetailResponse =
      AddContactDetailResponse.fromJson(result);

      if (addContactDetailResponse.success.toString() == ResponseStatus.success) {
        return ApiResult.success(data: addContactDetailResponse);
      } else {
        return ApiResult.failure(
            error: addContactDetailResponse.success.toString());
      }
    } catch (e) {
      final message = HandleAPI.handleAPIError(e);
      return ApiResult.failure(error: message);
    }
  }

  Future<ApiResult<DeleteContactResponse>> contactDelete(
      Map<String, dynamic> paraMeters) async {
    try {
      final result = await _contactDataSource.deleteContact(paraMeters);

      DeleteContactResponse deleteContactResponse = DeleteContactResponse.fromJson(result);

      if (deleteContactResponse.success.toString() == ResponseStatus.success) {
        return ApiResult.success(data: deleteContactResponse);
      } else {
        return ApiResult.failure(
            error: deleteContactResponse.success.toString());
      }
    } catch (e) {
      final message = HandleAPI.handleAPIError(e);
      return ApiResult.failure(error: message);
    }
  }

  Future<ApiResult<ContactDetail>> retrieveContact(
      Map<String, dynamic> paraMeters) async {
    try {
      final result = await _contactDataSource.getContactDetail(paraMeters);

      ContactDetail contactDetail = ContactDetail.fromJson(result);

      if (contactDetail.success.toString() == ResponseStatus.success) {
        return ApiResult.success(data: contactDetail);
      } else {
        return ApiResult.failure(error: contactDetail.success.toString());
      }
    } catch (e) {
      final message = HandleAPI.handleAPIError(e);
      return ApiResult.failure(error: message);
    }
  }


  Future<ApiResult<AddContactDetailResponse>> updateContact(
      Map<String, dynamic> paraMeters) async {
    try {
      final result = await _contactDataSource.updateContactDetail(paraMeters);

      AddContactDetailResponse addContactDetailResponse = AddContactDetailResponse.fromJson(result);

      if (addContactDetailResponse.success.toString() == ResponseStatus.success) {
        return ApiResult.success(data: addContactDetailResponse);
      } else {
        return ApiResult.failure(error: addContactDetailResponse.success.toString());
      }
    } catch (e) {
      final message = HandleAPI.handleAPIError(e);
      return ApiResult.failure(error: message);
    }
  }
}
