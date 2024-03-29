part of 'add_quote_bloc.dart';

@immutable
abstract class AddQuoteState {}

class AddQuoteInitial extends AddQuoteState {}


class LoadingAddQuote extends AddQuoteState {
  final bool isBusy;
  LoadingAddQuote(this.isBusy);
}

class LoadedAddQuote extends AddQuoteState {
  final String? quoteDetail;
  LoadedAddQuote({this.quoteDetail});
}

class FailAddQuote extends AddQuoteState {
  final String? error;

  FailAddQuote({this.error});
}