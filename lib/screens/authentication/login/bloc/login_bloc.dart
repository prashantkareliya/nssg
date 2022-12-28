import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nssg/screens/authentication/login/models/login_repository.dart';

import '../models/request_login_model.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository loginRepository;

  LoginBloc(this.loginRepository) : super(LoginInitial()) {
    on<LoginEvent>((event, emit) {});

    on<LoginUserEvent>((event, emit) {
      return loginUserEvent(event, emit);
    });
  }

  loginUserEvent(LoginUserEvent event, emit) async {
    emit(LoginLoading(true));

    final response = await loginRepository.loginUser(event.queryParameters);

    response.when(success: (success) {
      emit(LoginLoading(false));
      emit(LoginLoaded(
          userData: success.result.toString(),
          ));
    }, failure: (failure) {
      emit(LoginLoading(false));
      emit(LoginLoadFailure(failure.toString()));
    });
  }
}
