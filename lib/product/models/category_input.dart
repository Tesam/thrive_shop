import 'package:formz/formz.dart';

enum CategoryValidationError { invalid }

class CategoryInput extends FormzInput<String, CategoryValidationError> {
  const CategoryInput.pure([super.value = '']) : super.pure();
  const CategoryInput.dirty([super.value = '']) : super.dirty();

  @override
  CategoryValidationError? validator(String? value) {
    if (value != null) {
      if (value.isNotEmpty) {
        return null;
      } else {
        return CategoryValidationError.invalid;
      }
    } else {
      return CategoryValidationError.invalid;
    }
  }
}
