// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_products_api/firebase_products_api.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:thrive_shop/app/app.dart';
import 'package:thrive_shop/bootstrap.dart';

void main() {
  final productsApi = FirebaseProductsApi(
    fireStore: FirebaseFirestore.instance,
    firebaseStorage: FirebaseStorage.instance,
  );

  bootstrap(productsApi: productsApi);
}
