import 'package:firebase_products_api/firebase_products_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_repository/products_repository.dart';
import 'package:thrive_shop/color_schemes.g.dart';
import 'package:thrive_shop/product/cubit/category_form_cubit.dart';
import 'package:thrive_shop/product/widgets/widgets.dart';
import 'package:thrive_shop/widgets/csm_text_field.dart';

class CategoryForm extends StatelessWidget {
  const CategoryForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CategoryFormCubit(
        repository: context.read<ProductsRepository>(),
      ),
      child: const CategoryFormContent(),
    );
  }
}

class CategoryFormContent extends StatefulWidget {
  const CategoryFormContent({super.key});

  @override
  _CategoryFormContentState createState() => _CategoryFormContentState();
}

class _CategoryFormContentState extends State<CategoryFormContent> {
  final TextEditingController _categoryController = TextEditingController();
  Color currentColor = AppColors.lightColorScheme.secondary;

  void changeColor(Color color) => setState(() => currentColor = color);

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
                  height: 15,
                ),
                ColorPickerContainer(
                  pickerColor: currentColor,
                  onColorChanged: changeColor,
                )
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () => context.read<CategoryFormCubit>().addCategory(
                  category: CategoryModel(
                    category: _categoryController.text,
                    color: currentColor.value,
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
