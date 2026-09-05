import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../favorites/domain/use_cases/add_favorite_use_case.dart';
import '../../../favorites/domain/use_cases/remove_favorite_use_case.dart';
import '../../domain/use_cases/get_shop_detail_use_case.dart';
import 'customer_shop_detail_state.dart';

class CustomerShopDetailCubit extends Cubit<CustomerShopDetailState> {
  final GetShopDetailUseCase _getShopDetail;
  final AddFavoriteUseCase _addFavorite;
  final RemoveFavoriteUseCase _removeFavorite;

  CustomerShopDetailCubit(this._getShopDetail, this._addFavorite, this._removeFavorite)
    : super(const CustomerShopDetailState());

  Future<void> loadShopDetail(int shopId) async {
    emit(state.copyWith(status: CustomerShopDetailStatus.loading));

    final result = await _getShopDetail(shopId);

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: CustomerShopDetailStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (detail) => emit(
        state.copyWith(status: CustomerShopDetailStatus.success, detail: detail),
      ),
    );
  }

  Future<void> toggleFavorite(int barberId, bool currentlyFavorite) async {
    final detail = state.detail;
    if (detail == null) return;

    final updatedBarbers = detail.barbers
        .map((b) => b.id == barberId ? b.copyWith(favorite: !currentlyFavorite) : b)
        .toList();
    emit(state.copyWith(detail: detail.copyWith(barbers: updatedBarbers)));

    final result = currentlyFavorite
        ? await _removeFavorite(barberId)
        : await _addFavorite(barberId);

    result.fold((failure) {
      final revertedBarbers = detail.barbers
          .map((b) => b.id == barberId ? b.copyWith(favorite: currentlyFavorite) : b)
          .toList();
      emit(
        state.copyWith(
          detail: detail.copyWith(barbers: revertedBarbers),
          errorMessage: failure.message,
        ),
      );
    }, (_) {});
  }
}
