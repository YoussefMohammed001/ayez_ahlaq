import 'package:equatable/equatable.dart';
import '../../domain/entities/pending_visit_rating.dart';

enum PendingVisitRatingStatus { initial, checking, ready, submitting, submitted, failure }

class PendingVisitRatingState extends Equatable {
  final PendingVisitRatingStatus status;
  final PendingVisitRating? pending;
  final String? errorMessage;

  const PendingVisitRatingState({
    this.status = PendingVisitRatingStatus.initial,
    this.pending,
    this.errorMessage,
  });

  bool get isSubmitting => status == PendingVisitRatingStatus.submitting;

  PendingVisitRatingState copyWith({
    PendingVisitRatingStatus? status,
    PendingVisitRating? pending,
    String? errorMessage,
  }) {
    return PendingVisitRatingState(
      status: status ?? this.status,
      pending: pending ?? this.pending,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, pending, errorMessage];
}
