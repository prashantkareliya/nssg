part of 'add_quote_bloc.dart';

@immutable
abstract class AddQuoteEvent {}

// ignore: must_be_immutable
class AddQuoteDetailEvent extends AddQuoteEvent {
  Map<String, String> bodyData;

  AddQuoteDetailEvent(this.bodyData);
}
