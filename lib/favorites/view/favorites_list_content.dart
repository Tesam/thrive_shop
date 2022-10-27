import 'package:flutter/material.dart';
import 'package:products_api/products_api.dart';
import 'package:thrive_shop/color_schemes.g.dart';
import 'package:thrive_shop/favorites/widgets/favorites_products_section.dart';
import 'package:thrive_shop/favorites/widgets/widgets.dart';

class FavoritesListContent extends StatelessWidget {
  const FavoritesListContent

  ({super.key, required List<Product> items})

      :

  _items

  =

  items

  ;

  final List<Product> _items;
  static final indexes = <int>[];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: (_items.isEmpty)
          ? Center(
        child: Text(
          "Oops you don't have any Favorite product!",
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
            //aca empieza la nueva categoria
            //agregar el indice siguiente a la lista de indices
            indexes
              ..clear()
              ..add(index + 1);

            return FavoritesProductsSection(
                category: item.category, products: [item],);
            /* return Column(
                    children: [
                      FavoriteProductListHeader(
                        category: item.category,
                        onPressed: () {

                        },
                      ),
                      FavoriteProductsListItem(product: item),
                    ],
                  );*/
          } else {
            indexes.add(index);
            return FavoriteProductsListItem(product: item);
          }
        },
        itemCount: _items.length,
      ),
    );
  }
}
