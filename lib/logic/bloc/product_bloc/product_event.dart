part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class FetchProducts extends ProductEvent {}

class MarkFavoriteProduct extends ProductEvent {
  final ProductModel product;
  const MarkFavoriteProduct(this.product);
}

class MarkUnFavoriteProduct extends ProductEvent {
  final ProductModel product;
  const MarkUnFavoriteProduct(this.product);
}

class SelectProduct extends ProductEvent {
  final ProductModel product;
  const SelectProduct(this.product);
}

class UnselectProduct extends ProductEvent {
  final ProductModel product;
  const UnselectProduct(this.product);
}

class DelectSelectedProduct extends ProductEvent {}
