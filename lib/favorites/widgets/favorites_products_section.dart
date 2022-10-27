import 'package:flutter/material.dart';
import 'package:products_api/products_api.dart';

import 'package:thrive_shop/favorites/widgets/widgets.dart';

class FavoritesProductsSection extends StatefulWidget {
  const FavoritesProductsSection({
    super.key,
    required Category category,
    required List<Product> products,
  })  : _category = category,
        _products = products;

  final Category _category;
  final List<Product> _products;

  @override
  FavoritesProductsSectionState createState() =>
      FavoritesProductsSectionState();
}

class FavoritesProductsSectionState extends State<FavoritesProductsSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FavoriteProductListHeader(category: widget._category,),
        ...widget._products
            .map((item) => FavoriteProductsListItem(product: item))
      ],
    );
  }
}
