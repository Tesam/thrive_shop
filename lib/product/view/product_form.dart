import 'package:firebase_products_api/firebase_products_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:products_repository/products_repository.dart';
import 'package:thrive_shop/color_schemes.g.dart';
import 'package:thrive_shop/product/cubit/product_form_cubit.dart';
import 'package:thrive_shop/product/models/product_input.dart';
import 'package:thrive_shop/widgets/widgets.dart';

class ProductForm extends StatelessWidget {
  const ProductForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductFormCubit(
        repository: context.read<ProductsRepository>(),
      )..getCategories(),
      child: const ProductFormContent(),
    );
  }
}

class ProductFormContent extends StatefulWidget {
  const ProductFormContent({super.key});

  @override
  ProductFormContentState createState() => ProductFormContentState();
}

class ProductFormContentState extends State<ProductFormContent> {
  final _productFocusNode = FocusNode();

  //Category dropdownValue = list.first;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<ProductFormCubit>();
    _productFocusNode.addListener(() {
      if (!_productFocusNode.hasFocus) {
        cubit.onProductUnfocused();
      }
    });
  }

  @override
  void dispose() {
    _productFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductFormCubit, ProductFormState>(
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
                  'Product added successfully',
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
                  'Oops the product cannot be added',
                ),
                backgroundColor: AppColors.lightColorScheme.error,
              ),
            );
        }
      },
      child: BlocBuilder<ProductFormCubit, ProductFormState>(
        builder: (context, state) {
          if (state.status == FormzStatus.submissionInProgress) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Column(
              children: [
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      CSMTextField(
                        text: 'Product name',
                        focusNode: _productFocusNode,
                        onChanged:
                            context.read<ProductFormCubit>().onProductChanged,
                        errorText: (state.product.error ==
                                ProductValidationError.invalid)
                            ? "The product can't be empty"
                            : null,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: AppColors.lightColorScheme.primaryContainer,
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<CategoryModel>(
                            value: state.category.value,
                            icon: const Icon(Icons.expand_more),
                            elevation: 16,
                            isExpanded: true,
                            menuMaxHeight: 300,
                            style: TextStyle(
                                color: AppColors
                                    .lightColorScheme.onPrimaryContainer),
                            onChanged: (CategoryModel? value) => context
                                .read<ProductFormCubit>()
                                .onCategoryChanged(value!),
                            items: state.items
                                .map<DropdownMenuItem<CategoryModel>>(
                                    (CategoryModel value) {
                              return DropdownMenuItem<CategoryModel>(
                                value: value,
                                child: Text(value.category),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                CSMButton(
                  onPressed: () => context.read<ProductFormCubit>().onSubmit(),
                  title: 'Add Product',
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
