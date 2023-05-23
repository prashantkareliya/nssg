import '../../constants/constants.dart';
import '../../httpl_actions/api_result.dart';
import '../../httpl_actions/handle_api_error.dart';
import 'create_job/models/add_job_response_model.dart';
import 'job_datasource.dart';

class JobRepository {
  JobRepository({required JobDataSource jobDataSource})
      : _jobDataSource = jobDataSource;
  final JobDataSource _jobDataSource;

  Future<ApiResult<CreateJobResponse>> jobAdd(Map<String, dynamic> paraMeters) async {

  //  try {
      final result = await _jobDataSource.createJob(paraMeters);

      CreateJobResponse createJobResponse = CreateJobResponse.fromJson(result);

      if (createJobResponse.success.toString() == ResponseStatus.success) {
        return ApiResult.success(data: createJobResponse);
      } else {
        return ApiResult.failure(error: createJobResponse.success.toString());
      }
   /* } catch (e) {
      final message = HandleAPI.handleAPIError(e);
      return ApiResult.failure(error: message);
    }*/
  }
}