import 'package:firebase_products_api/src/models/category_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:products_api/products_api.dart';

part 'product_model.g.dart';

/// {@template product model}
/// A model of the [Product] entity.
///
/// Contains a [productId], [product], [category], [imageUrl], [isFavorite],
/// and [favoriteDate].
/// [ProductModel] is serialized and deserialized using [toJson] and
/// [ProductModel.fromJson] respectively.
/// {@endtemplate}
@JsonSerializable(explicitToJson: true)
class ProductModel extends Product {
  /// {@macro ProductModel}
  const ProductModel({
    required super.product,
    required this.category,
    required super.imageUrl,
    super.isFavorite,
    super.favoriteDate,
    super.productId,
  }) : super(category: category);

  /// Deserializes the given [json] Map into a [ProductModel].
  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  /// The product [CategoryModel].
  ///
  /// [CategoryModel] is serialized and deserialized using [toJson] and
  /// [CategoryModel.fromJson] respectively.
  // ignore: annotate_overrides, overridden_fields
  final CategoryModel category;

  /// Converts this [ProductModel] into a [Map].
  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}
