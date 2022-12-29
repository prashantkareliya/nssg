import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nssg/screens/contact/contact_model_dir/contact_response_model.dart';

import '../contact_data_dir/contact_repository.dart';

part 'get_contact_event.dart';

part 'get_contact_state.dart';

class GetContactBloc extends Bloc<GetContactEvent, GetContactState> {
  final ContactRepository contactRepository;

  GetContactBloc(this.contactRepository) : super(GetContactInitial()) {
    on<GetContactEvent>((event, emit) {});

    on<GetContactListEvent>((event, emit) {
      return getContactListEvent(event, emit);
    });
  }

  getContactListEvent(
      GetContactListEvent event, Emitter<GetContactState> emit) async {
    emit(ContactLoadingState(true));

    final response = await contactRepository.getContact(event.queryParameters);

    response.when(success: (success) {
      emit(ContactLoadingState(false));
      emit(ContactsLoaded(contactList: success.result));
    }, failure: (failure) {
      emit(ContactLoadingState(false));
      emit(ContactLoadFail(error: failure.toString()));
    });
  }
}
