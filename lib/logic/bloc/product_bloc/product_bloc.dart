import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bloc_practice/data/repository/product_repository.dart';
import 'package:bloc_practice/logic/model/product_model.dart';
import 'package:equatable/equatable.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  List<ProductModel> products = [];
  List<ProductModel> selectedProducts = [];
  final ProductRepository productRepo;
  ProductBloc(this.productRepo) : super(const ProductState()) {
    on<FetchProducts>(fetchProducts);
    on<MarkFavoriteProduct>(markFavorite);
    on<MarkUnFavoriteProduct>(markUnFavorite);
    on<SelectProduct>(selectProduct);
    on<UnselectProduct>(unselectProduct);
    on<DelectSelectedProduct>(delectSelectedProducts);
  }

  Future<void> fetchProducts(
      FetchProducts event, Emitter<ProductState> emit) async {
    await productRepo.fetchProducts().then((newProducts) {
      products = newProducts;
      emit(
        state.copyWith(
          status: Status.success,
          products: List.from(
            products,
          ),
        ),
      );
    }).onError((error, stackTrace) {
      emit(
        state.copyWith(
          status: Status.failure,
        ),
      );
    });
  }

  void markFavorite(MarkFavoriteProduct event, Emitter<ProductState> emit) {
    log('id ${event.product.id}');
    final int index = products.indexWhere((e) => e.id == event.product.id);
    log('index $index');

    final ProductModel updateProduct = ProductModel(
      id: event.product.id,
      name: event.product.name,
      isFavourite: true,
    );
    products[index] = updateProduct;
    log('upadate Product ${products[index]}');
    emit(
      state.copyWith(
        products: List.from(products),
      ),
    );
  }

  void markUnFavorite(MarkUnFavoriteProduct event, Emitter<ProductState> emit) {
    log('id ${event.product.id}');
    final int index = products.indexWhere((e) => e.id == event.product.id);
    log('index $index');
    final ProductModel updateProduct = ProductModel(
      id: event.product.id,
      name: event.product.name,
      isFavourite: false,
    );
    products[index] = updateProduct;
    log('upadate Product ${products[index]}');
    emit(
      state.copyWith(
        products: List.from(products),
      ),
    );
  }

  void selectProduct(SelectProduct event, Emitter<ProductState> emit) {
    log('id ${event.product.id}');
    final int index =
        selectedProducts.indexWhere((e) => e.id == event.product.id);
    if (index == -1) {
      selectedProducts.add(event.product);
    } else {
      selectedProducts[index] = event.product;
    }
    log('selected Product $selectedProducts');
    emit(
      state.copyWith(
        selectedProducts: List.from(selectedProducts),
      ),
    );
  }

  void unselectProduct(UnselectProduct event, Emitter<ProductState> emit) {
    log('id ${event.product.id}');
    selectedProducts.removeWhere((product) => product.id == event.product.id);
    log('selected Product $selectedProducts');
    emit(
      state.copyWith(
        selectedProducts: List.from(selectedProducts),
      ),
    );
  }

  void delectSelectedProducts(
      DelectSelectedProduct event, Emitter<ProductState> emit) {
    for (var e in selectedProducts) {
      products.removeWhere((product) => product.id == e.id);
    }
    selectedProducts.clear();
    emit(
      state.copyWith(
        products: List.from(products),
        selectedProducts: List.from(selectedProducts),
      ),
    );
  }
}
