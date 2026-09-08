import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/drink.dart';
import '../../domain/use_cases/create_drink_use_case.dart';
import '../../domain/use_cases/delete_drink_use_case.dart';
import '../../domain/use_cases/get_drinks_use_case.dart';
import '../../domain/use_cases/update_drink_use_case.dart';
import 'barber_drinks_state.dart';

class BarberDrinksCubit extends Cubit<BarberDrinksState> {
  final GetDrinksUseCase _getDrinks;
  final CreateDrinkUseCase _createDrink;
  final UpdateDrinkUseCase _updateDrink;
  final DeleteDrinkUseCase _deleteDrink;

  BarberDrinksCubit(
    this._getDrinks,
    this._createDrink,
    this._updateDrink,
    this._deleteDrink,
  ) : super(const BarberDrinksState());

  Future<void> loadDrinks() async {
    emit(state.copyWith(status: BarberDrinksStatus.loading));

    final result = await _getDrinks();

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: BarberDrinksStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (drinks) => emit(
        state.copyWith(status: BarberDrinksStatus.success, drinks: drinks),
      ),
    );
  }

  Future<bool> createDrink({required String name, required int price}) async {
    emit(state.copyWith(isSubmitting: true));

    final result = await _createDrink(name: name, price: price);

    return result.fold(
      (failure) {
        emit(
          state.copyWith(isSubmitting: false, errorMessage: failure.message),
        );
        return false;
      },
      (drink) {
        emit(
          state.copyWith(
            isSubmitting: false,
            status: BarberDrinksStatus.success,
            drinks: [...state.drinks, drink],
          ),
        );
        return true;
      },
    );
  }

  Future<bool> updateDrink({
    required int id,
    required String name,
    required int price,
    required bool active,
  }) async {
    emit(state.copyWith(isSubmitting: true));

    final result = await _updateDrink(
      id: id,
      name: name,
      price: price,
      active: active,
    );

    return result.fold(
      (failure) {
        emit(
          state.copyWith(isSubmitting: false, errorMessage: failure.message),
        );
        return false;
      },
      (drink) {
        emit(state.copyWith(isSubmitting: false, drinks: _replace(drink)));
        return true;
      },
    );
  }

  Future<void> deleteDrink(int id) async {
    final previous = state.drinks;

    emit(
      state.copyWith(
        drinks: state.drinks.where((d) => d.id != id).toList(),
      ),
    );

    final result = await _deleteDrink(id);

    result.leftMap(
      (failure) => emit(
        state.copyWith(drinks: previous, errorMessage: failure.message),
      ),
    );
  }

  List<Drink> _replace(Drink updated) {
    return state.drinks
        .map((d) => d.id == updated.id ? updated : d)
        .toList();
  }
}
