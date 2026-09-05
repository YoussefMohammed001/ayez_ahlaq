import 'package:equatable/equatable.dart';
import '../../domain/entities/shop.dart';

enum CustomerShopsStatus { initial, loading, success, failure }

class CustomerShopsState extends Equatable {
  final CustomerShopsStatus status;
  final List<Shop> shops;
  final bool sortedByDistance;
  final String? errorMessage;

  const CustomerShopsState({
    this.status = CustomerShopsStatus.initial,
    this.shops = const [],
    this.sortedByDistance = false,
    this.errorMessage,
  });

  CustomerShopsState copyWith({
    CustomerShopsStatus? status,
    List<Shop>? shops,
    bool? sortedByDistance,
    String? errorMessage,
  }) {
    return CustomerShopsState(
      status: status ?? this.status,
      shops: shops ?? this.shops,
      sortedByDistance: sortedByDistance ?? this.sortedByDistance,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, shops, sortedByDistance, errorMessage];
}
