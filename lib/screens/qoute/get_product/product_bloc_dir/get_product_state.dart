part of 'get_product_bloc.dart';

@immutable
abstract class GetProductState {}

class GetProductInitial extends GetProductState {}

class ProductLoadingState extends GetProductState {
  final bool isBusy;

  ProductLoadingState(this.isBusy);
}

class ProductLoadedState extends GetProductState {
  final List<Result>? productList;

  ProductLoadedState({this.productList});
}

class SubProductLoadedState extends GetProductState {
  final List<SubProductResult>? subProductList;

  SubProductLoadedState({this.subProductList});
}

class ProductLoadedFail extends GetProductState {
  final String? error;

  ProductLoadedFail({this.error});
}
