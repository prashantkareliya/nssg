import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../models/products_list.dart';

part 'product_list_event.dart';
part 'product_list_state.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  ProductListBloc() : super(const ProductListState(productList: [])) {
    on<ProductListEvent>((event, emit) {});
    on<AddProductToListEvent>(_addNewProductToList);
    on<UpdateProductToListEvent>(_updateProductToList);
    on<ClearProductToListEvent>((event, emit) {
      emit(state.copyWith(productList: []));
    });
    on<DeleteProductToListEvent>(_deleteProductToList);

  }

  _addNewProductToList(
      AddProductToListEvent event, Emitter<ProductListState> emit) {
    List<ProductsList> products = state.productList.map((e) => ProductsList.fromJson(e.toJson()))
        .toList();
    products.add(event.productsList);
    emit(state.copyWith(productList: products));
  }

  FutureOr<void> _updateProductToList(UpdateProductToListEvent event, Emitter<ProductListState> emit) {
    List<ProductsList> products = state.productList.map((e) => ProductsList.fromJson(e.toJson())).toList();
    final int index = products.indexWhere((element) => element.itemId == event.productsList.itemId);
    products[index] = event.productsList;
    emit(state.copyWith(productList: products));
  }

  FutureOr<void> _deleteProductToList(DeleteProductToListEvent event, Emitter<ProductListState> emit) {
    List<ProductsList> products = state.productList.map((e) => ProductsList.fromJson(e.toJson())).toList();

    final int index = products.indexWhere((element) => element.itemId == event.productsList.itemId);
    products.removeAt(index);
    emit(state.copyWith(productList: products));
  }
}
