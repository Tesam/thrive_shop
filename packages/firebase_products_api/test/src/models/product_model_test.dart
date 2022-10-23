import 'package:firebase_products_api/src/models/category_model.dart';
import 'package:firebase_products_api/src/models/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Product Model', () {
    const category = CategoryModel(
      categoryId: '1',
      category: 'category',
      color: 0xFFFFFF,
    );

    ProductModel createProductModel({
      String id = '1',
      String product = 'product',
      CategoryModel category = category,
      String imageUrl = 'https://picsum.photos/200/300',
      String favoriteDate = '2022-10-02',
      bool isFavorite = true,
    }) {
      return ProductModel(
        productId: id,
        product: product,
        category: category,
        imageUrl: imageUrl,
        favoriteDate: favoriteDate,
        isFavorite: isFavorite,
      );
    }

    group('constructor', () {
      test('supports value equality', () {
        expect(
          createProductModel(),
          equals(createProductModel()),
        );
      });
    });

    group('fromJson', () {
      test('works correctly', () {
        expect(
          ProductModel.fromJson(const <String, dynamic>{
            'product_id': '1',
            'product': 'product',
            'image_url': 'https://picsum.photos/200/300',
            'is_favorite': true,
            'favorite_date': '2022-10-02',
            'category': {
              'category_id': '1',
              'category': 'category',
              'color': 0xFFFFFF,
            }
          }),
          equals(createProductModel()),
        );
      });
    });

    group('toJson', () {
      test('works correctly', () {
        expect(
          createProductModel().toJson(),
          equals(<String, dynamic>{
            'product_id': '1',
            'product': 'product',
            'image_url': 'https://picsum.photos/200/300',
            'is_favorite': true,
            'favorite_date': '2022-10-02',
            'category': {
              'category_id': '1',
              'category': 'category',
              'color': 0xFFFFFF,
            }
          }),
        );
      });
    });
  });
}
