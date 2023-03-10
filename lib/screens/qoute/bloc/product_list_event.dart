part of 'product_list_bloc.dart';

@immutable
abstract class ProductListEvent {}

class AddProductToListEvent extends ProductListEvent {
  final ProductsList productsList;

  AddProductToListEvent({required this.productsList});
}

class RemoveProductFromCardByIdEvent extends ProductListEvent {
  final String productId;

  RemoveProductFromCardByIdEvent({required this.productId});
}

class UpdateProductQuantityByIdEvent extends ProductListEvent {
  final String productId;
  final int quantity;

  UpdateProductQuantityByIdEvent(
      {required this.productId, required this.quantity});
}

class UpdateProductToListEvent extends ProductListEvent {
  final ProductsList productsList;

  UpdateProductToListEvent({required this.productsList});
}

class ClearProductToListEvent extends ProductListEvent {}

class DeleteProductToListEvent extends ProductListEvent {
  final ProductsList productsList;

  DeleteProductToListEvent({required this.productsList});
}
