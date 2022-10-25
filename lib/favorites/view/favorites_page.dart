import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_repository/products_repository.dart';
import 'package:thrive_shop/favorites/cubit/favorites_cubit.dart';
import 'package:thrive_shop/favorites/view/favorites_list_content.dart';

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
              FavoritesListContent(items: state.items),
            ],
          ),
        );
      case FavoritesStatus.loading:
        return const Center(child: CircularProgressIndicator());
    }
  }
}
