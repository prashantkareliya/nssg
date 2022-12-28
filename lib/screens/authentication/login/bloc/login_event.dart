part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

// ignore: must_be_immutable
class LoginUserEvent extends LoginEvent {
  Map<String, dynamic> queryParameters;

  LoginUserEvent(this.queryParameters);

/*final LoginRequest loginRequest;
  LoginUserEvent(this.loginRequest);*/

}
