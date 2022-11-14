import 'package:formz/formz.dart';

enum ImageUrlValidationError { invalid }

class ImageUrlInput extends FormzInput<String, ImageUrlValidationError> {
  const ImageUrlInput.pure([super.value = '']) : super.pure();
  const ImageUrlInput.dirty([super.value = '']) : super.dirty();

  @override
  ImageUrlValidationError? validator(String? value) {
    if (value != null) {
      if (value.isNotEmpty) {
        return null;
      } else {
        return ImageUrlValidationError.invalid;
      }
    } else {
      return ImageUrlValidationError.invalid;
    }
  }
}
