import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:products_repository/products_repository.dart';
import 'package:thrive_shop/product/cubit/category_form_cubit.dart';
import 'package:thrive_shop/product/models/category_input.dart';
import 'package:thrive_shop/product/models/color_input.dart';

class ProductsRepositoryMock extends Mock implements ProductsRepository {}

void main() {
  group('CategoryFormCubit', () {
    late ProductsRepositoryMock productsRepositoryMock;
    late CategoryFormCubit categoryFormCubit;

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
      expect(categoryFormCubit.state, const CategoryFormState());
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
          status: FormzStatus.valid,
        )
      ],
    );

    blocTest(
      'the cubit should emit a CategoryFormState(category: ,'
      ' color:0xFF006711, state:FormzStatus.valid) when onColorChange()'
      ' is called',
      build: () => categoryFormCubit,
      act: (cubit) => cubit.onColorChanged(0xFF006711),
      expect: () => [
        const CategoryFormState(
          color: ColorInput.dirty(0xFF006711),
          status: FormzStatus.valid,
        )
      ],
    );

    blocTest(
      'the cubit should emit a CategoryFormState(category: , '
      'color:0xFF006711, state:FormzStatus.valid) when '
      'onCategoryUnfocused()is called',
      build: () => categoryFormCubit,
      act: (cubit) {
        cubit
          ..onCategoryChanged('Category 2')
          ..onCategoryUnfocused();
      },
      expect: () => [
        const CategoryFormState(
          category: CategoryInput.dirty('Category 2'),
          status: FormzStatus.valid,
        )
      ],
    );
  });
}
