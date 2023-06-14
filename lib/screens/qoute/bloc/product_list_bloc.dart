import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:meta/meta.dart';
import 'package:nssg/utils/extention_text.dart';

import '../get_product/product_model_dir/get_sub_product_data.dart';
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
    on<ChangeProductOrderEvent>(_changeListOrder);
    on<UpdateEditProductListEvent>((event, emit) {
      emit(state.copyWith(productList: event.productsList));
    });
    on<AddSubProductListEvent>(_addSubProductToList);
  }

  _changeListOrder(
      ChangeProductOrderEvent event, Emitter<ProductListState> emit) {
    int oldindex = event.oldIndex, newindex = event.newIndex;
    List<ProductsList> products = state.productList
        .map((e) => ProductsList.fromJson(e.toJson()))
        .toList();

    if (newindex > oldindex) {
      newindex -= 1;
    }
    final items = products.removeAt(oldindex);
    products.insert(newindex, items);

    emit(state.copyWith(productList: products));
  }

  _updateProductQuantityById(
      UpdateProductQuantityByIdEvent event, Emitter<ProductListState> emit) {
    List<ProductsList> products = state.productList
        .map((e) => ProductsList.fromJson(e.toJson()))
        .toList();
    ProductsList? product = products
        .firstWhereOrNull((element) => element.productId == event.productId);

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
        .map((e) => ProductsList.fromJson(e.toJson()))
        .toList();
    products.removeWhere((element) => element.productId == event.productId);
    emit(state.copyWith(productList: products));
  }

  _addNewProductToList(
      AddProductToListEvent event, Emitter<ProductListState> emit) {
    List<ProductsList> products = state.productList
        .map((e) => ProductsList.fromJson(e.toJson()))
        .toList();
    products.add(event.productsList);
    emit(state.copyWith(productList: products));
  }

  FutureOr<void> _updateProductToList(
      UpdateProductToListEvent event, Emitter<ProductListState> emit) {
    List<ProductsList> products = state.productList
        .map((e) => ProductsList.fromJson(e.toJson())).toList();
    final int index = products.indexWhere((element) => element.itemId == event.productsList.itemId);
    ///products.length-1;
    print(index);
    if (index == -1) {
      final int index = products.length - 1;
      for (int i = 0; i <= products.length; i++) {
        if (products[i].itemName!.contains("Installation")) {
          products[i] = event.productsList;
          emit(state.copyWith(productList: products));
          break;
        }
      }
    } else {
      products[index] = event.productsList;
      emit(state.copyWith(productList: products));
    }
  }

  FutureOr<void> _deleteProductToList(
    DeleteProductToListEvent event, Emitter<ProductListState> emit) {
    List<ProductsList> products = state.productList.map((e) => ProductsList.fromJson(e.toJson())).toList();
    final int index = products.indexWhere((element) => element.itemId == event.productsList.itemId);
    products.removeAt(index);
    emit(state.copyWith(productList: products));
  }

  _addSubProductToList(
      AddSubProductListEvent event, Emitter<ProductListState> emit) {
    List<ProductsList> products = state.productList.map((e) =>
        ProductsList.fromJson(e.toJson())).toList();
    products.addAll(event.subProductList!.map((e) => ProductsList(
        itemId: DateTime.now().millisecondsSinceEpoch.toString(),
        productId: e.id.toString(),
        itemName: e.productname.toString(),
        costPrice: e.costPrice.toString(),
        sellingPrice: e.unitPrice,
        discountPrice:  "0",
        amountPrice: (double.parse(e.unitPrice.toString()) * double.parse("1.0")).toString(),
        profit: (double.parse(e.unitPrice!) - double.parse(e.costPrice!)).formatAmount(),


        quantity: 1,
        description: e.description,
        //selectLocation: (filterList![index].locationList ?? []).join('###'),
        //titleLocation: (filterList![index].titleLocationList ?? []).join("###"),
        //itemAdd: e.isItemAdded,
        //productImage: filterList![index].imagename,
        //requiredDocument: (documentType).join('###'),
        productTitle: e.productsTitle)).toList()
    );
    emit(state.copyWith(productList: products));
  }
}
