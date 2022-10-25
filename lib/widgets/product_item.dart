import 'package:flutter/material.dart';
import 'package:thrive_shop/color_schemes.g.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    required String imageUrl,
    required bool isFavorite,
    required String product,
    required VoidCallback onFavorite,
  })  : _imageUrl = imageUrl,
        _isFavorite = isFavorite,
        _product = product,
        _onFavorite = onFavorite;

  final String _imageUrl;
  final bool _isFavorite;
  final String _product;
  final VoidCallback _onFavorite;

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
          child: Image.network(_imageUrl, fit: BoxFit.fill),
        ),
      ),
      title: Text(_product),
      trailing: _isFavorite
          ? IconButton(onPressed: _onFavorite, icon: Icon(
        Icons.favorite,
        color: AppColors.lightColorScheme.primary,
      ),)
          : IconButton(onPressed: _onFavorite, icon: Icon(
        Icons.favorite_border,
        color: AppColors.lightColorScheme.primary,
      ),),
    );
  }
}
