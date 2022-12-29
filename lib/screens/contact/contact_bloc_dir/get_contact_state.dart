part of 'get_contact_bloc.dart';

@immutable
abstract class GetContactState {}

class GetContactInitial extends GetContactState {}

class ContactLoadingState extends GetContactState {
  final bool isBusy;

  ContactLoadingState(this.isBusy);
}

class ContactsLoaded extends GetContactState {
  final List<Result>? contactList;

  ContactsLoaded({this.contactList});
}

class ContactLoadFail extends GetContactState {
  final String? error;

  ContactLoadFail({this.error});
}

class HomePageError extends GetContactState {}
