
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../contact_repository.dart';
import '../contact_model_dir/contact_response_model.dart';

part 'get_contact_event.dart';
part 'get_contact_state.dart';

class GetContactBloc extends Bloc<GetContactEvent, GetContactState> {
  final ContactRepository contactRepository;

  GetContactBloc(this.contactRepository) : super(GetContactInitial()) {
    on<GetContactEvent>((event, emit) {});

    on<GetContactListEvent>((event, emit) {
      return getContactListEvent(event, emit);
    });

    on<DeleteContactEvent>((event, emit) {
      return deleteContactEvent(event, emit);
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

   deleteContactEvent(DeleteContactEvent event, Emitter<GetContactState> emit) async {
     final response = await contactRepository.contactDelete(event.queryParameters);

     response.when(success: (success) {
       emit(ContactLoadingState(false));
       emit(DeleteContact(message: success.result!.status.toString()));
     }, failure: (failure) {
       emit(ContactLoadingState(false));
       emit(ContactLoadFail(error: failure.toString()));
     });
   }
}
