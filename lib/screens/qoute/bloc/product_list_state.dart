part of 'product_list_bloc.dart';

@immutable
class ProductListState {
  final List<ProductsList> productList;

  const ProductListState({required this.productList});

  ProductListState copyWith({List<ProductsList>? productList}) {
    return ProductListState(
      productList: productList ?? this.productList,
    );
  }
}
