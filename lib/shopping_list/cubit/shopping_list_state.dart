part of 'shopping_list_cubit.dart';

enum ListStatus { loading, success, failure }

class ShoppingListState extends Equatable {
  const ShoppingListState._({
    this.status = ListStatus.loading,
    this.items = const [],
  });

  const ShoppingListState.loading() : this._();

  const ShoppingListState.success(List<List<Product>> items)
      : this._(status: ListStatus.success, items: items);

  const ShoppingListState.failure() : this._(status: ListStatus.failure);

  final ListStatus status;
  final List<List<Product>> items;

  @override
  List<Object> get props => [status, items];
}
