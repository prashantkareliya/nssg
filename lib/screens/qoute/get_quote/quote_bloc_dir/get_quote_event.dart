part of 'get_quote_bloc.dart';

@immutable
abstract class GetQuoteEvent {}

class GetQuoteListEvent extends GetQuoteEvent {
  Map<String, dynamic> queryParameters;

  GetQuoteListEvent(this.queryParameters);
}

