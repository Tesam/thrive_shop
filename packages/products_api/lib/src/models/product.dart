import 'package:equatable/equatable.dart';
import 'package:products_api/src/models/category.dart';

/// {@template product}
/// A single product item.
///
/// Contains a [productId], [product], [category], [imageUrl], [isFavorite],
/// and [favoriteDate].
///
/// [Product]s are immutable.
/// {@endtemplate}
class Product extends Equatable {
  /// {@macro product}
  const Product({
    this.productId = '',
    required this.product,
    required this.category,
    required this.imageUrl,
    this.isFavorite = false,
    this.favoriteDate = '',
  });

  /// The unique identifier of the product.
  ///
  /// Defaults to an empty string.
  final String productId;

  /// The name of the product.
  ///
  /// Cannot be empty.
  final String product;

  /// The category data of the product.
  ///
  /// Cannot be empty.
  final Category category;

  /// The image url of the product.
  ///
  /// Cannot be empty.
  final String imageUrl;

  /// Whether the product is a favorite.
  ///
  /// Defaults to `false`.
  final bool isFavorite;

  /// The date when the product was set as favorite.
  ///
  /// Defaults to an empty string.
  final String favoriteDate;

  @override
  List<Object?> get props => [
        productId,
        product,
        category,
        imageUrl,
        isFavorite,
        favoriteDate,
      ];
}
