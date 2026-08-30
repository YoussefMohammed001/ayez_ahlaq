import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/requests/category_form_request.dart';
import '../../domain/use_cases/create_category_use_case.dart';
import '../../domain/use_cases/delete_category_use_case.dart';
import '../../domain/use_cases/get_assignable_categories_use_case.dart';
import '../../domain/use_cases/update_category_use_case.dart';
import '../../domain/entities/merchant_category.dart';
import 'merchant_categories_state.dart';

class MerchantCategoriesCubit extends Cubit<MerchantCategoriesState> {
  final GetAssignableCategoriesUseCase _getAssignable;
  final CreateCategoryUseCase _createCategory;
  final UpdateCategoryUseCase _updateCategory;
  final DeleteCategoryUseCase _deleteCategory;

  MerchantCategoriesCubit(
    this._getAssignable,
    this._createCategory,
    this._updateCategory,
    this._deleteCategory,
  ) : super(const MerchantCategoriesState());

  Future<void> loadCategories() async {
    emit(state.copyWith(status: CategoriesStatus.loading));

    final result = await _getAssignable();

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: CategoriesStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (categories) => emit(
        state.copyWith(
          status: CategoriesStatus.success,
          assignable: categories,
          own: categories.where((c) => c.isOwn).toList(),
        ),
      ),
    );
  }

  Future<bool> createCategory(CategoryFormRequest request) async {
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

  Future<bool> updateCategory(int id, CategoryFormRequest request) async {
    emit(state.copyWith(isSubmitting: true));

    final result = await _updateCategory(id, request);

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
            assignable: _replace(state.assignable, category),
            own: _replace(state.own, category),
          ),
        );
        return true;
      },
    );
  }

  List<MerchantCategory> _replace(
    List<MerchantCategory> list,
    MerchantCategory category,
  ) => list.map((c) => c.id == category.id ? category : c).toList();

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
