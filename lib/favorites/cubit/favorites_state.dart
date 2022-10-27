part of 'favorites_cubit.dart';

enum FavoritesStatus { loading, success, failure }

class FavoritesState extends Equatable {
  const FavoritesState._({
    this.status = FavoritesStatus.loading,
    this.items = const <List<Product>>[],
  });

  const FavoritesState.loading() : this._();

  const FavoritesState.success(List<List<Product>> items)
      : this._(status: FavoritesStatus.success, items: items);

  const FavoritesState.failure() : this._(status: FavoritesStatus.failure);

  final FavoritesStatus status;
  final List<List<Product>> items;

  @override
  List<Object> get props => [status, items];
}
