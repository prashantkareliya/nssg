
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../quote_repository.dart';

part 'add_quote_event.dart';
part 'add_quote_state.dart';

class AddQuoteBloc extends Bloc<AddQuoteEvent, AddQuoteState> {
  final QuoteRepository quoteRepository;
  AddQuoteBloc(this.quoteRepository) : super(AddQuoteInitial()) {
    on<AddQuoteEvent>((event, emit) {});

    on<AddQuoteDetailEvent>((event, emit) {
      return addQuoteDetail(event, emit);
    });
  }

  addQuoteDetail(AddQuoteDetailEvent event, Emitter<AddQuoteState> emit) async {

    emit(LoadingAddQuote(true));
    final response = await quoteRepository.quoteAdd(event.bodyData);
    response.when(success: (success) {

      emit(LoadingAddQuote(false));

    emit(LoadedAddQuote(quoteDetail: success.result.toString(),
        quoteId: success.result!.id.toString()));
    },
        failure: (failure) {
    emit(LoadingAddQuote(false));
    emit(FailAddQuote(error: failure.toString()));
    });
  }
}
