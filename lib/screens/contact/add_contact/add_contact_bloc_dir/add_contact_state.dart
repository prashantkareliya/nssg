part of 'add_contact_bloc.dart';

@immutable
abstract class AddContactState {}

class AddContactInitial extends AddContactState {}

class LoadingAddContact extends AddContactState {
  final bool isBusy;

  LoadingAddContact(this.isBusy);
}

class LoadedAddContact extends AddContactState {
  var contactDetail;
  final bool isPositive;
  final String? contactId;

  LoadedAddContact(
      {this.contactDetail, required this.isPositive, this.contactId});
}

class FailAddContact extends AddContactState {
  final String? error;

  FailAddContact({this.error});
}

class UpdatedContactData extends AddContactState {
  final String? updateContactDetail;

  UpdatedContactData({this.updateContactDetail});
}

// ignore: must_be_immutable
class GetContactData extends AddContactState {
  var contactData;

  GetContactData({this.contactData});
}
