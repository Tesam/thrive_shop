import 'package:flutter/material.dart';
import 'package:products_api/products_api.dart';
import 'package:thrive_shop/shopping_list/widgets/widgets.dart';

class ProductsSection extends StatelessWidget {
  const ProductsSection({
    super.key,
    required List<Product> products,
  })  : _products = products;

  final List<Product> _products;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: ProductListHeader(
        category: _products.first.category,
      ),
      children: <Widget>[
        ..._products.map(
              (item) => ProductListItem(
            product: item,
          ),
        )
      ],
    );
  }
}
