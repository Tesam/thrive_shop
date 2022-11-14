import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:products_repository/products_repository.dart';
import 'package:thrive_shop/product/models/models.dart';

part 'category_form_state.dart';

class CategoryFormCubit extends Cubit<CategoryFormState> {
  CategoryFormCubit({required this.repository})
      : super(const CategoryFormState());

  final ProductsRepository repository;

  void onCategoryChanged(String value) {
    final category = CategoryInput.dirty(value);
    emit(
      state.copyWith(
        category: category.valid ? category : CategoryInput.pure(value),
        status: Formz.validate([category, state.color]),
      ),
    );
  }

  void onColorChanged(int value) {
    final color = ColorInput.dirty(value);
    emit(
      state.copyWith(
        color: color.valid ? color : ColorInput.pure(value),
        status: Formz.validate([color,]),
      ),
    );
  }

  void onCategoryUnfocused() {
    final category = CategoryInput.dirty(state.category.value);
    emit(
      state.copyWith(
        category: category,
        status: Formz.validate([category, state.color]),
      ),
    );
  }

  Future<void> onSubmit() async {
    final category = CategoryInput.dirty(state.category.value);
    final color = ColorInput.dirty(state.color.value);

    emit(
      state.copyWith(
        category: category,
        color: color,
        status: Formz.validate([category, color]),
      ),
    );

    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        await repository.createCategory(
          category: Category(
            category: state.category.value,
            color: state.color.value,
          ),
        );

        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } on Exception {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }
}
