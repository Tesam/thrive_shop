import 'package:flutter/material.dart';
import 'package:thrive_shop/color_schemes.g.dart';
import 'package:thrive_shop/shopping_list/widgets/delete_swipe_background.dart';
import 'package:thrive_shop/shopping_list/widgets/favorite_swipe_background.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    required String imageUrl,
    required bool isFavorite,
    required String product,
    required VoidCallback onFavorite,
    required VoidCallback onDelete,
  })  : _imageUrl = imageUrl,
        _isFavorite = isFavorite,
        _product = product,
        _onFavorite = onFavorite,
        _onDelete = onDelete;

  final String _imageUrl;
  final bool _isFavorite;
  final String _product;
  final VoidCallback _onFavorite;
  final VoidCallback _onDelete;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey<String>(_product),
      background: const FavoriteSwipeBackground(),
      secondaryBackground: const DeleteSwipeBackground(),
      confirmDismiss: (direction) {
        if (direction == DismissDirection.endToStart) {
          return showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Delete $_product'),
                content: Text('Are you sure you want to delete $_product?'),
                actions: <Widget>[
                  TextButton(
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  TextButton(
                    child: Text(
                      'DELETE',
                      style: TextStyle(color: AppColors.lightColorScheme.error),
                    ),
                    onPressed: () {
                      _onDelete();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        } else {
          return showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: _isFavorite
                      ? const Text('Delete from favorites?')
                      : const Text('Add to favorites?'),
                  content: _isFavorite
                      ? Text('Do you want to remove $_product from favorites?')
                      : Text('Do you want to add $_product to favorites?'),
                  actions: <Widget>[
                    TextButton(
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: Text(
                        _isFavorite ? 'REMOVE' : 'ADD',
                        style: _isFavorite
                            ? TextStyle(
                                color: AppColors.lightColorScheme.error,)
                            : TextStyle(
                                color: AppColors.lightColorScheme.secondary,),
                      ),
                      onPressed: () {
                        _onFavorite();
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },);
        }
      },
      child: ListTile(
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
      ),
    );
  }
}
