import 'package:flutter/material.dart';
import 'package:products_api/products_api.dart';
import 'package:thrive_shop/widgets/category_header.dart';

class FavoriteProductListHeader extends StatelessWidget {
  const FavoriteProductListHeader({super.key, required Category category})
      : _category = category;

  final Category _category;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
        bottom: 10,
      ),
      child: CategoryHeader(
        category: _category,
      ),
    );
  }
}
