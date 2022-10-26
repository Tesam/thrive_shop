part of 'category_form_cubit.dart';

class CategoryFormState extends Equatable {
  const CategoryFormState({
    this.category = const CategoryInput.pure(),
    this.color = const ColorInput.pure(),
    this.status = FormzStatus.pure,
  });

  final CategoryInput category;
  final ColorInput color;
  final FormzStatus status;

  CategoryFormState copyWith({
    CategoryInput? category,
    ColorInput? color,
    FormzStatus? status,
  }) {
    return CategoryFormState(
      category: category ?? this.category,
      color: color ?? this.color,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [category, color, status];
}
