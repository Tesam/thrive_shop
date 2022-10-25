import 'package:firebase_products_api/firebase_products_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_repository/products_repository.dart';
import 'package:thrive_shop/color_schemes.g.dart';
import 'package:thrive_shop/product/cubit/category_form_cubit.dart';
import 'package:thrive_shop/widgets/csm_text_field.dart';

class CategoryForm extends StatelessWidget {
  const CategoryForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CategoryFormCubit(
        repository: context.read<ProductsRepository>(),
      ),
      child: CategoryFormContent(),
    );
  }
}

class CategoryFormContent extends StatelessWidget {
  CategoryFormContent({super.key});

  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<CategoryFormCubit, CategoryFormState>(
      listener: (context, state) {
        if (state.status == CategoryFormStatus.success) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: const Text(
                  'Category added successfully',
                ),
                backgroundColor: AppColors.lightColorScheme.secondary,
              ),
            );
        }

        if (state.status == CategoryFormStatus.failure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: const Text(
                  'Oops the category cannot be added',
                ),
                backgroundColor: AppColors.lightColorScheme.error,
              ),
            );
        }
      },
      child: Column(
        children: [
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                CSMTextField(
                  textEditingController: _categoryController,
                  text: 'Category name',
                ),
                const SizedBox(
                  height: 10,
                ),
                CSMTextField(
                  textEditingController: _colorController,
                  text: 'Color',
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () => context.read<CategoryFormCubit>().addCategory(
                  category: CategoryModel(
                    category: _categoryController.text,
                    color: 0xFFF3F3,
                  ),
                ),
            child: const Text(
              'Add Category',
            ),
          )
        ],
      ),
    );
  }
}
