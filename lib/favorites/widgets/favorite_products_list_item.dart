import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_api/products_api.dart';
import 'package:thrive_shop/color_schemes.g.dart';
import 'package:thrive_shop/favorites/cubit/favorites_cubit.dart';
import 'package:thrive_shop/widgets/widgets.dart';

class FavoriteProductsListItem extends StatelessWidget {
  const FavoriteProductsListItem({super.key, required Product product})
      : _product = product;

  final Product _product;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey<String>(_product.productId),
      background: const FavoriteSwipeBackground(),
      secondaryBackground: const FavoriteSwipeBackground(),
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (BuildContext dialogContext) {
            return AlertDialog(
              title: _product.isFavorite
                  ? const Text('Delete from favorites?')
                  : const Text('Add to favorites?'),
              content: _product.isFavorite
                  ? Text('Do you want to remove ${_product.product} '
                      'from favorites?')
                  : Text('Do you want to add ${_product.product} '
                      'to favorites?'),
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
                    (_product.isFavorite) ? 'REMOVE' : 'ADD',
                    style: (_product.isFavorite)
                        ? TextStyle(
                            color: AppColors.lightColorScheme.error,
                          )
                        : TextStyle(
                            color: AppColors.lightColorScheme.secondary,
                          ),
                  ),
                  onPressed: () {
                    final isSuccessful =
                        context.read<FavoritesCubit>().setFavoriteState(
                              isFavorite: _product.isFavorite,
                              productId: _product.productId,
                            );

                    if (isSuccessful) {
                      ScaffoldMessenger.of(dialogContext).showSnackBar(
                        SnackBar(
                          backgroundColor: AppColors.lightColorScheme.secondary,
                          content: (_product.isFavorite)
                              ? const Text('The product was removed from '
                                  'Favorites successfully!')
                              : const Text('The product was add to Favorites '
                                  'successfully!'),
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
      },
      child: ProductItem(
        product: _product,
        onFavorite: () => _onFavorite(context),
        showFavoriteDate: true,
      ),
    );
  }

  void _onFavorite(BuildContext context) {
    final isSuccessful = context.read<FavoritesCubit>().setFavoriteState(
          isFavorite: _product.isFavorite,
          productId: _product.productId,
        );

    if (isSuccessful) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.lightColorScheme.secondary,
          content: (_product.isFavorite)
              ? const Text('The product was removed from Favorites '
                  'successfully!')
              : const Text('The product was add to Favorites '
                  'successfully!'),
        ),
      );
    }
  }
}
