import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/analytics/analytics_events.dart';
import '../../../../../core/analytics/analytics_params.dart';
import '../../../../../core/analytics/i_analytics_service.dart';
import '../../../../../shared/location/domain/use_cases/open_in_maps_use_case.dart';
import '../../../favorites/domain/use_cases/add_favorite_use_case.dart';
import '../../../favorites/domain/use_cases/remove_favorite_use_case.dart';
import '../../domain/entities/shop_barber.dart';
import '../../domain/use_cases/get_shop_detail_use_case.dart';
import 'customer_shop_detail_state.dart';

class CustomerShopDetailCubit extends Cubit<CustomerShopDetailState> {
  final GetShopDetailUseCase _getShopDetail;
  final AddFavoriteUseCase _addFavorite;
  final RemoveFavoriteUseCase _removeFavorite;
  final OpenInMapsUseCase _openInMaps;
  final IAnalyticsService _analytics;

  CustomerShopDetailCubit(
    this._getShopDetail,
    this._addFavorite,
    this._removeFavorite,
    this._openInMaps,
    this._analytics,
  ) : super(const CustomerShopDetailState());

  int? _requestedShopId;

  Future<void> loadShopDetail(int shopId, {bool isRefresh = false}) async {
    _requestedShopId = shopId;
    emit(
      isRefresh
          ? state.copyWith(status: CustomerShopDetailStatus.loading)
          : const CustomerShopDetailState(
              status: CustomerShopDetailStatus.loading,
            ),
    );

    final result = await _getShopDetail(shopId);
    if (_requestedShopId != shopId) return;

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: CustomerShopDetailStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (detail) => emit(
        state.copyWith(
          status: CustomerShopDetailStatus.success,
          detail: detail,
        ),
      ),
    );
  }

  Future<void> openShopOnMap() async {
    final location = state.detail?.shop.location;
    if (location == null) return;
    _analytics.logEvent(AnalyticsEvents.shopViewOnMap, {
      AnalyticsParams.shopId: state.detail!.shop.id,
    });
    await _openInMaps(location);
  }

  Future<void> toggleFavorite(int barberId) async {
    final detail = state.detail;
    if (detail == null) return;

    final target = detail.barbers.cast<ShopBarber>().firstWhere(
      (b) => b.id == barberId,
    );
    final currentlyFavorite = target.favorite;

    final updatedBarbers = detail.barbers
        .map(
          (b) =>
              b.id == barberId ? b.copyWith(favorite: !currentlyFavorite) : b,
        )
        .toList();
    emit(state.copyWith(detail: detail.copyWith(barbers: updatedBarbers)));

    final result = currentlyFavorite
        ? await _removeFavorite(barberId)
        : await _addFavorite(barberId);

    result.fold((failure) {
      final revertedBarbers = detail.barbers
          .map(
            (b) =>
                b.id == barberId ? b.copyWith(favorite: currentlyFavorite) : b,
          )
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
