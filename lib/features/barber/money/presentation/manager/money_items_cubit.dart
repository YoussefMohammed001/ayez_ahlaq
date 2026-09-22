import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/money_direction.dart';
import '../../domain/entities/money_frequency.dart';
import '../../domain/use_cases/create_money_item_use_case.dart';
import '../../domain/use_cases/delete_money_item_use_case.dart';
import '../../domain/use_cases/get_money_items_use_case.dart';
import '../../domain/use_cases/update_money_item_use_case.dart';
import 'money_items_state.dart';

class MoneyItemsCubit extends Cubit<MoneyItemsState> {
  final GetMoneyItemsUseCase _getItems;
  final CreateMoneyItemUseCase _createItem;
  final UpdateMoneyItemUseCase _updateItem;
  final DeleteMoneyItemUseCase _deleteItem;

  MoneyItemsCubit(
    this._getItems,
    this._createItem,
    this._updateItem,
    this._deleteItem,
  ) : super(const MoneyItemsState());

  Future<void> load() async {
    emit(state.copyWith(status: MoneyItemsStatus.loading));
    final result = await _getItems();
    result.fold(
      (failure) => emit(
        state.copyWith(status: MoneyItemsStatus.failure, errorMessage: failure.message),
      ),
      (items) => emit(state.copyWith(status: MoneyItemsStatus.success, items: items)),
    );
  }

  Future<bool> create({
    required String description,
    required int amount,
    required MoneyDirection direction,
    required MoneyFrequency frequency,
    int? dayOfWeek,
    int? dayOfMonth,
  }) async {
    final result = await _createItem(
      description: description,
      amount: amount,
      direction: direction,
      frequency: frequency,
      dayOfWeek: dayOfWeek,
      dayOfMonth: dayOfMonth,
    );
    return result.fold(
      (failure) {
        emit(state.copyWith(errorMessage: failure.message));
        return false;
      },
      (item) {
        emit(state.copyWith(items: [item, ...state.items]));
        return true;
      },
    );
  }

  Future<bool> update({
    required int id,
    required String description,
    required int amount,
    required MoneyDirection direction,
    required MoneyFrequency frequency,
    int? dayOfWeek,
    int? dayOfMonth,
    required bool active,
  }) async {
    emit(state.copyWith(mutatingIds: {...state.mutatingIds, id}));
    final result = await _updateItem(
      id: id,
      description: description,
      amount: amount,
      direction: direction,
      frequency: frequency,
      dayOfWeek: dayOfWeek,
      dayOfMonth: dayOfMonth,
      active: active,
    );
    return result.fold(
      (failure) {
        emit(state.copyWith(mutatingIds: _without(id), errorMessage: failure.message));
        return false;
      },
      (updated) {
        emit(
          state.copyWith(
            mutatingIds: _without(id),
            items: state.items.map((i) => i.id == id ? updated : i).toList(),
          ),
        );
        return true;
      },
    );
  }

  Future<bool> delete(int id) async {
    emit(state.copyWith(mutatingIds: {...state.mutatingIds, id}));
    final result = await _deleteItem(id);
    return result.fold(
      (failure) {
        emit(state.copyWith(mutatingIds: _without(id), errorMessage: failure.message));
        return false;
      },
      (_) {
        emit(
          state.copyWith(
            mutatingIds: _without(id),
            items: state.items.where((i) => i.id != id).toList(),
          ),
        );
        return true;
      },
    );
  }

  Set<int> _without(int id) =>
      state.mutatingIds.where((element) => element != id).toSet();
}
