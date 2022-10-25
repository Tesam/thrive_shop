import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:products_repository/products_repository.dart';

part 'favorites_state.dart';

class FavoriteListCubit extends Cubit<FavoritesState> {
  FavoriteListCubit({required this.repository})
      : super(const FavoritesState.loading());

  final ProductsRepository repository;

  void fetchList() {
    try {
      repository.getFavorites().listen((items) {
        emit(FavoritesState.success(items));
      });
    } on Exception {
      emit(const FavoritesState.failure());
    }
  }

  bool setFavoriteState({required bool isFavorite, required String productId}) {
    try {
      if(isFavorite){
        repository.removeFromFavorite(productId: productId);
      }else{
        repository.addToFavorite(productId: productId);
      }
      return true;
    } on Exception {
      emit(const FavoritesState.failure());
      return false;
    }
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
