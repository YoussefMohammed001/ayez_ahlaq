import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/error/failure.dart';
import '../../data/requests/product_form_request.dart';
import '../../domain/entities/merchant_product.dart';
import '../../domain/entities/product_list_ext.dart';
import '../../domain/use_cases/create_product_use_case.dart';
import '../../domain/use_cases/delete_product_image_use_case.dart';
import '../../domain/use_cases/delete_product_use_case.dart';
import '../../domain/use_cases/get_products_use_case.dart';
import '../../domain/use_cases/set_product_stock_use_case.dart';
import '../../domain/use_cases/update_product_use_case.dart';
import 'merchant_products_state.dart';

class MerchantProductsCubit extends Cubit<MerchantProductsState> {
  final GetProductsUseCase _getProducts;
  final CreateProductUseCase _createProduct;
  final UpdateProductUseCase _updateProduct;
  final DeleteProductUseCase _deleteProduct;
  final SetProductStockUseCase _setStock;
  final DeleteProductImageUseCase _deleteImage;

  MerchantProductsCubit(
    this._getProducts,
    this._createProduct,
    this._updateProduct,
    this._deleteProduct,
    this._setStock,
    this._deleteImage,
  ) : super(const MerchantProductsState());

  Future<void> loadProducts() async {
    emit(state.copyWith(status: ProductsStatus.loading));

    final result = await _getProducts();

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: ProductsStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (products) => emit(
        state.copyWith(status: ProductsStatus.success, products: products),
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

  Future<bool> createProduct(ProductFormRequest request) async {
    emit(state.copyWith(isSubmitting: true));

    final result = await _createProduct(request);

    return result.fold(
      (failure) {
        emit(state.copyWith(isSubmitting: false, errorMessage: failure.message));
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

  Future<bool> updateProduct(int id, ProductFormRequest request) async {
    emit(state.copyWith(isSubmitting: true));

    final result = await _updateProduct(id, request);

    return result.fold(
      (failure) {
        emit(state.copyWith(isSubmitting: false, errorMessage: failure.message));
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
    final previous = state.products;
    emit(state.copyWith(products: state.products.without(id)));

    final result = await _deleteProduct(id);

    result.leftMap((failure) => _revert(previous, failure));
  }

  Future<void> setStock(int id, int quantity) async {
    final previous = state.products;

    final result = await _setStock(id, quantity);

    result.fold(
      (failure) => _revert(previous, failure),
      (product) =>
          emit(state.copyWith(products: state.products.replace(product))),
    );
  }

  Future<void> deleteImage(int productId, int imageId) async {
    final result = await _deleteImage(productId, imageId);

    await result.fold(
      (failure) async => emit(state.copyWith(errorMessage: failure.message)),
      (_) => loadProducts(),
    );
  }

  void _revert(List<MerchantProduct> previous, Failure failure) {
    emit(state.copyWith(products: previous, errorMessage: failure.message));
  }
}
