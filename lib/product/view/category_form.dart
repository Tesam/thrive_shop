import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:products_repository/products_repository.dart';
import 'package:thrive_shop/color_schemes.g.dart';
import 'package:thrive_shop/product/cubit/category_form_cubit.dart';
import 'package:thrive_shop/product/models/category_input.dart';
import 'package:thrive_shop/product/widgets/widgets.dart';
import 'package:thrive_shop/widgets/widgets.dart';

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
  CategoryFormContentState createState() => CategoryFormContentState();
}

class CategoryFormContentState extends State<CategoryFormContent> {
  final _categoryFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    final cubit = context.read<CategoryFormCubit>();
    _categoryFocusNode.addListener(() {
      if (!_categoryFocusNode.hasFocus) {
        cubit.onCategoryUnfocused();
      }
    });
  }

  @override
  void dispose() {
    _categoryFocusNode.dispose();
    super.dispose();
  }

  void changeColor(Color color) {
    context.read<CategoryFormCubit>().onColorChanged(color.value);
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CategoryFormCubit>().state;

    return BlocListener<CategoryFormCubit, CategoryFormState>(
      listener: (context, state) {
        if (state.status == FormzStatus.invalid) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(
                  'Please, fill the empty fields',
                  style: TextStyle(
                    color: AppColors.lightColorScheme.onPrimaryContainer,
                  ),
                ),
                backgroundColor: AppColors.lightColorScheme.primaryContainer,
              ),
            );
        }

        if (state.status == FormzStatus.submissionSuccess) {
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

        if (state.status == FormzStatus.submissionFailure) {
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
                  text: 'Category name',
                  focusNode: _categoryFocusNode,
                  onChanged:
                      context.read<CategoryFormCubit>().onCategoryChanged,
                  errorText:
                      (state.category.error == CategoryValidationError.invalid)
                          ? "The category can't be empty"
                          : null,
                ),
                const SizedBox(
                  height: 15,
                ),
                ColorPickerContainer(
                  pickerColor: Color(state.color.value),
                  onColorChanged: changeColor,
                )
              ],
            ),
          ),
          CSMButton(
            onPressed: () => context.read<CategoryFormCubit>().onSubmit(),
            title: 'Add Category',
          ),
        ],
      ),
    );
  }
}
