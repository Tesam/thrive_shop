// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:products_api/src/models/category.dart';
import 'package:products_api/src/models/product.dart';

/// {@template products_api}
/// Interface for an API providing access to Products
/// {@endtemplate}
abstract class ProductsApi {
  /// {@macro products_api}
  const ProductsApi();

  /// Provides a [Stream] of all products.
  Stream<List<Product>> getProducts();

  /// Create a [product].
  ///
  /// If a [product] with the same productId already exists, the product will
  /// not be created.
  Future<bool> createProduct({required Product product});

  /// Create a [category].
  ///
  /// If a [category] with the same categoryId already exists, the category will
  /// not be created.
  Future<bool> createCategory({required Category category});

  /// Provides a [Stream] of all favorite products.
  Stream<List<Product>> getFavorites();

  /// Delete the [Product] with the given productId.
  ///
  /// If no product with the given productId exists, a
  /// [ProductNotFoundException] error is thrown.
  Future<bool> deleteProduct({required String productId});

  /// Delete the [Category] with the given categoryId. And all the [Product]s of
  /// that [Category].
  ///
  /// If no category with the given categoryId exists, a
  /// [CategoryNotFoundException] error is thrown.
  Future<bool> deleteCategory({required String categoryId});

  /// Sets the `isFavorite` field to `true` of the given productId.
  ///
  /// If no product with the given productId exists, a
  /// [ProductNotFoundException] error is thrown.
  Future<bool> addToFavorite({required String productId});

  /// Sets the `isFavorite` field to `false` of the given productId.
  ///
  /// If no product with the given productId exists, a
  /// [ProductNotFoundException] error is thrown.
  Future<bool> removeFromFavorite({required String productId});
}

/// Error thrown when a [Product] with a given productId is not found.
class ProductNotFoundException implements Exception {}

/// Error thrown when a [Category] with a given categoryId is not found.
class CategoryNotFoundException implements Exception {}
