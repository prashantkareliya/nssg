import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../login_data_dir/login_repository.dart';

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
          sessionName: success.result!.sessionName.toString(),
          userId: success.result!.userId.toString(),
          Username: success.result!.username.toString(),
          msg: success.msg.toString()));
    }, failure: (failure) {
      emit(LoginLoading(false));
      emit(LoginLoadFailure(error: failure.toString()));
    });
  }
}
