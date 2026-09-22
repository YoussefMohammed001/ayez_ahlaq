import 'package:equatable/equatable.dart';
import '../../domain/entities/merchant_customer.dart';

enum MerchantCustomersStatus { initial, loading, loadingMore, success, failure }

class MerchantCustomersState extends Equatable {
  final MerchantCustomersStatus status;
  final List<MerchantCustomer> customers;
  final int page;
  final bool hasMore;
  final String query;
  final String? errorMessage;

  const MerchantCustomersState({
    this.status = MerchantCustomersStatus.initial,
    this.customers = const [],
    this.page = 0,
    this.hasMore = false,
    this.query = '',
    this.errorMessage,
  });

  MerchantCustomersState copyWith({
    MerchantCustomersStatus? status,
    List<MerchantCustomer>? customers,
    int? page,
    bool? hasMore,
    String? query,
    String? errorMessage,
  }) {
    return MerchantCustomersState(
      status: status ?? this.status,
      customers: customers ?? this.customers,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
      query: query ?? this.query,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    customers,
    page,
    hasMore,
    query,
    errorMessage,
  ];
}
