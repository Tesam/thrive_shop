import 'package:flutter/material.dart';
import 'package:thrive_shop/widgets/widgets.dart';

class ShoppingListPage extends StatelessWidget {
  ShoppingListPage({super.key});

  final TextEditingController _textEditingController = TextEditingController();

  final List<Map<String, dynamic>> _elements = [
    {
      'product': 'Product 1',
      'product_id': 'product_1',
      'image_url': 'https://picsum.photos/200/300',
      'is_favorite': true,
      'category': {
        'category': 'Category 1',
        'category_id': 'category_1',
        'color': 0xFFF5DE62,
      }
    },
    {
      'product': 'Product 2',
      'product_id': 'product_2',
      'image_url': 'https://picsum.photos/200/300',
      'is_favorite': true,
      'category': {
        'category': 'Category 1',
        'category_id': 'category_1',
        'color': 0xFFF5DE62,
      }
    },
    {
      'product': 'Product 3',
      'product_id': 'product_3',
      'image_url': 'https://picsum.photos/200/300',
      'is_favorite': true,
      'category': {
        'category': 'Category 1',
        'category_id': 'category_1',
        'color': 0xFFF5DE62,
      }
    },
    {
      'product': 'Product 4',
      'product_id': 'product_4',
      'image_url': 'https://picsum.photos/200/300',
      'is_favorite': false,
      'category': {
        'category': 'Category 2',
        'category_id': 'category_2',
        'color': 0xFFE249CA,
      }
    },
    {
      'product': 'Product 5',
      'product_id': 'product_5',
      'image_url': 'https://picsum.photos/200/300',
      'is_favorite': false,
      'category': {
        'category': 'Category 2',
        'category_id': 'category_2',
        'color': 0xFFE249CA,
      }
    },
    {
      'product': 'Product 6',
      'product_id': 'product_6',
      'image_url': 'https://picsum.photos/200/300',
      'is_favorite': true,
      'category': {
        'category': 'Category 3',
        'category_id': 'category_3',
        'color': 0xFF3CA9F9,
      }
    },
    {
      'product': 'Product 7',
      'product_id': 'product_7',
      'image_url': 'https://picsum.photos/200/300',
      'is_favorite': true,
      'category': {
        'category': 'Category 3',
        'category_id': 'category_3',
        'color': 0xFF3CA9F9,
      }
    },
    {
      'product': 'Product 8',
      'product_id': 'product_8',
      'image_url': 'https://picsum.photos/200/300',
      'is_favorite': false,
      'category': {
        'category': 'Category 4',
        'category_id': 'category_4',
        'color': 0xFF6750A4,
      }
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Column(
        children: [
          CSMTextField(
            textEditingController: _textEditingController,
            text: 'Search by Product or Category',
            isSearchTextField: true,
          ),
          const SizedBox(height: 20,),
          Expanded(
            child: ListView.builder(
              itemBuilder: (_, index) {
                var isSameCategory = true;
                final category =
                _elements[index]['category']['category'].toString();
                final item = _elements[index];

                if (index == 0) {
                  isSameCategory = false;
                } else {
                  final prevCategory =
                  _elements[index - 1]['category']['category'].toString();
                  isSameCategory = category == prevCategory;
                }

                if (index == 0 || !isSameCategory) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 10),
                        child: CategoryHeader(
                            color: item['category']['color'] as int, category: category),
                      ),
                      ProductItem(
                        imageUrl: item['image_url'].toString(),
                        isFavorite: item['is_favorite'] as bool,
                        product: item['product'].toString(),
                      ),
                    ],
                  );
                } else {
                  return ProductItem(
                    imageUrl: item['image_url'].toString(),
                    isFavorite: item['is_favorite'] as bool,
                    product: item['product'].toString(),
                  );
                }
              },
              itemCount: _elements.length,
            ),
          ),
        ],
      ),
    );
  }
}
