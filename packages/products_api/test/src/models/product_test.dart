import 'package:products_api/products_api.dart';
import 'package:test/test.dart';

void main() {
  group('Product', () {
    const category = Category(
      categoryId: '1',
      category: 'category',
      color: 0xFFFFFF,
    );

    Product createProduct({
      String id = '1',
      String product = 'product',
      Category category = category,
      String imageUrl = 'https://picsum.photos/200/300',
      String favoriteDate = '2022-10-02',
      bool isFavorite = true,
    }) {
      return Product(
        productId: id,
        product: product,
        category: category,
        imageUrl: imageUrl,
        favoriteDate: favoriteDate,
        isFavorite: isFavorite,
      );
    }

    Product createProductWithoutNoRequiredFields({
      String product = 'product',
      Category category = category,
      String imageUrl = 'https://picsum.photos/200/300',
    }) {
      return Product(
        product: product,
        category: category,
        imageUrl: imageUrl,
      );
    }

    group('constructor', () {
      test('works correctly', () {
        expect(
          createProduct,
          returnsNormally,
        );
      });

      test('sets id if not provided', () {
        expect(
          createProductWithoutNoRequiredFields().productId,
          isEmpty,
        );
      });

      test('sets favoriteDate if not provided', () {
        expect(
          createProductWithoutNoRequiredFields().favoriteDate,
          isEmpty,
        );
      });

      test('sets isFavorite field if not provided', () {
        expect(
          createProductWithoutNoRequiredFields().isFavorite,
          false,
        );
      });
    });

    test('supports value equality', () {
      expect(
        createProduct(),
        equals(createProduct()),
      );
    });

    test('props are correct', () {
      expect(
        createProduct().props,
        equals([
          '1',
          'product',
          '1',
          'category',
          0xFFFFFF,
          'https://picsum.photos/200/300',
          true,
          '2022-10-02',
        ]),
      );
    });
  });
}
