import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:products_repository/products_repository.dart';

part 'category_form_state.dart';

class CategoryFormCubit extends Cubit<CategoryFormState> {
  CategoryFormCubit({required this.repository})
      : super(const CategoryFormState.initial());

  final ProductsRepository repository;

  Future<void> addCategory({required Category category}) async {
    try {
      await repository.createCategory(category: category);
      emit(const CategoryFormState.success());
    } on Exception {
      emit(const CategoryFormState.failure());
    }
  }
}
