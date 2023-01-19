part of 'get_quote_bloc.dart';

@immutable
abstract class GetQuoteState {}

class GetQuoteInitial extends GetQuoteState {}

class QuoteLoadingState extends GetQuoteState{
  final bool isBusy;
  QuoteLoadingState(this.isBusy);
}

class QuoteLoadedState extends GetQuoteState{
  final List<Result>? quoteList;
  QuoteLoadedState({this.quoteList});
}

class QuoteLoadedFail extends GetQuoteState{
  final String? error;
  QuoteLoadedFail({this.error});
}

