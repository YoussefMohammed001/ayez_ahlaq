import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/requests/discount_request.dart';
import '../../domain/use_cases/close_discount_use_case.dart';
import '../../domain/use_cases/create_discount_use_case.dart';
import '../../domain/use_cases/update_discount_use_case.dart';
import '../../domain/use_cases/get_discount_shops_use_case.dart';
import '../../domain/use_cases/get_discounts_use_case.dart';
import 'merchant_discounts_state.dart';

class MerchantDiscountsCubit extends Cubit<MerchantDiscountsState> {
  final GetDiscountsUseCase _getDiscounts;
  final GetDiscountShopsUseCase _getShops;
  final CreateDiscountUseCase _createDiscount;
  final UpdateDiscountUseCase _updateDiscount;
  final CloseDiscountUseCase _closeDiscount;

  MerchantDiscountsCubit(
    this._getDiscounts,
    this._getShops,
    this._createDiscount,
    this._updateDiscount,
    this._closeDiscount,
  ) : super(const MerchantDiscountsState());

  Future<void> loadDiscounts() async {
    emit(state.copyWith(status: DiscountsStatus.loading));

    final result = await _getDiscounts();

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: DiscountsStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (discounts) => emit(
        state.copyWith(status: DiscountsStatus.success, discounts: discounts),
      ),
    );
  }

  Future<void> loadShops() async {
    final result = await _getShops();
    result.map((shops) => emit(state.copyWith(shops: shops)));
  }

  Future<bool> createDiscount(DiscountRequest request) async {
    emit(state.copyWith(isSubmitting: true));

    final result = await _createDiscount(request);

    return result.fold(
      (failure) {
        emit(
          state.copyWith(isSubmitting: false, errorMessage: failure.message),
        );
        return false;
      },
      (discount) {
        emit(
          state.copyWith(
            isSubmitting: false,
            discounts: [discount, ...state.discounts],
          ),
        );
        return true;
      },
    );
  }

  Future<bool> updateDiscount(int id, DiscountRequest request) async {
    emit(state.copyWith(isSubmitting: true));

    final result = await _updateDiscount(id, request);

    return result.fold(
      (failure) {
        emit(
          state.copyWith(isSubmitting: false, errorMessage: failure.message),
        );
        return false;
      },
      (discount) {
        emit(
          state.copyWith(
            isSubmitting: false,
            discounts: state.discounts
                .map((d) => d.id == discount.id ? discount : d)
                .toList(),
          ),
        );
        return true;
      },
    );
  }

  Future<void> closeDiscount(int id) async {
    final result = await _closeDiscount(id);

    await result.fold(
      (failure) async =>
          emit(state.copyWith(errorMessage: failure.message)),
      (_) => loadDiscounts(),
    );
  }
}
