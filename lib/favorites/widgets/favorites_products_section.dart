import 'package:flutter/material.dart';
import 'package:products_api/products_api.dart';
import 'package:thrive_shop/favorites/widgets/widgets.dart';

class FavoriteProductsSection extends StatelessWidget {
  const FavoriteProductsSection({
    super.key,
    required List<Product> products,
  }) : _products = products;

  final List<Product> _products;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        title: FavoriteProductListHeader(
          category: _products.first.category,
        ),
        children: <Widget>[
          ..._products.map(
            (item) => FavoriteProductsListItem(
              product: item,
            ),
          )
        ],
      ),
    );
  }
}
