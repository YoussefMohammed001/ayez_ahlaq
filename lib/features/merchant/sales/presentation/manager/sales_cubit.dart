import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/sale.dart';
import '../../domain/use_cases/cancel_sale_use_case.dart';
import '../../domain/use_cases/get_sales_use_case.dart';
import 'sales_state.dart';

class SalesCubit extends Cubit<SalesState> {
  static const _pageSize = 20;

  final GetSalesUseCase _getSales;
  final CancelSaleUseCase _cancelSale;

  SalesCubit(this._getSales, this._cancelSale) : super(const SalesState());

  Future<void> load() async {
    emit(state.copyWith(status: SalesStatus.loading));
    await refresh();
  }

  Future<void> refresh() async {
    final result = await _getSales(page: 0, size: _pageSize);

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: SalesStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (page) => emit(
        state.copyWith(
          status: SalesStatus.success,
          sales: page.sales,
          page: page.page,
          hasMore: page.hasMore,
        ),
      ),
    );
  }

  Future<void> loadMore() async {
    if (!state.hasMore || state.isLoadingMore) return;

    emit(state.copyWith(isLoadingMore: true));

    final result = await _getSales(page: state.page + 1, size: _pageSize);

    result.fold(
      (failure) => emit(
        state.copyWith(isLoadingMore: false, errorMessage: failure.message),
      ),
      (page) => emit(
        state.copyWith(
          sales: [...state.sales, ...page.sales],
          page: page.page,
          hasMore: page.hasMore,
          isLoadingMore: false,
        ),
      ),
    );
  }

  Future<Sale?> cancel(int id) async {
    emit(state.copyWith(isSubmitting: true));

    final result = await _cancelSale(id);

    return result.fold(
      (failure) {
        emit(
          state.copyWith(isSubmitting: false, errorMessage: failure.message),
        );
        return null;
      },
      (cancelled) {
        emit(
          state.copyWith(
            isSubmitting: false,
            sales: [for (final s in state.sales) s.id == id ? cancelled : s],
          ),
        );
        return cancelled;
      },
    );
  }
}
