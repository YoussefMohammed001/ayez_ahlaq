import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/sale.dart';
import '../../domain/entities/sale_draft.dart';
import '../../domain/entities/sale_line.dart';
import '../../domain/use_cases/create_sale_use_case.dart';
import '../../domain/use_cases/get_sale_payment_methods_use_case.dart';
import 'new_sale_state.dart';

class NewSaleCubit extends Cubit<NewSaleState> {
  final CreateSaleUseCase _createSale;
  final GetSalePaymentMethodsUseCase _getMethods;

  NewSaleCubit(this._createSale, this._getMethods)
    : super(const NewSaleState());

  Future<void> loadMethods() async {
    final result = await _getMethods();

    result.fold((_) {}, (methods) => emit(state.copyWith(methods: methods)));
  }

  void setQuantity(int productId, int quantity) {
    final updated = {...state.quantities};

    if (quantity <= 0) {
      updated.remove(productId);
    } else {
      updated[productId] = quantity;
    }

    emit(state.copyWith(quantities: updated));
  }

  void selectMethod(String code) {
    emit(
      state.paymentMethod == code
          ? state.copyWith(clearPaymentMethod: true)
          : state.copyWith(paymentMethod: code),
    );
  }

  Future<Sale?> submit({
    String? customerName,
    String? customerPhone,
    double discount = 0,
    String? note,
  }) async {
    emit(state.copyWith(isSubmitting: true));

    final result = await _createSale(
      SaleDraft(
        lines: [
          for (final entry in state.quantities.entries)
            SaleLine(productId: entry.key, quantity: entry.value),
        ],
        customerName: customerName,
        customerPhone: customerPhone,
        paymentMethod: state.paymentMethod,
        discount: discount,
        note: note,
      ),
    );

    return result.fold(
      (failure) {
        emit(
          state.copyWith(isSubmitting: false, errorMessage: failure.message),
        );
        return null;
      },
      (sale) {
        emit(state.copyWith(isSubmitting: false));
        return sale;
      },
    );
  }
}
