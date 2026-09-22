import 'package:equatable/equatable.dart';
import '../../domain/entities/money_pin_reset_status.dart';

enum MoneyPinStage { checking, needsSetup, locked, unlocked, error }

class MoneyPinState extends Equatable {
  final MoneyPinStage stage;
  final bool submitting;
  final String? errorMessage;
  final MoneyPinResetStatus? resetStatus;
  final bool checkingResetStatus;

  const MoneyPinState({
    this.stage = MoneyPinStage.checking,
    this.submitting = false,
    this.errorMessage,
    this.resetStatus,
    this.checkingResetStatus = false,
  });

  MoneyPinState copyWith({
    MoneyPinStage? stage,
    bool? submitting,
    String? errorMessage,
    MoneyPinResetStatus? resetStatus,
    bool? checkingResetStatus,
  }) {
    return MoneyPinState(
      stage: stage ?? this.stage,
      submitting: submitting ?? this.submitting,
      errorMessage: errorMessage,
      resetStatus: resetStatus ?? this.resetStatus,
      checkingResetStatus: checkingResetStatus ?? this.checkingResetStatus,
    );
  }

  @override
  List<Object?> get props => [
    stage,
    submitting,
    errorMessage,
    resetStatus,
    checkingResetStatus,
  ];
}
