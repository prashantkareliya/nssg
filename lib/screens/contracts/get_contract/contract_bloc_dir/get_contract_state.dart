part of 'get_contract_bloc.dart';

@immutable
abstract class GetContractState {}

class GetContractInitial extends GetContractState {}

class ContractLoadingState extends GetContractState {
  final bool isBusy;
  ContractLoadingState(this.isBusy);
}

class ContractsLoaded extends GetContractState {
  final List<Result>? contractList;
  ContractsLoaded({this.contractList});
}

class ContractsLoadFail extends GetContractState {
  final String? error;
  ContractsLoadFail({this.error});
}
