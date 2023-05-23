import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../job_repository.dart';

part 'create_job_event.dart';
part 'create_job_state.dart';

class CreateJobBloc extends Bloc<CreateJobEvent, CreateJobState> {
  final JobRepository jobRepository;

  CreateJobBloc(this.jobRepository) : super(CreateJobInitial()) {
    on<CreateJobEvent>((event, emit) {});

    on<CreateJobDetailEvent>((event, emit) {
      return createJobDetail(event, emit);
    });

  }

  createJobDetail(CreateJobDetailEvent event, Emitter<CreateJobState> emit) async {
    emit(LoadingCreateJob(true));

    final response = await jobRepository.jobAdd(event.queryParameters);

    response.when(success: (success) {
      emit(LoadingCreateJob(false));
      emit(LoadedCreateJob(
          jobDetail: success.result,
          jobId: success.result?.id));
    }, failure: (failure) {
      emit(LoadingCreateJob(false));
      emit(FailCreateJob(error: failure.toString()));
    });
  }
}
