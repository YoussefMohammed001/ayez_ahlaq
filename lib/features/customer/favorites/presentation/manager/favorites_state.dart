import 'package:equatable/equatable.dart';
import '../../domain/entities/favorite_barber.dart';

enum FavoritesStatus { initial, loading, success, failure }

class FavoritesState extends Equatable {
  final FavoritesStatus status;
  final List<FavoriteBarber> favorites;
  final int? removingBarberId;
  final String? errorMessage;

  const FavoritesState({
    this.status = FavoritesStatus.initial,
    this.favorites = const [],
    this.removingBarberId,
    this.errorMessage,
  });

  FavoritesState copyWith({
    FavoritesStatus? status,
    List<FavoriteBarber>? favorites,
    int? removingBarberId,
    String? errorMessage,
    bool clearRemovingBarberId = false,
  }) {
    return FavoritesState(
      status: status ?? this.status,
      favorites: favorites ?? this.favorites,
      removingBarberId: clearRemovingBarberId ? null : (removingBarberId ?? this.removingBarberId),
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, favorites, removingBarberId, errorMessage];
}
