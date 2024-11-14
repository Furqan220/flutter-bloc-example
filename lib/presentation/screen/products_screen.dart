import 'dart:developer';

import 'package:bloc_practice/logic/bloc/product_bloc/product_bloc.dart';
import 'package:bloc_practice/logic/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(FetchProducts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Favorite App Bloc'),
        actions: [
          BlocBuilder<ProductBloc, ProductState>(
            builder: (_, state) {
              if (state.selectedProducts.isEmpty) {
                return const SizedBox.shrink();
              }
              return IconButton(
                onPressed: () =>
                    context.read<ProductBloc>().add(DelectSelectedProduct()),
                icon: const Icon(
                  Icons.delete,
                ),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        buildWhen: (previous, current) =>
            previous.status != current.status ||
            previous.products.length != current.products.length,
        builder: (__, state) {
          log(state.products.toString());
          switch (state.status) {
            case Status.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case Status.failure:
              return const Center(
                child: Text(
                  'No Products Available',
                ),
              );
            default:
              return buildProducts(context, state.products);
          }
        },
      ),
    );
  }

  Widget buildProducts(
    BuildContext context,
    List<ProductModel> products,
  ) {
    if (products.isEmpty) {
      return const Center(
        child: Text(
          'No Products Available',
        ),
      );
    } else {
      return ListView.separated(
        padding: const EdgeInsets.symmetric(
          vertical: 30,
          horizontal: 30,
        ),
        separatorBuilder: (_, i) => const Divider(
          height: 20,
        ),
        itemBuilder: (_, i) => productTile(_, i),
        itemCount: products.length,
      );
    }
  }

  Widget productTile(BuildContext context, int i) {
    return BlocBuilder<ProductBloc, ProductState>(
      buildWhen: (previous, current) =>
          previous.selectedProducts != current.selectedProducts ||
          previous.products[i] != current.products[i],
      builder: (_, state) {
        final product = state.products[i];
        final bool isSelected =
            state.selectedProducts.any((e) => e.id == product.id);
        log(product.toString());
        return InkWell(
          onLongPress: () {
            if (isSelected) {
              context.read<ProductBloc>().add(
                    UnselectProduct(product),
                  );
            } else {
              context.read<ProductBloc>().add(
                    SelectProduct(product),
                  );
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  if (state.selectedProducts.isNotEmpty)
                    Checkbox(
                      value: isSelected,
                      onChanged: (e) {
                        if (isSelected) {
                          context.read<ProductBloc>().add(
                                UnselectProduct(product),
                              );
                        } else {
                          context.read<ProductBloc>().add(
                                SelectProduct(product),
                              );
                        }
                      },
                    ),
                  Text(
                    product.name,
                  ),
                ],
              ),
              IconButton(
                onPressed: () {
                  final ProductModel newProduct = ProductModel(
                    id: product.id,
                    name: product.name,
                    isFavourite: !product.isFavourite,
                  );
                  if (product.isFavourite) {
                    context
                        .read<ProductBloc>()
                        .add(MarkUnFavoriteProduct(newProduct));
                  } else {
                    context
                        .read<ProductBloc>()
                        .add(MarkFavoriteProduct(newProduct));
                  }
                },
                icon: Icon(
                  product.isFavourite ? Icons.favorite : Icons.favorite_outline,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
