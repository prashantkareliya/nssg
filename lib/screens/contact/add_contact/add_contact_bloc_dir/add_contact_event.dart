part of 'add_contact_bloc.dart';

@immutable
abstract class AddContactEvent {}

// ignore: must_be_immutable
class AddContactDetailEvent extends AddContactEvent {
  Map<String, dynamic> queryParameters;

  AddContactDetailEvent(this.queryParameters);
}
