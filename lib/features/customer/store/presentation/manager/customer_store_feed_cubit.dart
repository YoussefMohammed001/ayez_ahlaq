import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shops/domain/entities/shop.dart';
import '../../domain/use_cases/get_store_feed_use_case.dart';
import 'customer_store_feed_state.dart';

class CustomerStoreFeedCubit extends Cubit<CustomerStoreFeedState> {
  final GetStoreFeedUseCase _getStoreFeed;

  CustomerStoreFeedCubit(this._getStoreFeed) : super(const CustomerStoreFeedState());

  Future<void> load({bool force = false, List<Shop>? knownShops}) async {
    if (!force && state.status == CustomerStoreFeedStatus.success) return;

    emit(state.copyWith(status: CustomerStoreFeedStatus.loading));

    final result = await _getStoreFeed(knownShops: knownShops);

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: CustomerStoreFeedStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (items) => emit(
        state.copyWith(status: CustomerStoreFeedStatus.success, items: items),
      ),
    );
  }

  void search(String query) => emit(state.copyWith(search: query));

  void filterByCategory(String? categoryName) => emit(
    state.copyWith(categoryName: categoryName, clearCategoryName: categoryName == null),
  );
}
