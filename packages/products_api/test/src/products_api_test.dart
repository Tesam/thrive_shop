// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:products_api/products_api.dart';
// ignore_for_file: prefer_const_constructors
import 'package:test/test.dart';

class TestProductsApi extends ProductsApi {
  TestProductsApi() : super();

  @override
  dynamic noSuchMethod(Invocation invocation) {
    return super.noSuchMethod(invocation);
  }
}

void main() {
  group('ProductsApi', () {
    test('can be constructed', () {
      expect(TestProductsApi.new, returnsNormally);
    });
  });
}
