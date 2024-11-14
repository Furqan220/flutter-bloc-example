import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  final int id;
  final String name;
  final bool isFavourite;
  const ProductModel({
    required this.id,
    required this.name,
    required this.isFavourite,
  });

  @override
  List<Object> get props => [
        id,
        name,
        isFavourite,
      ];

  ProductModel copyWith({
    int? id,
    String? name,
    bool? isFavourite,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      isFavourite: isFavourite ?? this.isFavourite,
    );
  }
}
