import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/error/failure.dart';
import '../../data/requests/storefront_product_form_request.dart';
import '../../domain/entities/storefront_product.dart';
import '../../domain/entities/storefront_product_list_ext.dart';
import '../../domain/use_cases/create_storefront_product_use_case.dart';
import '../../domain/use_cases/delete_storefront_product_use_case.dart';
import '../../domain/use_cases/get_storefront_products_use_case.dart';
import '../../domain/use_cases/set_storefront_product_stock_use_case.dart';
import '../../domain/use_cases/update_storefront_product_use_case.dart';
import 'barber_storefront_products_state.dart';

class BarberStorefrontProductsCubit
    extends Cubit<BarberStorefrontProductsState> {
  final GetStorefrontProductsUseCase _getProducts;
  final CreateStorefrontProductUseCase _createProduct;
  final UpdateStorefrontProductUseCase _updateProduct;
  final DeleteStorefrontProductUseCase _deleteProduct;
  final SetStorefrontProductStockUseCase _setStock;

  BarberStorefrontProductsCubit(
    this._getProducts,
    this._createProduct,
    this._updateProduct,
    this._deleteProduct,
    this._setStock,
  ) : super(const BarberStorefrontProductsState());

  Future<void> loadProducts({bool force = false}) async {
    if (!force && state.status == StorefrontProductsStatus.success) return;

    emit(state.copyWith(status: StorefrontProductsStatus.loading));

    final result = await _getProducts();

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: StorefrontProductsStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (products) => emit(
        state.copyWith(
          status: StorefrontProductsStatus.success,
          products: products,
        ),
      ),
    );
  }

  void filterByCategory(int? categoryId) {
    emit(
      state.copyWith(
        categoryFilter: categoryId,
        clearCategoryFilter: categoryId == null,
      ),
    );
  }

  Future<bool> createProduct(StorefrontProductFormRequest request) async {
    emit(state.copyWith(isSubmitting: true));

    final result = await _createProduct(request);

    return result.fold(
      (failure) {
        emit(
          state.copyWith(isSubmitting: false, errorMessage: failure.message),
        );
        return false;
      },
      (product) {
        emit(
          state.copyWith(
            isSubmitting: false,
            products: [product, ...state.products],
          ),
        );
        return true;
      },
    );
  }

  Future<bool> updateProduct(
    int id,
    StorefrontProductFormRequest request,
  ) async {
    emit(state.copyWith(isSubmitting: true));

    final result = await _updateProduct(id, request);

    return result.fold(
      (failure) {
        emit(
          state.copyWith(isSubmitting: false, errorMessage: failure.message),
        );
        return false;
      },
      (product) {
        emit(
          state.copyWith(
            isSubmitting: false,
            products: state.products.replace(product),
          ),
        );
        return true;
      },
    );
  }

  Future<void> removeProduct(int id) async {
    final removed = state.products.where((p) => p.id == id).firstOrNull;
    emit(state.copyWith(products: state.products.without(id)));

    final result = await _deleteProduct(id);

    result.leftMap((failure) {
      if (removed != null && !state.products.any((p) => p.id == id)) {
        emit(state.copyWith(products: [removed, ...state.products]));
      }
      emit(state.copyWith(errorMessage: failure.message));
    });
  }

  Future<bool> setStock(int id, int quantity) async {
    final previous = state.products;

    emit(state.copyWith(isSubmitting: true));

    final result = await _setStock(id, quantity);

    return result.fold(
      (failure) {
        _revert(previous, failure);
        return false;
      },
      (product) {
        emit(
          state.copyWith(
            isSubmitting: false,
            products: state.products.replace(product),
          ),
        );
        return true;
      },
    );
  }

  void _revert(List<StorefrontProduct> previous, Failure failure) {
    emit(
      state.copyWith(
        isSubmitting: false,
        products: previous,
        errorMessage: failure.message,
      ),
    );
  }
}
