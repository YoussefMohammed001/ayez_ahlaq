import 'package:equatable/equatable.dart';
import '../../domain/entities/barber_reviews_summary.dart';

enum BarberReviewsStatus { initial, loading, success, failure }

class BarberReviewsState extends Equatable {
  final BarberReviewsStatus status;
  final BarberReviewsSummary? summary;
  final String? errorMessage;

  const BarberReviewsState({
    this.status = BarberReviewsStatus.initial,
    this.summary,
    this.errorMessage,
  });

  BarberReviewsState copyWith({
    BarberReviewsStatus? status,
    BarberReviewsSummary? summary,
    String? errorMessage,
  }) {
    return BarberReviewsState(
      status: status ?? this.status,
      summary: summary ?? this.summary,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, summary, errorMessage];
}
