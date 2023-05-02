import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
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
    on<RemoveProductFromCardByIdEvent>(_removeProductFromCardByIdEvent);
    on<UpdateProductQuantityByIdEvent>(_updateProductQuantityById);
  }

  _updateProductQuantityById(
      UpdateProductQuantityByIdEvent event, Emitter<ProductListState> emit) {
    List<ProductsList> products = state.productList.map((e) => ProductsList.fromJson(e.toJson())).toList();
    ProductsList? product = products.firstWhereOrNull((element) => element.productId == event.productId);

    if (product != null) {
      product.quantity = event.quantity;
      final index = products
          .indexWhere((element) => element.productId == event.productId);
      if (index > -1) {
        products[index] = product;
      }
      emit(state.copyWith(productList: products));
    }
  }

  _removeProductFromCardByIdEvent(
      RemoveProductFromCardByIdEvent event, Emitter<ProductListState> emit) {
    List<ProductsList> products = state.productList
        .map((e) => ProductsList.fromJson(e.toJson())).toList();
    products.removeWhere((element) => element.productId == event.productId);
    emit(state.copyWith(productList: products));
  }

  _addNewProductToList(
      AddProductToListEvent event, Emitter<ProductListState> emit) {
    List<ProductsList> products = state.productList.map((e) => ProductsList.fromJson(e.toJson())).toList();
    products.add(event.productsList);
    emit(state.copyWith(productList: products));
  }

  FutureOr<void> _updateProductToList(
      UpdateProductToListEvent event, Emitter<ProductListState> emit) {

    List<ProductsList> products = state.productList.map((e) => ProductsList.fromJson(e.toJson())).toList();
    final int index = products
        .indexWhere((element) => element.itemId == event.productsList.itemId);
    products[index] = event.productsList;
    emit(state.copyWith(productList: products));
  }

  FutureOr<void> _deleteProductToList(
      DeleteProductToListEvent event, Emitter<ProductListState> emit) {
    List<ProductsList> products = state.productList.map((e) => ProductsList.fromJson(e.toJson())).toList();
    final int index = products
        .indexWhere((element) => element.itemId == event.productsList.itemId);
    products.removeAt(index);
    emit(state.copyWith(productList: products));
  }
}
