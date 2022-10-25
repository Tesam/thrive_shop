import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_repository/products_repository.dart';
import 'package:thrive_shop/color_schemes.g.dart';
import 'package:thrive_shop/favorites/cubit/favorites_cubit.dart';
import 'package:thrive_shop/widgets/widgets.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FavoritesCubit(
        repository: context.read<ProductsRepository>(),
      )..fetchList(),
      child: const FavoritesView(),
    );
  }
}

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<FavoritesCubit>().state;
    switch (state.status) {
      case FavoritesStatus.failure:
        return const Center(child: Text('Oops something went wrong!'));
      case FavoritesStatus.success:
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Favorites',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: (state.items.isEmpty)
                    ? Center(
                        child: Text(
                          "Oops you don't have any Favorite product!",
                          style: TextStyle(
                            color:
                                AppColors.lightColorScheme.onPrimaryContainer,
                          ),
                        ),
                      )
                    : ListView.separated(
                        separatorBuilder: (context, index) {
                          return const Divider();
                        },
                        itemBuilder: (_, index) {
                          var isSameCategory = true;
                          final category = state.items[index].category.category;
                          final item = state.items[index];

                          if (index == 0) {
                            isSameCategory = false;
                          } else {
                            final prevCategory =
                                state.items[index - 1].category.category;
                            isSameCategory = category == prevCategory;
                          }

                          if (index == 0 || !isSameCategory) {
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 20,
                                    bottom: 10,
                                  ),
                                  child: CategoryHeader(
                                    color: item.category.color,
                                    category: category,
                                    onDelete: (){},
                                  ),
                                ),
                                ProductItem(
                                  imageUrl: item.imageUrl,
                                  isFavorite: item.isFavorite,
                                  product: item.product,
                                  onFavorite: () {
                                    final isSuccessful = context
                                        .read<FavoritesCubit>()
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
                                  },
                                  onDelete: () {},
                                ),
                              ],
                            );
                          } else {
                            return ProductItem(
                              imageUrl: item.imageUrl,
                              isFavorite: item.isFavorite,
                              product: item.product,
                              onFavorite: () {
                                final isSuccessful = context
                                    .read<FavoritesCubit>()
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
                                          ? const Text(
                                              'The product was removed from '
                                              'Favorites successfully!')
                                          : const Text('The product was add to '
                                              'Favorites successfully!'),
                                    ),
                                  );
                                }
                              },
                              onDelete: () {},
                            );
                          }
                        },
                        itemCount: state.items.length,
                      ),
              )
            ],
          ),
        );
      case FavoritesStatus.loading:
        return const Center(child: CircularProgressIndicator());
    }
  }
}
