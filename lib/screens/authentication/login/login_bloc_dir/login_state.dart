part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {
  final bool isBusy;

  LoginLoading(this.isBusy);
}

// ignore: must_be_immutable
class LoginLoaded extends LoginState {
  String? sessionName;
  String? userId;
  String? userName;
  String? msg;

  LoginLoaded({this.sessionName, this.userId, this.userName, this.msg});
}

class LoginLoadFailure extends LoginState {
  final String? error;

  LoginLoadFailure({this.error});
}
