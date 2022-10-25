import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_api/products_api.dart';
import 'package:thrive_shop/color_schemes.g.dart';
import 'package:thrive_shop/shopping_list/cubit/shopping_list_cubit.dart';
import 'package:thrive_shop/shopping_list/widgets/shopping_list_header.dart';
import 'package:thrive_shop/widgets/widgets.dart';

class ProductListView extends StatelessWidget {
  const ProductListView({super.key, required List<Product> items})
      : _items = items;

  final List<Product> _items;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: (_items.isEmpty)
          ? Center(
              child: Text(
                "Oops you don't have any product!",
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
                  return Column(
                    children: [
                      ShoppingListHeader(
                          categoryId: _items[index].category.categoryId,
                          category: _items[index].category.category,
                          color: _items[index].category.color,),
                      Dismissible(
                        key: ValueKey<String>(item.productId),
                        background: const FavoriteSwipeBackground(),
                        secondaryBackground: const DeleteSwipeBackground(),
                        confirmDismiss: (direction) {
                          if (direction == DismissDirection.endToStart) {
                            return showDialog(
                              context: context,
                              builder: (BuildContext dialogContext) {
                                return AlertDialog(
                                  title: Text('Delete ${item.product}'),
                                  content: Text('Are you sure you want to '
                                      'delete ${item.product}?'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text(
                                        'Cancel',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      onPressed: () =>
                                          Navigator.of(dialogContext).pop(),
                                    ),
                                    TextButton(
                                      child: Text(
                                        'DELETE',
                                        style: TextStyle(
                                          color:
                                              AppColors.lightColorScheme.error,
                                        ),
                                      ),
                                      onPressed: () {
                                        context
                                            .read<ShoppingListCubit>()
                                            .deleteProduct(
                                              productId: item.productId,
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
                                  title: item.isFavorite
                                      ? const Text('Delete from favorites?')
                                      : const Text('Add to favorites?'),
                                  content: item.isFavorite
                                      ? Text('Do you want to remove '
                                          '${item.product} from favorites?')
                                      : Text('Do you want to add '
                                          '${item.product} to favorites?'),
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
                                        item.isFavorite ? 'REMOVE' : 'ADD',
                                        style: item.isFavorite
                                            ? TextStyle(
                                                color: AppColors
                                                    .lightColorScheme.error,
                                              )
                                            : TextStyle(
                                                color: AppColors
                                                    .lightColorScheme.secondary,
                                              ),
                                      ),
                                      onPressed: () {
                                        final isSuccessful = context
                                            .read<ShoppingListCubit>()
                                            .setFavoriteState(
                                              isFavorite: item.isFavorite,
                                              productId: item.productId,
                                            );

                                        if (isSuccessful) {
                                          ScaffoldMessenger.of(
                                            dialogContext,
                                          ).showSnackBar(
                                            SnackBar(
                                              backgroundColor: AppColors
                                                  .lightColorScheme.secondary,
                                              content: (item.isFavorite)
                                                  ? const Text(
                                                      'The product was removed '
                                                      'from Favorites '
                                                      'successfully!')
                                                  : const Text(
                                                      'The product was add to '
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
                          imageUrl: item.imageUrl,
                          isFavorite: item.isFavorite,
                          product: item.product,
                          onFavorite: () {
                            final isSuccessful = context
                                .read<ShoppingListCubit>()
                                .setFavoriteState(
                                  isFavorite: item.isFavorite,
                                  productId: item.productId,
                                );

                            if (isSuccessful) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor:
                                      AppColors.lightColorScheme.secondary,
                                  content: (item.isFavorite)
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
                      ),
                    ],
                  );
                } else {
                  return Dismissible(
                    key: ValueKey<String>(item.productId),
                    background: const FavoriteSwipeBackground(),
                    secondaryBackground: const DeleteSwipeBackground(),
                    confirmDismiss: (direction) {
                      if (direction == DismissDirection.endToStart) {
                        return showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Delete ${item.product}'),
                              content: Text('Are you sure you want to '
                                  'delete ${item.product}?'),
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
                                    style: TextStyle(
                                      color: AppColors.lightColorScheme.error,
                                    ),
                                  ),
                                  onPressed: () {
                                    context
                                        .read<ShoppingListCubit>()
                                        .deleteProduct(
                                          productId: item.productId,
                                        );
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
                              title: item.isFavorite
                                  ? const Text('Delete from favorites?')
                                  : const Text('Add to favorites?'),
                              content: item.isFavorite
                                  ? Text('Do you want to remove '
                                      '${item.product} from favorites?')
                                  : Text('Do you want to add '
                                      '${item.product} to favorites?'),
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
                                    item.isFavorite ? 'REMOVE' : 'ADD',
                                    style: item.isFavorite
                                        ? TextStyle(
                                            color: AppColors
                                                .lightColorScheme.error,
                                          )
                                        : TextStyle(
                                            color: AppColors
                                                .lightColorScheme.secondary,
                                          ),
                                  ),
                                  onPressed: () {
                                    print('ENTRE EN ');
                                    final isSuccessful = context
                                        .read<ShoppingListCubit>()
                                        .setFavoriteState(
                                          isFavorite: item.isFavorite,
                                          productId: item.productId,
                                        );

                                    if (isSuccessful) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          backgroundColor: AppColors
                                              .lightColorScheme.secondary,
                                          content: (item.isFavorite)
                                              ? const Text(
                                                  'The product was removed '
                                                  'from Favorites '
                                                  'successfully!')
                                              : const Text(
                                                  'The product was add to '
                                                  'Favorites successfully!'),
                                        ),
                                      );
                                    }
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: ProductItem(
                      imageUrl: item.imageUrl,
                      isFavorite: item.isFavorite,
                      product: item.product,
                      onFavorite: () {
                        final isSuccessful =
                            context.read<ShoppingListCubit>().setFavoriteState(
                                  isFavorite: item.isFavorite,
                                  productId: item.productId,
                                );

                        if (isSuccessful) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor:
                                  AppColors.lightColorScheme.secondary,
                              content: (item.isFavorite)
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
              },
              itemCount: _items.length,
            ),
    );
  }
}
