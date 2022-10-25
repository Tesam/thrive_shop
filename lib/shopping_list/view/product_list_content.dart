import 'package:flutter/material.dart';
import 'package:products_api/products_api.dart';
import 'package:thrive_shop/color_schemes.g.dart';
import 'package:thrive_shop/shopping_list/widgets/shopping_list_header.dart';
import 'package:thrive_shop/shopping_list/widgets/shopping_list_item.dart';

class ProductListContent extends StatelessWidget {
  const ProductListContent({super.key, required List<Product> items})
      : _items = items;

  final List<Product> _items;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: (_items.isEmpty)
          ? Center(
              child: Text("Oops you don't have any product!",
                style: TextStyle(
                  color: AppColors.lightColorScheme.onPrimaryContainer,
                ),
              ),
            )
          : ListView.separated(
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemBuilder: (_, index) {
                var isSameCategory = true;
                final category = _items[index].category.category;
                final item = _items[index];

                if (index == 0) {
                  isSameCategory = false;
                } else {
                  final prevCategory = _items[index - 1].category.category;
                  isSameCategory = category == prevCategory;
                }

                if (index == 0 || !isSameCategory) {
                  return Column(
                    children: [
                      ShoppingListHeader(
                        category: item.category,
                      ),
                      ShoppingListItem(
                        product: item,
                      ),
                    ],
                  );
                } else {
                  return  ShoppingListItem(
                    product: item,
                  );
                }
              },
              itemCount: _items.length,
            ),
    );
  }
}
