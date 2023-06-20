part of 'get_product_bloc.dart';

@immutable
abstract class GetProductEvent {}


class GetProductListEvent extends GetProductEvent {
  Map<String, dynamic> queryParameters;

  GetProductListEvent(this.queryParameters);
}

class GetSubProductListEvent extends GetProductEvent {
  Map<String, dynamic> queryParameters;

  GetSubProductListEvent(this.queryParameters);
}
