part of 'category_form_cubit.dart';

enum CategoryFormStatus { initial, success, failure }

class CategoryFormState extends Equatable {
  const CategoryFormState._({
    this.status = CategoryFormStatus.initial,
    this.category = '',
    this.color = 0,
  });

  const CategoryFormState.initial()
      : this._(status: CategoryFormStatus.initial);

  const CategoryFormState.success()
      : this._(status: CategoryFormStatus.success);

  const CategoryFormState.failure()
      : this._(status: CategoryFormStatus.failure);

  final CategoryFormStatus status;
  final String category;
  final int color;

  @override
  List<Object> get props => [status, category, color];
}
