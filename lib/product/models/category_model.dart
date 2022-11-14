import 'package:formz/formz.dart';
import 'package:products_api/products_api.dart';

enum CategoryModelValidationError { invalid }

class CategoryModelInput
    extends FormzInput<Category, CategoryModelValidationError> {
  const CategoryModelInput.pure([
    super.value = const Category(
      color: 0xFF006783,
      category: 'Others',
    ),
  ]) : super.pure();

  const CategoryModelInput.dirty([
    super.value = const Category(
      color: 0xFF006783,
      category: 'Others',
    ),
  ]) : super.dirty();

  @override
  CategoryModelValidationError? validator(Category? value) {
    return value != null ? null : CategoryModelValidationError.invalid;
  }
}
