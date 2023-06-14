import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../contracts/get_contract/contract_model_dir/get_contract_response_model.dart';
import '../../contract_repository.dart';

part 'get_contract_event.dart';
part 'get_contract_state.dart';

class GetContractBloc extends Bloc<GetContractEvent, GetContractState> {

  final ContractRepository contractRepository;


  GetContractBloc(this.contractRepository) : super(GetContractInitial()) {
    on<GetContractEvent>((event, emit) {});

    on<GetContractListEvent>((event, emit) {
      return getContractListEvent(event, emit);
    });
  }

  getContractListEvent(GetContractListEvent event, Emitter<GetContractState> emit) async {
    emit(ContractLoadingState(true));

    final response = await contractRepository.getContract(event.queryParameters);

    response.when(success: (success) {
      emit(ContractLoadingState(false));
      emit(ContractsLoaded(contractList: success.result));
    }, failure: (failure) {
      emit(ContractLoadingState(false));
      emit(ContractsLoadFail(error: failure.toString()));
    });
  }
}
