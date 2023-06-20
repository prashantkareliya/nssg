part of 'get_contract_bloc.dart';

@immutable
abstract class GetContractEvent {}

// ignore: must_be_immutable
class GetContractListEvent extends GetContractEvent {
  Map<String, dynamic> queryParameters;
  GetContractListEvent(this.queryParameters);
}
