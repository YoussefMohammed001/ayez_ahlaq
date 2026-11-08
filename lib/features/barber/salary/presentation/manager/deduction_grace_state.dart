import 'package:equatable/equatable.dart';

enum DeductionGraceStatus { initial, loading, success, failure }

class DeductionGraceState extends Equatable {
  final DeductionGraceStatus status;
  final int minutes;
  final bool isSaving;
  final String? errorMessage;

  const DeductionGraceState({
    this.status = DeductionGraceStatus.initial,
    this.minutes = 0,
    this.isSaving = false,
    this.errorMessage,
  });

  DeductionGraceState copyWith({
    DeductionGraceStatus? status,
    int? minutes,
    bool? isSaving,
    String? errorMessage,
  }) {
    return DeductionGraceState(
      status: status ?? this.status,
      minutes: minutes ?? this.minutes,
      isSaving: isSaving ?? this.isSaving,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, minutes, isSaving, errorMessage];
}
