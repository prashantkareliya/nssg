
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nssg/screens/qoute/get_product/product_repository.dart';
import '../product_model_dir/get_product_response_model.dart';
import '../product_model_dir/get_sub_product_data.dart';

part 'get_product_event.dart';
part 'get_product_state.dart';

class GetProductBloc extends Bloc<GetProductEvent, GetProductState> {
  final ProductRepository productRepository;

  GetProductBloc(this.productRepository) : super(GetProductInitial()) {
    on<GetProductEvent>((event, emit) {});

    on<GetProductListEvent>((event, emit) {
      return getProductListEvent(event, emit);
    });

    on<GetSubProductListEvent>((event, emit) {
      return getSubProductListEvent(event, emit);
    });
  }

  getProductListEvent(GetProductListEvent event, Emitter<GetProductState> emit) async {
    emit(ProductLoadingState(true));

    final response = await productRepository.getProduct(event.queryParameters);

    response.when(success: (success){
      emit(ProductLoadingState(false));
      emit(ProductLoadedState(productList: success.result));
    }, failure: (failure){
      emit(ProductLoadingState(false));
      emit(ProductLoadedFail(error: failure.toString()));
    });
  }

  getSubProductListEvent(GetSubProductListEvent event, Emitter<GetProductState> emit) async {
    emit(ProductLoadingState(true));

    final response = await productRepository.getSubProduct(event.queryParameters);

    response.when(success: (success){
      emit(ProductLoadingState(false));
      emit(SubProductLoadedState(subProductList: success.result));
    }, failure: (failure){
      emit(ProductLoadingState(false));
      emit(ProductLoadedFail(error: failure.toString()));
    });
  }
}
