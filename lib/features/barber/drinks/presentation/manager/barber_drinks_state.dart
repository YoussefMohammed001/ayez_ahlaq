import 'package:equatable/equatable.dart';
import '../../domain/entities/drink.dart';

enum BarberDrinksStatus { initial, loading, success, failure }

class BarberDrinksState extends Equatable {
  final BarberDrinksStatus status;
  final List<Drink> drinks;
  final String? errorMessage;
  final bool isSubmitting;

  const BarberDrinksState({
    this.status = BarberDrinksStatus.initial,
    this.drinks = const [],
    this.errorMessage,
    this.isSubmitting = false,
  });

  bool get isEmpty =>
      status == BarberDrinksStatus.success && drinks.isEmpty;

  BarberDrinksState copyWith({
    BarberDrinksStatus? status,
    List<Drink>? drinks,
    String? errorMessage,
    bool? isSubmitting,
  }) {
    return BarberDrinksState(
      status: status ?? this.status,
      drinks: drinks ?? this.drinks,
      errorMessage: errorMessage,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }

  @override
  List<Object?> get props => [status, drinks, errorMessage, isSubmitting];
}
