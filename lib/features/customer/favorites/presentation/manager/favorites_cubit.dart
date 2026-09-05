import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/get_favorites_use_case.dart';
import '../../domain/use_cases/remove_favorite_use_case.dart';
import 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final GetFavoritesUseCase _getFavorites;
  final RemoveFavoriteUseCase _removeFavorite;

  FavoritesCubit(this._getFavorites, this._removeFavorite) : super(const FavoritesState());

  Future<void> loadFavorites() async {
    emit(state.copyWith(status: FavoritesStatus.loading));

    final result = await _getFavorites();

    result.fold(
      (failure) => emit(
        state.copyWith(status: FavoritesStatus.failure, errorMessage: failure.message),
      ),
      (favorites) => emit(state.copyWith(status: FavoritesStatus.success, favorites: favorites)),
    );
  }

  Future<void> removeFavorite(int barberId) async {
    emit(state.copyWith(removingBarberId: barberId));

    final result = await _removeFavorite(barberId);

    result.fold(
      (failure) => emit(
        state.copyWith(clearRemovingBarberId: true, errorMessage: failure.message),
      ),
      (_) => emit(
        state.copyWith(
          clearRemovingBarberId: true,
          favorites: state.favorites.where((f) => f.barberId != barberId).toList(),
        ),
      ),
    );
  }
}
