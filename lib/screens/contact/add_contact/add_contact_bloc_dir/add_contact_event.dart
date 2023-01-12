part of 'add_contact_bloc.dart';

@immutable
abstract class AddContactEvent {}

// ignore: must_be_immutable
class AddContactDetailEvent extends AddContactEvent {
  Map<String, dynamic> queryParameters;

  AddContactDetailEvent(this.queryParameters);
}


// ignore: must_be_immutable
class UpdateContactDetailEvent extends AddContactEvent {
  Map<String, dynamic> queryParameters;

  UpdateContactDetailEvent(this.queryParameters);
}



// ignore: must_be_immutable
class GetContactDetailEvent extends AddContactEvent {
  Map<String, dynamic> queryParameters;

  GetContactDetailEvent(this.queryParameters);
}
