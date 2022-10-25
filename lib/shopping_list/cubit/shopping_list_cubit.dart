import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:products_repository/products_repository.dart';

part 'shopping_list_state.dart';

class ShoppingListCubit extends Cubit<ShoppingListState> {
  ShoppingListCubit({required this.repository})
      : super(const ShoppingListState.loading());

  final ProductsRepository repository;
  late StreamSubscription<dynamic> itemsSubscription;

  void fetchList() {
    try {
      itemsSubscription = repository.getProducts().listen((items) {
        emit(ShoppingListState.success(items));
      });
    } on Exception {
      emit(const ShoppingListState.failure());
    }
  }

  void searchList(String query) {
    try {
      final productSearchList = <Product>[];
      productSearchList.addAll(state.items);

      if (query.isNotEmpty) {
        final productListData = <Product>[];
        for (final item in productSearchList) {
          if (item.product.contains(query) ||
              item.category.category.contains(query)) {
            productListData.add(item);
          }
        }

        emit(ShoppingListState.success(productListData));
        return;
      } else {
        fetchList();
      }
    } on Exception {
      emit(const ShoppingListState.failure());
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
      emit(const ShoppingListState.failure());
      return false;
    }
  }

  void deleteProduct({required String productId}) {
    try {
      repository.deleteProduct(productId: productId);
    } on Exception {
      emit(const ShoppingListState.failure());
    }
  }

  void deleteCategory({required String categoryId}) {
    try {
      repository.deleteCategory(categoryId: categoryId);
    } on Exception {
      emit(const ShoppingListState.failure());
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
