import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/store_feed_sort.dart';
import '../../domain/use_cases/get_store_categories_use_case.dart';
import '../../domain/use_cases/get_store_feed_products_use_case.dart';
import 'barber_store_feed_state.dart';

class BarberStoreFeedCubit extends Cubit<BarberStoreFeedState> {
  static const int pageSize = 20;

  final GetStoreFeedProductsUseCase _getProducts;
  final GetStoreCategoriesUseCase _getCategories;
  int _requestId = 0;

  BarberStoreFeedCubit(this._getProducts, this._getCategories)
    : super(const BarberStoreFeedState());

  Future<void> load({bool force = false}) async {
    if (!force && state.status == BarberStoreFeedStatus.success) return;

    final requestId = ++_requestId;
    emit(state.copyWith(status: BarberStoreFeedStatus.loading));

    final categoriesResult = state.categories.isEmpty
        ? await _getCategories()
        : null;

    final result = await _getProducts(
      search: state.search,
      categoryId: state.categoryId,
      sort: state.sort,
      limit: pageSize,
    );

    if (requestId != _requestId) return;

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: BarberStoreFeedStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (page) => emit(
        state.copyWith(
          status: BarberStoreFeedStatus.success,
          products: page.items,
          nextCursor: page.nextCursor,
          clearNextCursor: page.nextCursor == null,
          categories: categoriesResult?.fold((_) => state.categories, (c) => c),
        ),
      ),
    );
  }

  Future<void> loadMore() async {
    if (!state.hasMore || state.status == BarberStoreFeedStatus.loadingMore) {
      return;
    }

    final requestId = ++_requestId;
    emit(state.copyWith(status: BarberStoreFeedStatus.loadingMore));

    final result = await _getProducts(
      search: state.search,
      categoryId: state.categoryId,
      sort: state.sort,
      cursor: state.nextCursor,
      limit: pageSize,
    );

    if (requestId != _requestId) return;

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: BarberStoreFeedStatus.success,
          errorMessage: failure.message,
        ),
      ),
      (page) => emit(
        state.copyWith(
          status: BarberStoreFeedStatus.success,
          products: [...state.products, ...page.items],
          nextCursor: page.nextCursor,
          clearNextCursor: page.nextCursor == null,
        ),
      ),
    );
  }

  void search(String query) {
    emit(state.copyWith(search: query));
    load(force: true);
  }

  void filterByCategory(int? categoryId) {
    emit(
      state.copyWith(categoryId: categoryId, clearCategoryId: categoryId == null),
    );
    load(force: true);
  }

  void changeSort(StoreFeedSort sort) {
    emit(state.copyWith(sort: sort));
    load(force: true);
  }
}
