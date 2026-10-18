import 'package:equatable/equatable.dart';
import '../../domain/entities/pending_merchant_rating.dart';

enum PendingMerchantRatingStatus { initial, checking, ready, submitting, submitted, failure }

class PendingMerchantRatingState extends Equatable {
  final PendingMerchantRatingStatus status;
  final PendingMerchantRating? pending;
  final String? errorMessage;

  const PendingMerchantRatingState({
    this.status = PendingMerchantRatingStatus.initial,
    this.pending,
    this.errorMessage,
  });

  bool get isSubmitting => status == PendingMerchantRatingStatus.submitting;

  PendingMerchantRatingState copyWith({
    PendingMerchantRatingStatus? status,
    PendingMerchantRating? pending,
    String? errorMessage,
  }) {
    return PendingMerchantRatingState(
      status: status ?? this.status,
      pending: pending ?? this.pending,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, pending, errorMessage];
}
