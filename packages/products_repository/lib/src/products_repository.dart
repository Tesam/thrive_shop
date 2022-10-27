// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:io';

import 'package:products_api/products_api.dart';

/// {@template products_repository}
/// A repository that handles product requests.
/// {@endtemplate}
class ProductsRepository {
  /// {@macro products_repository}
  const ProductsRepository({required ProductsApi productsApi})
      : _productsApi = productsApi;

  final ProductsApi _productsApi;

  /// Provides a [Stream] of all products.
  Stream<List<Product>> getProducts() => _productsApi.getProducts();

  /// Provides a [Future] of all products.
  Future<List<Category>> getCategories() => _productsApi.getCategories();

  /// Create a [product].
  ///
  /// If a [product] with the same productId already exists, the product will
  /// not be created.
  Future<bool> createProduct({required Product product}) =>
      _productsApi.createProduct(product: product);

  /// Create a [category].
  ///
  /// If a [category] with the same categoryId already exists, the category will
  /// not be created.
  Future<bool> createCategory({required Category category}) =>
      _productsApi.createCategory(category: category);

  /// Provides a [Stream] of all favorite products.
  Stream<List<Product>> getFavorites() => _productsApi.getFavorites();

  /// Delete the [Product] with the given productId.
  ///
  /// If no product with the given productId exists, a
  /// [ProductNotFoundException] error is thrown.
  Future<bool> deleteProduct({required String productId}) =>
      _productsApi.deleteProduct(productId: productId);

  /// Delete the [Category] with the given categoryId. And all the [Product]s of
  /// that [Category].
  ///
  /// If no category with the given categoryId exists, a
  /// [CategoryNotFoundException] error is thrown.
  Future<bool> deleteCategory({required String categoryId}) =>
      _productsApi.deleteCategory(categoryId: categoryId);

  /// Sets the `isFavorite` field to `true` of the given productId.
  ///
  /// If no product with the given productId exists, a
  /// [ProductNotFoundException] error is thrown.
  Future<bool> addToFavorite({required String productId}) =>
      _productsApi.addToFavorite(productId: productId);

  /// Sets the `isFavorite` field to `false` of the given productId.
  ///
  /// If no product with the given productId exists, a
  /// [ProductNotFoundException] error is thrown.
  Future<bool> removeFromFavorite({required String productId}) =>
      _productsApi.removeFromFavorite(productId: productId);

  ///Upload a product image on server
  Future<String> addProductImage({required File image}) =>
      _productsApi.addProductImage(image: image);
}
