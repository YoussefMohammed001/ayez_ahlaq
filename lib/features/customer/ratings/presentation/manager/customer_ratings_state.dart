import 'package:equatable/equatable.dart';
import '../../domain/entities/customer_rating.dart';

enum CustomerRatingsStatus { initial, loading, success, failure }

class CustomerRatingsState extends Equatable {
  final CustomerRatingsStatus status;
  final List<CustomerRating> ratings;
  final String? errorMessage;

  const CustomerRatingsState({
    this.status = CustomerRatingsStatus.initial,
    this.ratings = const [],
    this.errorMessage,
  });

  CustomerRatingsState copyWith({
    CustomerRatingsStatus? status,
    List<CustomerRating>? ratings,
    String? errorMessage,
  }) {
    return CustomerRatingsState(
      status: status ?? this.status,
      ratings: ratings ?? this.ratings,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, ratings, errorMessage];
}
