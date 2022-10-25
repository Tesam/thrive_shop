import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_api/products_api.dart';
import 'package:thrive_shop/color_schemes.g.dart';
import 'package:thrive_shop/shopping_list/cubit/shopping_list_cubit.dart';
import 'package:thrive_shop/widgets/delete_swipe_background.dart';
import 'package:thrive_shop/widgets/favorite_swipe_background.dart';
import 'package:thrive_shop/widgets/product_item.dart';

class ProductListItem extends StatelessWidget {
  const ProductListItem({
    super.key,
    required Product product,
  })  : _product = product;

  final Product _product;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey<String>(_product.productId),
      background: const FavoriteSwipeBackground(),
      secondaryBackground: const DeleteSwipeBackground(),
      confirmDismiss: (direction) {
        if (direction == DismissDirection.endToStart) {
          return showDialog(
            context: context,
            builder: (BuildContext dialogContext) {
              return AlertDialog(
                title: Text('Delete ${_product.product}'),
                content: Text('Are you sure you want to delete '
                    '${_product.product}?'),
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
                            productId: _product.productId,
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
                title: _product.isFavorite
                    ? const Text('Delete from favorites?')
                    : const Text('Add to favorites?'),
                content: _product.isFavorite
                    ? Text('Do you want to remove '
                        '${_product.product} from favorites?')
                    : Text('Do you want to add '
                        '${_product.product} to favorites?'),
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
                          context.read<ShoppingListCubit>().setFavoriteState(
                                isFavorite: _product.isFavorite,
                                productId: _product.productId,
                              );

                      if (isSuccessful) {
                        ScaffoldMessenger.of(
                          dialogContext,
                        ).showSnackBar(
                          SnackBar(
                            backgroundColor:
                                AppColors.lightColorScheme.secondary,
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
        }
      },
      child: ProductItem(
        product: _product,
        onFavorite: () {
          final isSuccessful =
              context.read<ShoppingListCubit>().setFavoriteState(
                    isFavorite: _product.isFavorite,
                    productId: _product.productId,
                  );

          if (isSuccessful) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: AppColors.lightColorScheme.secondary,
                content: _product.isFavorite
                    ? const Text('The product was removed from Favorites '
                        'successfully!')
                    : const Text('The product was add to Favorites '
                    'successfully!'),
              ),
            );
          }
        },
      ),
    );
  }
}
