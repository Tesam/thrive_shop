import 'package:flutter/material.dart';
import 'package:products_api/products_api.dart';
import 'package:thrive_shop/color_schemes.g.dart';
import 'package:thrive_shop/shopping_list/widgets/widgets.dart';

class ProductListContent extends StatelessWidget {
  const ProductListContent({super.key, required List<List<Product>> items})
      : _items = items;

  final List<List<Product>> _items;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: (_items.isEmpty)
          ? Center(
              child: Text(
                'Oops the product list is empty!',
                style: TextStyle(
                  color: AppColors.lightColorScheme.onPrimaryContainer,
                ),
              ),
            )
          : ListView.separated(
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemBuilder: (_, index) =>
                  ProductsSection(products: _items[index]),
              itemCount: _items.length,
            ),
    );
  }
}
