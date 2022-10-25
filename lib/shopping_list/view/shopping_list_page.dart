import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_repository/products_repository.dart';
import 'package:thrive_shop/shopping_list/cubit/shopping_list_cubit.dart';
import 'package:thrive_shop/shopping_list/view/product_list_content.dart';
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
              ProductListContent(items: state.items),
            ],
          ),
        );
      case ListStatus.loading:
        return const Center(child: CircularProgressIndicator());
    }
  }
}
