import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_repository/products_repository.dart';
import 'package:thrive_shop/color_schemes.g.dart';
import 'package:thrive_shop/shopping_list/cubit/shopping_list_cubit.dart';
import 'package:thrive_shop/widgets/widgets.dart';

class ShoppingListPage extends StatelessWidget {
  const ShoppingListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ShoppingListCubit(
        repository: context.read<ProductsRepository>(),
      )..fetchList(),
      child: ShoppingListView(),
      // child: Text(""),
    );
  }
}

class ShoppingListView extends StatelessWidget {
  ShoppingListView({super.key});

  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ShoppingListCubit>().state;
    switch (state.status) {
      case ListStatus.failure:
        return const Center(child: Text('Oops something went wrong!'));
      case ListStatus.success:
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
            children: [
              CSMTextField(
                textEditingController: _textEditingController,
                text: 'Search by Product or Category',
                isSearchTextField: true,
                onChanged: (value) =>
                    context.read<ShoppingListCubit>().searchList(value),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: (state.items.isEmpty)
                    ? Center(
                        child: Text(
                          "Oops you don't have any product!",
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
                                      top: 20, bottom: 10,),
                                  child: CategoryHeader(
                                    color: item.category.color,
                                    category: category,
                                    onDelete: () => context
                                        .read<ShoppingListCubit>()
                                        .deleteCategory(
                                          categoryId: item.category.categoryId,
                                        ),
                                  ),
                                ),
                                ProductItem(
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
                                  onDelete: () => context
                                      .read<ShoppingListCubit>()
                                      .deleteProduct(productId: item.productId),
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
                                          ? const Text(
                                              'The product was removed from '
                                              'Favorites successfully!')
                                          : const Text('The product was add to '
                                              'Favorites successfully!'),
                                    ),
                                  );
                                }
                              },
                              onDelete: () => context
                                  .read<ShoppingListCubit>()
                                  .deleteProduct(productId: item.productId),
                            );
                          }
                        },
                        itemCount: state.items.length,
                      ),
              ),
            ],
          ),
        );
      case ListStatus.loading:
        return const Center(child: CircularProgressIndicator());
    }
  }
}
