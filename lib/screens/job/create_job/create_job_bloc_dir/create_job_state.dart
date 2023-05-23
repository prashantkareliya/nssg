part of 'create_job_bloc.dart';

@immutable
abstract class CreateJobState {}

class CreateJobInitial extends CreateJobState {}

class LoadingCreateJob extends CreateJobState {
  final bool isBusy;

  LoadingCreateJob(this.isBusy);
}

class LoadedCreateJob extends CreateJobState {
  var jobDetail;
  final String? jobId;

  LoadedCreateJob(
      {this.jobDetail, this.jobId});
}

class FailCreateJob extends CreateJobState {
  final String? error;

  FailCreateJob({this.error});
}
