import 'package:formz/formz.dart';

enum ColorValidationError { invalid }

class ColorInput extends FormzInput<int, ColorValidationError> {
  const ColorInput.pure([super.value = 0xFF006783]) : super.pure();
  const ColorInput.dirty([super.value = 0xFF006783]) : super.dirty();

  @override
  ColorValidationError? validator(int? value) {
    return value != null ? null : ColorValidationError.invalid;
  }
}
