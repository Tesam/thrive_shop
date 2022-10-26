import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_products_api/firebase_products_api.dart';
import 'package:formz/formz.dart';
import 'package:products_repository/products_repository.dart';
import 'package:thrive_shop/product/models/models.dart';

part 'product_form_state.dart';

class ProductFormCubit extends Cubit<ProductFormState> {
  ProductFormCubit({required this.repository})
      : super(const ProductFormState());

  final ProductsRepository repository;

  Future<void> getCategories() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      final categories =
          await repository.getCategories() as List<CategoryModel>;
      final category = CategoryModelInput.dirty(categories.first);
      emit(
        state.copyWith(
          items: categories,
          category: category.valid
              ? category
              : CategoryModelInput.pure(categories.first),
          status: Formz.validate([state.product, state.imageUrl]),
        ),
      );
    } on Exception {
      rethrow;
    }
  }

  void onProductChanged(String value) {
    final product = ProductInput.dirty(value);
    emit(
      state.copyWith(
        product: product.valid ? product : ProductInput.pure(value),
        status: Formz.validate([product, state.category, state.imageUrl]),
      ),
    );
  }

  void onCategoryChanged(CategoryModel value) {
    final category = CategoryModelInput.dirty(value);
    emit(
      state.copyWith(
        category: category.valid ? category : CategoryModelInput.pure(value),
        status: Formz.validate([category, state.product, state.imageUrl]),
      ),
    );
  }

  void onImageUrlChanged(String value) {
    final imageUrl = ImageUrlInput.dirty(value);
    emit(
      state.copyWith(
        imageUrl: imageUrl.valid ? imageUrl : ImageUrlInput.pure(value),
        status: Formz.validate([imageUrl, state.product, state.category]),
      ),
    );
  }

  void onProductUnfocused() {
    final product = ProductInput.dirty(state.product.value);
    emit(
      state.copyWith(
        product: product,
        status: Formz.validate([product, state.category, state.imageUrl]),
      ),
    );
  }

  Future<void> onSubmit() async {
    final product = ProductInput.dirty(state.product.value);
    final category = CategoryModelInput.dirty(state.category.value);
    final imageUrl = ImageUrlInput.dirty(state.imageUrl.value);

    emit(
      state.copyWith(
        product: product,
        category: category,
        imageUrl: imageUrl,
        status: Formz.validate([product, category, imageUrl]),
      ),
    );

    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        print('ENTRE EN EL TRY');
        await repository.createProduct(
          product: ProductModel(
            product: state.product.value,
            category: state.category.value,
            imageUrl: state.imageUrl.value,
          ),
        );

        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } on Exception {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }
}
