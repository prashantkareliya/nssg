part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {
  final bool isBusy;

  LoginLoading(this.isBusy);
}

class LoginLoaded extends LoginState {
  String? sessionName;
  String? userId;
  String? Username;
  String? msg;

  LoginLoaded({this.sessionName, this.userId, this.Username, this.msg});
}

class LoginLoadFailure extends LoginState {
  final String? error;

  LoginLoadFailure({this.error});
}

class HomepageError extends LoginState {}
