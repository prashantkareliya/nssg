import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../contact_repository.dart';

part 'add_contact_event.dart';
part 'add_contact_state.dart';

class AddContactBloc extends Bloc<AddContactEvent, AddContactState> {
  final ContactRepository contactRepository;

  AddContactBloc(this.contactRepository) : super(AddContactInitial()) {
    on<AddContactEvent>((event, emit) {});

    on<AddContactDetailEvent>((event, emit) {
      return addContactDetail(event, emit);
    });

    on<UpdateContactDetailEvent>((event, emit) {
      return updateContactDetail(event, emit);
    });

    on<GetContactDetailEvent>((event, emit) {
      return getContactData(event, emit);
    });
  }

  addContactDetail(
      AddContactDetailEvent event, Emitter<AddContactState> emit) async {
    emit(LoadingAddContact(true));

    final response = await contactRepository.contactAdd(event.queryParameters);

    response.when(success: (success) {
      emit(LoadingAddContact(false));
      emit(LoadedAddContact(
          contactDetail: success.result,
          isPositive: event.isPositive,
          contactId: success.result?.id));
    }, failure: (failure) {
      emit(LoadingAddContact(false));
      emit(FailAddContact(error: failure.toString()));
    });
  }

  updateContactDetail(
      UpdateContactDetailEvent event, Emitter<AddContactState> emit) async {
    emit(LoadingAddContact(true));

    final response =
        await contactRepository.updateContact(event.queryParameters);

    response.when(success: (success) {
      emit(LoadingAddContact(false));
      emit(UpdatedContactData(updateContactDetail: success.success.toString()));
    }, failure: (failure) {
      emit(LoadingAddContact(false));
      emit(FailAddContact(error: failure.toString()));
    });
  }

  getContactData(
      GetContactDetailEvent event, Emitter<AddContactState> emit) async {
    emit(LoadingAddContact(true));

    final response =
        await contactRepository.retrieveContact(event.queryParameters);

    response.when(success: (success) {
      emit(LoadingAddContact(false));
      emit(GetContactData(contactData: success.result));
    }, failure: (failure) {
      emit(LoadingAddContact(false));
      emit(FailAddContact(error: failure.toString()));
    });
  }
}
