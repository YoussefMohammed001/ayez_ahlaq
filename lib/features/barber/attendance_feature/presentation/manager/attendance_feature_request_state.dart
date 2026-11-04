import 'package:equatable/equatable.dart';

class AttendanceFeatureRequestState extends Equatable {
  final bool isSubmitting;
  final String? errorMessage;

  const AttendanceFeatureRequestState({
    this.isSubmitting = false,
    this.errorMessage,
  });

  AttendanceFeatureRequestState copyWith({
    bool? isSubmitting,
    String? errorMessage,
  }) {
    return AttendanceFeatureRequestState(
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [isSubmitting, errorMessage];
}
