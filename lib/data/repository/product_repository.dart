import 'dart:developer';

import 'package:bloc_practice/logic/model/product_model.dart';

final class ProductRepository {
  Future<List<ProductModel>> fetchProducts() async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      final List<ProductModel> products = List.generate(
        10,
        (index) => ProductModel(
          id: index + 1,
          name: 'Product ${index + 1}',
          isFavourite: false,
        ),
      );
      return products;
    } on Exception catch (e) {
      log("Error", error: e);
      rethrow;
    }
  }
}
