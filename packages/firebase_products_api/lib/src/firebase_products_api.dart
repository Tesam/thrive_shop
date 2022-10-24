// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_products_api/firebase_products_api.dart';
import 'package:products_api/products_api.dart';

/// {@template firebase_products_api}
/// A Flutter implementation of the ProductsApi that uses firebase.
/// {@endtemplate}
class FirebaseProductsApi implements ProductsApi {
  /// {@macro firebase_products_api}
  /*const FirebaseProductsApi({required FirebaseFirestore fireStore})
      : _firebaseFirestore = fireStore;*/
  FirebaseProductsApi();

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<bool> addToFavorite({required String productId}) async {
    final productRef = _firebaseFirestore.collection('products');
    try {
      await productRef
          .doc(productId)
          .set({'is_favorite': true}, SetOptions(merge: true));

      return true;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<bool> createCategory({required Category category}) async {
    final batch = _firebaseFirestore.batch();
    final categoryRef = _firebaseFirestore
        .collection('categories')
        .withConverter<CategoryModel>(
          fromFirestore: (snapshot, _) =>
              CategoryModel.fromJson(snapshot.data()!),
          toFirestore: (category, _) => category.toJson(),
        )
        .doc();

    final categoryIdentifierRef = _firebaseFirestore
        .collection(
          'category-identifiers',
        )
        .doc(category.category);

    batch
      ..set(categoryRef, category as CategoryModel)
      ..set(
        categoryIdentifierRef,
        {'category': categoryRef.id},
        SetOptions(merge: false),
      );

    try {
      await batch.commit();
      return true;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<bool> createProduct({required Product product}) async {
    final batch = _firebaseFirestore.batch();
    final productRef = _firebaseFirestore
        .collection('products')
        .withConverter<ProductModel>(
          fromFirestore: (snapshot, _) =>
              ProductModel.fromJson(snapshot.data()!),
          toFirestore: (product, _) => product.toJson(),
        )
        .doc();

    final productIdentifierRef = _firebaseFirestore
        .collection(
          'product-identifiers',
        )
        .doc(product.product);

    batch
      ..set(productRef, product as ProductModel)
      ..set(
        productIdentifierRef,
        {'product': productRef.id},
      );

    try {
      await batch.commit();
      return true;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<bool> deleteCategory({required String categoryId}) {
    // TODO: implement deleteCategory
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteProduct({required String productId}) async {
    final productRef = _firebaseFirestore.collection('products');
    try {
      await productRef.doc(productId).delete();
      return true;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Stream<List<Product>> getFavorites() {
    // TODO: implement getFavorites
    throw UnimplementedError();
  }

  @override
  Stream<List<Product>> getProducts() {
    // TODO: implement getProducts
    throw UnimplementedError();
  }

  @override
  Future<bool> removeFromFavorite({required String productId}) async {
    final productRef = _firebaseFirestore.collection('products');
    try {
      await productRef
          .doc(productId)
          .set({'is_favorite': false}, SetOptions(merge: true));

      return true;
    } catch (error) {
      rethrow;
    }
  }
}
