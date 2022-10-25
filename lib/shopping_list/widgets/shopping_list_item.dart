import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thrive_shop/color_schemes.g.dart';
import 'package:thrive_shop/shopping_list/cubit/shopping_list_cubit.dart';
import 'package:thrive_shop/widgets/delete_swipe_background.dart';
import 'package:thrive_shop/widgets/favorite_swipe_background.dart';
import 'package:thrive_shop/widgets/product_item.dart';

class ShoppingListItem extends StatelessWidget {
  const ShoppingListItem({
    super.key,
    required String productId,
    required String product,
    required bool isFavorite,
    required String imageUrl,
  })  : _productId = productId,
        _product = product,
        _isFavorite = isFavorite,
        _imageUrl = imageUrl;

  final String _productId;
  final String _product;
  final bool _isFavorite;
  final String _imageUrl;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey<String>(_productId),
      background: const FavoriteSwipeBackground(),
      secondaryBackground: const DeleteSwipeBackground(),
      confirmDismiss: (direction) {
        if (direction == DismissDirection.endToStart) {
          return showDialog(
            context: context,
            builder: (BuildContext dialogContext) {
              return AlertDialog(
                title: Text('Delete $_product'),
                content: Text('Are you sure you want to '
                    'delete $_product?'),
                actions: <Widget>[
                  TextButton(
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () => Navigator.of(dialogContext).pop(),
                  ),
                  TextButton(
                    child: Text(
                      'DELETE',
                      style: TextStyle(
                        color: AppColors.lightColorScheme.error,
                      ),
                    ),
                    onPressed: () {
                      context.read<ShoppingListCubit>().deleteProduct(
                            productId: _productId,
                          );
                      Navigator.of(dialogContext).pop();
                    },
                  ),
                ],
              );
            },
          );
        } else {
          return showDialog(
            context: context,
            builder: (BuildContext dialogContext) {
              return AlertDialog(
                title: _isFavorite
                    ? const Text('Delete from favorites?')
                    : const Text('Add to favorites?'),
                content: _isFavorite
                    ? Text('Do you want to remove '
                        '$_product from favorites?')
                    : Text('Do you want to add '
                        '$_product to favorites?'),
                actions: <Widget>[
                  TextButton(
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () {
                      Navigator.of(dialogContext).pop();
                    },
                  ),
                  TextButton(
                    child: Text(
                      _isFavorite ? 'REMOVE' : 'ADD',
                      style: _isFavorite
                          ? TextStyle(
                              color: AppColors.lightColorScheme.error,
                            )
                          : TextStyle(
                              color: AppColors.lightColorScheme.secondary,
                            ),
                    ),
                    onPressed: () {
                      final isSuccessful =
                          context.read<ShoppingListCubit>().setFavoriteState(
                                isFavorite: _isFavorite,
                                productId: _productId,
                              );

                      if (isSuccessful) {
                        ScaffoldMessenger.of(
                          dialogContext,
                        ).showSnackBar(
                          SnackBar(
                            backgroundColor:
                                AppColors.lightColorScheme.secondary,
                            content: _isFavorite
                                ? const Text('The product was removed '
                                    'from Favorites '
                                    'successfully!')
                                : const Text('The product was add to '
                                    'Favorites successfully!'),
                          ),
                        );
                      }
                      Navigator.of(dialogContext).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
      },
      child: ProductItem(
        imageUrl: _imageUrl,
        isFavorite: _isFavorite,
        product: _product,
        onFavorite: () {
          final isSuccessful =
              context.read<ShoppingListCubit>().setFavoriteState(
                    isFavorite: _isFavorite,
                    productId: _productId,
                  );

          if (isSuccessful) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: AppColors.lightColorScheme.secondary,
                content: _isFavorite
                    ? const Text('The product was removed '
                        'from Favorites '
                        'successfully!')
                    : const Text('The product was add to '
                        'Favorites successfully!'),
              ),
            );
          }
        },
      ),
    );
  }
}
