import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/requests/barber_discount_request.dart';
import '../../domain/entities/barber_discount.dart';
import '../../domain/use_cases/close_barber_discount_use_case.dart';
import '../../domain/use_cases/create_barber_discount_use_case.dart';
import '../../domain/use_cases/get_barber_discount_by_id_use_case.dart';
import '../../domain/use_cases/get_barber_discounts_use_case.dart';
import '../../domain/use_cases/update_barber_discount_use_case.dart';
import 'barber_discounts_state.dart';

class BarberDiscountsCubit extends Cubit<BarberDiscountsState> {
  final GetBarberDiscountsUseCase _getDiscounts;
  final GetBarberDiscountByIdUseCase _getDiscountById;
  final CreateBarberDiscountUseCase _createDiscount;
  final UpdateBarberDiscountUseCase _updateDiscount;
  final CloseBarberDiscountUseCase _closeDiscount;

  BarberDiscountsCubit(
    this._getDiscounts,
    this._getDiscountById,
    this._createDiscount,
    this._updateDiscount,
    this._closeDiscount,
  ) : super(const BarberDiscountsState());

  Future<void> loadDiscounts() async {
    emit(state.copyWith(status: BarberDiscountsStatus.loading));

    final result = await _getDiscounts();

    result.fold(
      (failure) => emit(state.copyWith(
        status: BarberDiscountsStatus.failure,
        errorMessage: failure.message,
      )),
      (discounts) => emit(state.copyWith(
        status: BarberDiscountsStatus.success,
        discounts: discounts,
      )),
    );
  }

  Future<BarberDiscount?> refreshDiscount(int id) async {
    final result = await _getDiscountById(id);

    return result.fold((failure) => null, (discount) {
      final exists = state.discounts.any((d) => d.id == id);
      emit(state.copyWith(
        discounts: exists
            ? state.discounts.map((d) => d.id == id ? discount : d).toList()
            : [...state.discounts, discount],
      ));
      return discount;
    });
  }

  Future<bool> createDiscount(BarberDiscountRequest request) async {
    emit(state.copyWith(isSubmitting: true));

    final result = await _createDiscount(request);

    return result.fold(
      (failure) {
        emit(state.copyWith(isSubmitting: false, errorMessage: failure.message));
        return false;
      },
      (discount) {
        emit(state.copyWith(
          isSubmitting: false,
          discounts: [discount, ...state.discounts],
        ));
        return true;
      },
    );
  }

  Future<bool> updateDiscount(int id, BarberDiscountRequest request) async {
    emit(state.copyWith(isSubmitting: true));

    final result = await _updateDiscount(id, request);

    return result.fold(
      (failure) {
        emit(state.copyWith(isSubmitting: false, errorMessage: failure.message));
        return false;
      },
      (discount) {
        emit(state.copyWith(
          isSubmitting: false,
          discounts: state.discounts.map((d) => d.id == discount.id ? discount : d).toList(),
        ));
        return true;
      },
    );
  }

  Future<void> closeDiscount(int id) async {
    if (state.isSubmitting) return;
    emit(state.copyWith(isSubmitting: true));

    final result = await _closeDiscount(id);

    await result.fold(
      (failure) async => emit(
        state.copyWith(isSubmitting: false, errorMessage: failure.message),
      ),
      (_) async {
        emit(state.copyWith(isSubmitting: false));
        await loadDiscounts();
      },
    );
  }
}
