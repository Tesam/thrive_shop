import 'package:flutter/material.dart';
import 'package:products_api/products_api.dart';
import 'package:thrive_shop/color_schemes.g.dart';
import 'package:thrive_shop/favorites/widgets/widgets.dart';

class FavoritesListContent extends StatelessWidget {
  const FavoritesListContent({super.key, required List<List<Product>> items})
      : _items = items;

  final List<List<Product>> _items;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: (_items.isEmpty)
          ? Center(
              child: Text(
                'Oops the Favorite product list is empty!',
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
                  FavoriteProductsSection(products: _items[index]),
              itemCount: _items.length,
            ),
    );
  }
}
