part of 'get_contact_bloc.dart';

@immutable
abstract class GetContactEvent {}

// ignore: must_be_immutable
class GetContactListEvent extends GetContactEvent {
  Map<String, dynamic> queryParameters;

  GetContactListEvent(this.queryParameters);
}

// ignore: must_be_immutable
class DeleteContactEvent extends GetContactEvent {
  Map<String, dynamic> queryParameters;

  DeleteContactEvent(this.queryParameters);
}
