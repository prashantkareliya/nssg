
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../quote_repository.dart';
import '../quote_model_dir/get_quote_response_model.dart';

part 'get_quote_event.dart';

part 'get_quote_state.dart';

class GetQuoteBloc extends Bloc<GetQuoteEvent, GetQuoteState> {
  final QuoteRepository quoteRepository;
  GetQuoteBloc(this.quoteRepository) : super(GetQuoteInitial()) {
    on<GetQuoteEvent>((event, emit) {});

    on<GetQuoteListEvent>((event, emit) {
      return getQuoteListEvent(event, emit);
    });
  }

  getQuoteListEvent(GetQuoteListEvent event, Emitter<GetQuoteState> emit) async {
    emit(QuoteLoadingState(true));

    final response = await quoteRepository.getQuote(event.queryParameters);

    response.when(success: (success){
      emit(QuoteLoadingState(false));
      emit(QuoteLoadedState(quoteList: success.result));
    }, failure: (failure){
      emit(QuoteLoadingState(false));
      emit(QuoteLoadedFail(error: failure.toString()));
    });
  }
}
