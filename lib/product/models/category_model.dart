import 'package:firebase_products_api/firebase_products_api.dart';
import 'package:formz/formz.dart';

enum CategoryModelValidationError { invalid }

class CategoryModelInput
    extends FormzInput<CategoryModel, CategoryModelValidationError> {
  const CategoryModelInput.pure([
    super.value = const CategoryModel(
      color: 0xFF006783,
      category: 'Others',
    ),
  ]) : super.pure();

  const CategoryModelInput.dirty([
    super.value = const CategoryModel(
      color: 0xFF006783,
      category: 'Others',
    ),
  ]) : super.dirty();

  @override
  CategoryModelValidationError? validator(CategoryModel? value) {
    return value != null ? null : CategoryModelValidationError.invalid;
  }
}
