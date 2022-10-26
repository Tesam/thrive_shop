import 'package:formz/formz.dart';

enum ProductValidationError { invalid }

class ProductInput extends FormzInput<String, ProductValidationError> {
  const ProductInput.pure([super.value = '']) : super.pure();
  const ProductInput.dirty([super.value = '']) : super.dirty();

  @override
  ProductValidationError? validator(String? value) {
    if(value != null){
      if(value.isNotEmpty){
        return null;
      }else{
        return ProductValidationError.invalid;
      }
    }else{
      return ProductValidationError.invalid;
    }
  }
}
