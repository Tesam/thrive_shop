import 'package:products_api/products_api.dart';
import 'package:test/test.dart';

void main() {
  group('Category', () {
    Category createCategory({
      String id = '1',
      String category = 'category',
      int color = 0xFFFFFF,
    }) {
      return Category(
        categoryId: id,
        category: category,
        color: color,
      );
    }

    Category createCategoryWithoutId({
      String category = 'category',
      int color = 0xFFFFFF,
    }) {
      return Category(
        category: category,
        color: color,
      );
    }

    group('constructor', () {
      test('works correctly', () {
        expect(
          createCategory,
          returnsNormally,
        );
      });

      test('sets id if not provided', () {
        expect(
          createCategoryWithoutId().categoryId,
          isEmpty,
        );
      });
    });

    test('supports value equality', () {
      expect(
        createCategory(),
        equals(createCategory()),
      );
    });

    test('props are correct', () {
      expect(
        createCategory().props,
        equals([
          '1', // categoryId
          'category', // category
          0xFFFFFF, // color
        ]),
      );
    });

  });
}
