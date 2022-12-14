// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_products_api/firebase_products_api.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'package:products_api/products_api.dart';

/// {@template firebase_products_api}
/// A Flutter implementation of the ProductsApi that uses firebase.
/// {@endtemplate}
class FirebaseProductsApi implements ProductsApi {
  /// {@macro firebase_products_api}
  const FirebaseProductsApi({
    required FirebaseFirestore fireStore,
    required FirebaseStorage firebaseStorage,
  })  : _firebaseFirestore = fireStore,
        _firebaseStorage = firebaseStorage;

  final FirebaseFirestore _firebaseFirestore;
  final FirebaseStorage _firebaseStorage;

  @override
  Future<bool> addToFavorite({required String productId}) async {
    final productRef = _firebaseFirestore.collection('products');
    final now = DateTime.now();
    final formatter = DateFormat('yyyy-MM-dd');
    final formattedDate = formatter.format(now);

    try {
      await productRef.doc(productId).set(
        {'is_favorite': true, 'favorite_date': formattedDate},
        SetOptions(merge: true),
      );

      return true;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<bool> createCategory({required Category category}) async {

    final categoryModel =
        CategoryModel.fromCategory(category);

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
        .doc(categoryModel.category);

    batch
      ..set(categoryRef, categoryModel)
      ..update(
        categoryRef,
        {'category_id': categoryRef.id},
      )
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
      ..update(
        productRef,
        {'product_id': productRef.id},
      )
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
  Future<bool> deleteCategory({required String categoryId}) async {
    final batch = _firebaseFirestore.batch();

    final categoryRef = _firebaseFirestore.collection('categories');
    final categoryIdentifiersRef =
        _firebaseFirestore.collection('category-identifiers');
    final productRef = _firebaseFirestore.collection('products');

    final snapshot = await categoryRef.doc(categoryId).get();
    final categoryName = snapshot.get('category').toString();

    batch
      ..delete(categoryRef.doc(categoryId))
      ..delete(categoryIdentifiersRef.doc(categoryName));

    try {
      final categoryProducts = await productRef
          .where('category.category', isEqualTo: categoryName)
          .withConverter<ProductModel>(
            fromFirestore: (snapshot, options) {
              return ProductModel.fromJson(snapshot.data()!);
            },
            toFirestore: (value, options) {
              return value.toJson();
            },
          )
          .get()
          .then((value) => value.docs);

      for (final product in categoryProducts) {
        await deleteProduct(productId: product.data().productId);
      }

      await batch.commit();

      return true;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<bool> deleteProduct({required String productId}) async {
    final batch = _firebaseFirestore.batch();

    final productRef = _firebaseFirestore.collection('products');
    final productIdentifiersRef =
        _firebaseFirestore.collection('product-identifiers');

    final snapshot = await productRef.doc(productId).get();
    final productName = snapshot.get('product').toString();

    batch
      ..delete(productRef.doc(productId))
      ..delete(productIdentifiersRef.doc(productName));
    try {
      await batch.commit();
      return true;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Stream<List<Product>> getFavorites() {
    try {
      return _firebaseFirestore
          .collection('products')
          .where('is_favorite', isEqualTo: true)
          .orderBy(
            'category.category',
          )
          .withConverter<ProductModel>(
            fromFirestore: (snapshot, options) {
              return ProductModel.fromJson(snapshot.data()!);
            },
            toFirestore: (value, options) {
              return value.toJson();
            },
          )
          .snapshots()
          .map(
            (query) => query.docs.map((snapshot) => snapshot.data()).toList(),
          );
    } catch (error) {
      rethrow;
    }
  }

  @override
  Stream<List<Product>> getProducts() {
    try {
      return _firebaseFirestore
          .collection('products')
          .withConverter<ProductModel>(
            fromFirestore: (snapshot, options) {
              return ProductModel.fromJson(snapshot.data()!);
            },
            toFirestore: (value, options) {
              return value.toJson();
            },
          )
          .orderBy(
            'category.category',
          )
          .snapshots()
          .map(
            (query) => query.docs.map((snapshot) => snapshot.data()).toList(),
          );
    } catch (error) {
      rethrow;
    }
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

  @override
  Future<List<Category>> getCategories() async {
    try {
      final ref = _firebaseFirestore
          .collection('categories')
          .withConverter<CategoryModel>(
        fromFirestore: (snapshot, options) {
          return CategoryModel.fromJson(snapshot.data()!);
        },
        toFirestore: (value, options) {
          return value.toJson();
        },
      ).orderBy(
        'category',
      );

      return (await ref.get()).docs.map((document) => document.data()).toList();
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<String> addProductImage({required File image}) async {
    final snapshot = await _firebaseStorage
        .ref()
        .child('images/product_${DateTime.now()}')
        .putFile(image);
    return snapshot.ref.getDownloadURL();
  }
}
