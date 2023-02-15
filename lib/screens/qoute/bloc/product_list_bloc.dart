import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nssg/screens/qoute/models/products_list.dart';

part 'product_list_event.dart';
part 'product_list_state.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  ProductListBloc() : super(const ProductListState(productList: [])) {
    on<ProductListEvent>((event, emit) {});
    on<AddProductToListEvent>(_addNewProductToList);
  }

  _addNewProductToList(
      AddProductToListEvent event, Emitter<ProductListState> emit) {
    List<ProductsList> products = state.productList.map((e) => ProductsList.fromJson(e.toJson()))
        .toList();
    products.add(event.productsList);
    emit(state.copyWith(productList: products));
  }
}
