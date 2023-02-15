part of 'product_list_bloc.dart';

@immutable
abstract class ProductListEvent {}

class AddProductToListEvent extends ProductListEvent {
  final ProductsList productsList;

  AddProductToListEvent({required this.productsList});
}


class UpdateProductToListEvent extends ProductListEvent {
  final ProductsList productsList;

  UpdateProductToListEvent({required this.productsList});
}