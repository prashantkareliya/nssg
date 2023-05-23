part of 'create_job_bloc.dart';

@immutable
abstract class CreateJobEvent {}

// ignore: must_be_immutable
class CreateJobDetailEvent extends CreateJobEvent {
  Map<String, dynamic> queryParameters;

  CreateJobDetailEvent(this.queryParameters);
}