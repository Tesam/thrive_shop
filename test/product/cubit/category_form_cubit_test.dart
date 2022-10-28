import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:products_repository/products_repository.dart';
import 'package:thrive_shop/product/cubit/category_form_cubit.dart';
import 'package:thrive_shop/product/models/category_input.dart';

class ProductsRepositoryMock extends Mock implements ProductsRepository {}

void main() {
  group('CategoryFormCubit', () {
    late ProductsRepositoryMock productsRepositoryMock;
    late CategoryFormCubit categoryFormCubit;

    const categoryFormState = CategoryFormState();

    setUp(() {
      productsRepositoryMock = ProductsRepositoryMock();
      categoryFormCubit = CategoryFormCubit(repository: productsRepositoryMock);
    });

    tearDown(() {
      categoryFormCubit.close();
    });

    test(
        'The initial state is CategoryFormState'
        ' (category: , color:0xFF006783, state:FormzStatus.pure)', () {
      expect(categoryFormCubit.state, categoryFormState);
    });


    blocTest(
        'the cubit should emit a CategoryFormState(category:Category1,'
        ' color:0xFF006783, state:FormzStatus.valid) when onCategoryChange()'
        ' is called',
        build: () => categoryFormCubit,
        act: (cubit) => cubit.onCategoryChanged('Category 1'),
        expect: () => [
          const CategoryFormState(
              category: CategoryInput.dirty('Category 1'),
              status: FormzStatus.valid,)
        ],);
  });
}
