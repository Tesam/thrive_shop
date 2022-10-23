import 'package:firebase_products_api/src/models/category_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Category Model', () {
    CategoryModel createCategoryModel({
      String id = '1',
      String category = 'category',
      int color = 0xFFFFFF,
    }) {
      return CategoryModel(
        categoryId: id,
        category: category,
        color: color,
      );
    }

    group('constructor', () {
      test('supports value equality', () {
        expect(
          createCategoryModel(),
          equals(createCategoryModel()),
        );
      });
    });

    group('fromJson', () {
      test('works correctly', () {
        expect(
          CategoryModel.fromJson(const <String, dynamic>{
            'category_id': '1',
            'category': 'category',
            'color': 0xFFFFFF,
          }),
          equals(createCategoryModel()),
        );
      });
    });

    group('toJson', () {
      test('works correctly', () {
        expect(
          createCategoryModel().toJson(),
          equals(<String, dynamic>{
            'category_id': '1',
            'category': 'category',
            'color': 0xFFFFFF,
          }),
        );
      });
    });
  });
}
