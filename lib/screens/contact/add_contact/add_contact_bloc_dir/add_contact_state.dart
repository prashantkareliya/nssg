part of 'add_contact_bloc.dart';

@immutable
abstract class AddContactState {}

class AddContactInitial extends AddContactState {}

class LoadingAddContact extends AddContactState {
  final bool isBusy;

  LoadingAddContact(this.isBusy);
}

class LoadedAddContact extends AddContactState {
  final String? contactDetail;

  LoadedAddContact({this.contactDetail});
}

class FailAddContact extends AddContactState {
  final String? error;

  FailAddContact({this.error});
}
