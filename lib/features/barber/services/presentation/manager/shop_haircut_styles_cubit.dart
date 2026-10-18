import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/get_shop_haircut_styles_use_case.dart';
import '../../domain/use_cases/update_shop_haircut_style_use_case.dart';
import 'shop_haircut_styles_state.dart';

class ShopHaircutStylesCubit extends Cubit<ShopHaircutStylesState> {
  final GetShopHaircutStylesUseCase _getHaircutStyles;
  final UpdateShopHaircutStyleUseCase _updateHaircutStyle;

  ShopHaircutStylesCubit(this._getHaircutStyles, this._updateHaircutStyle)
    : super(const ShopHaircutStylesState());

  Future<void> loadHaircutStyles() async {
    emit(state.copyWith(status: ShopHaircutStylesStatus.loading));

    final result = await _getHaircutStyles();

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: ShopHaircutStylesStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (styles) => emit(
        state.copyWith(status: ShopHaircutStylesStatus.success, styles: styles),
      ),
    );
  }

  Future<bool> updatePriceDelta(
    int id, {
    required int priceDelta,
    required bool active,
  }) async {
    emit(state.copyWith(isSubmitting: true));

    final result = await _updateHaircutStyle(
      id,
      priceDelta: priceDelta,
      active: active,
    );

    return result.fold(
      (failure) {
        emit(
          state.copyWith(isSubmitting: false, errorMessage: failure.message),
        );
        return false;
      },
      (updated) {
        emit(
          state.copyWith(
            isSubmitting: false,
            styles: [
              for (final style in state.styles)
                if (style.id == updated.id) updated else style,
            ],
          ),
        );
        return true;
      },
    );
  }
}
