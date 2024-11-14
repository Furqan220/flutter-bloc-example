part of 'product_bloc.dart';

enum Status { loading, success, failure }

class ProductState extends Equatable {
  final Status status;
  final List<ProductModel> products;
  final List<ProductModel> selectedProducts;
  const ProductState({
    this.status = Status.loading,
    this.products = const [],
    this.selectedProducts = const [],
  });

  @override
  List<Object> get props => [
        status,
        products,
        selectedProducts,
      ];
  ProductState copyWith({
    Status? status,
    List<ProductModel>? products,
    List<ProductModel>? selectedProducts,
  }) {
    return ProductState(
      status: status ?? this.status,
      products: products ?? this.products,
      selectedProducts: selectedProducts ?? this.selectedProducts,
    );
  }
}
