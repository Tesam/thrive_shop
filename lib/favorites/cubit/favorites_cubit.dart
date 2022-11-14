import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:products_repository/products_repository.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit({required this.repository})
      : super(const FavoritesState.loading());

  final ProductsRepository repository;
  late StreamSubscription<dynamic> itemsSubscription;

  void fetchList() {
    try {
      itemsSubscription = repository.getFavorites().listen((items) {
        final itemMap = groupBy(items, (Product obj) => obj.category.category);
        final itemsList = <List<Product>>[];

        itemMap.entries.map((e) {
          itemsList.add(e.value);
        }).toList();

        emit(FavoritesState.success(itemsList));
      });

      /*  itemsSubscription = repository.getFavorites().listen((items) {
        emit(FavoritesState.success(items));
      });*/
    } on Exception {
      emit(const FavoritesState.failure());
    }
  }

  bool setFavoriteState({required bool isFavorite, required String productId}) {
    try {
      if (isFavorite) {
        repository.removeFromFavorite(productId: productId);
      } else {
        repository.addToFavorite(productId: productId);
      }
      return true;
    } on Exception {
      emit(const FavoritesState.failure());
      return false;
    }
  }

  @override
  Future<void> close() {
    itemsSubscription.cancel();
    return super.close();
  }

/* Future<void> deleteItem(String id) async {
    final deleteInProgress = state.items.map((item) {
      return item.id == id ? item.copyWith(isDeleting: true) : item;
    }).toList();

    emit(ComplexListState.success(deleteInProgress));

    unawaited(
      repository.deleteItem(id).then((_) {
        final deleteSuccess = List.of(state.items)
          ..removeWhere((element) => element.id == id);
        emit(ComplexListState.success(deleteSuccess));
      }),
    );
  }*/
}
