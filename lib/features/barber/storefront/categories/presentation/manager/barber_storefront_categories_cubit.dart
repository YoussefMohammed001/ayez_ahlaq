import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/requests/storefront_category_form_request.dart';
import '../../domain/use_cases/create_storefront_category_use_case.dart';
import '../../domain/use_cases/delete_storefront_category_use_case.dart';
import '../../domain/use_cases/get_assignable_storefront_categories_use_case.dart';
import 'barber_storefront_categories_state.dart';

class BarberStorefrontCategoriesCubit
    extends Cubit<BarberStorefrontCategoriesState> {
  final GetAssignableStorefrontCategoriesUseCase _getAssignable;
  final CreateStorefrontCategoryUseCase _createCategory;
  final DeleteStorefrontCategoryUseCase _deleteCategory;

  BarberStorefrontCategoriesCubit(
    this._getAssignable,
    this._createCategory,
    this._deleteCategory,
  ) : super(const BarberStorefrontCategoriesState());

  Future<void> loadCategories() async {
    emit(state.copyWith(status: StorefrontCategoriesStatus.loading));

    final result = await _getAssignable();

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: StorefrontCategoriesStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (categories) => emit(
        state.copyWith(
          status: StorefrontCategoriesStatus.success,
          assignable: categories,
          own: categories.where((c) => c.isOwn).toList(),
        ),
      ),
    );
  }

  Future<bool> createCategory(StorefrontCategoryFormRequest request) async {
    emit(state.copyWith(isSubmitting: true));

    final result = await _createCategory(request);

    return result.fold(
      (failure) {
        emit(
          state.copyWith(isSubmitting: false, errorMessage: failure.message),
        );
        return false;
      },
      (category) {
        emit(
          state.copyWith(
            isSubmitting: false,
            assignable: [...state.assignable, category],
            own: [...state.own, category],
          ),
        );
        return true;
      },
    );
  }

  Future<void> deleteCategory(int id) async {
    final previousOwn = state.own;
    final previousAssignable = state.assignable;

    emit(
      state.copyWith(
        own: state.own.where((c) => c.id != id).toList(),
        assignable: state.assignable.where((c) => c.id != id).toList(),
      ),
    );

    final result = await _deleteCategory(id);

    result.leftMap(
      (failure) => emit(
        state.copyWith(
          own: previousOwn,
          assignable: previousAssignable,
          errorMessage: failure.message,
        ),
      ),
    );
  }
}
