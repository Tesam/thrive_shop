import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
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
        final itemMap = groupBy(items, (Product obj) => obj.category.category);
        final itemsList = <List<Product>>[];

        itemMap.entries.map((e) {
          itemsList.add(e.value);
        }).toList();

        emit(ShoppingListState.success(itemsList));
      });
    } on Exception {
      emit(const ShoppingListState.failure());
    }
  }

  void searchList(String query) {
    try {
      final productSearchList = <List<Product>>[];
      productSearchList.addAll(state.items);

      if (query.isNotEmpty) {
        final productList = <List<Product>>[];
        for (final items in productSearchList) {
          final productListData = <Product>[];
          for (final item in items) {
            if (item.product.contains(query) ||
                item.category.category.contains(query)) {
              productListData.add(item);
            }
          }
          if (productListData.isNotEmpty) {
            productList.add(productListData);
          }
        }
        emit(ShoppingListState.success(productList));
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
}
