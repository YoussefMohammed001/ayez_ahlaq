import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/get_merchant_customers_use_case.dart';
import 'merchant_customers_state.dart';

class MerchantCustomersCubit extends Cubit<MerchantCustomersState> {
  static const int pageSize = 20;

  final GetMerchantCustomersUseCase _getCustomers;

  MerchantCustomersCubit(this._getCustomers) : super(const MerchantCustomersState());

  Future<void> loadCustomers() async {
    emit(state.copyWith(status: MerchantCustomersStatus.loading));

    final result = await _getCustomers(page: 0, size: pageSize, query: state.query);

    result.fold(
      (failure) => emit(state.copyWith(
        status: MerchantCustomersStatus.failure,
        errorMessage: failure.message,
      )),
      (page) => emit(state.copyWith(
        status: MerchantCustomersStatus.success,
        customers: page.content,
        page: page.page,
        hasMore: page.hasMore,
      )),
    );
  }

  Future<void> search(String query) async {
    if (query == state.query) return;
    emit(state.copyWith(query: query));
    await loadCustomers();
  }

  Future<void> loadMore() async {
    if (!state.hasMore || state.status == MerchantCustomersStatus.loadingMore) {
      return;
    }

    emit(state.copyWith(status: MerchantCustomersStatus.loadingMore));

    final result = await _getCustomers(
      page: state.page + 1,
      size: pageSize,
      query: state.query,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        status: MerchantCustomersStatus.success,
        errorMessage: failure.message,
      )),
      (page) => emit(state.copyWith(
        status: MerchantCustomersStatus.success,
        customers: [...state.customers, ...page.content],
        page: page.page,
        hasMore: page.hasMore,
      )),
    );
  }
}
