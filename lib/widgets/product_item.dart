import 'package:flutter/material.dart';
import 'package:products_api/products_api.dart';
import 'package:thrive_shop/color_schemes.g.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    required Product product,
    required VoidCallback onFavorite,
    required bool showFavoriteDate,
  })  : _product = product,
        _onFavorite = onFavorite,
        _showFavoriteDate = showFavoriteDate;

  final Product _product;
  final VoidCallback _onFavorite;
  final bool _showFavoriteDate;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black12),
        ),
        width: 50,
        height: 50,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(_product.imageUrl, fit: BoxFit.fill),
        ),
      ),
      title: Text(_product.product),
      subtitle: (_showFavoriteDate && _product.favoriteDate.isNotEmpty)
          ? Text(_product.favoriteDate)
          : null,
      trailing: (_product.isFavorite)
          ? IconButton(
              onPressed: _onFavorite,
              icon: Icon(
                Icons.favorite,
                color: AppColors.lightColorScheme.primary,
              ),
            )
          : IconButton(
              onPressed: _onFavorite,
              icon: Icon(
                Icons.favorite_border,
                color: AppColors.lightColorScheme.primary,
              ),
            ),
    );
  }
}
