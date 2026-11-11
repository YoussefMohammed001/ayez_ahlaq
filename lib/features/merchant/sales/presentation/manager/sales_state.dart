import 'package:equatable/equatable.dart';
import '../../domain/entities/sale.dart';

enum SalesStatus { initial, loading, success, failure }

class SalesState extends Equatable {
  final SalesStatus status;
  final List<Sale> sales;
  final int page;
  final bool hasMore;
  final bool isLoadingMore;
  final bool isSubmitting;
  final String? errorMessage;

  const SalesState({
    this.status = SalesStatus.initial,
    this.sales = const [],
    this.page = 0,
    this.hasMore = false,
    this.isLoadingMore = false,
    this.isSubmitting = false,
    this.errorMessage,
  });

  SalesState copyWith({
    SalesStatus? status,
    List<Sale>? sales,
    int? page,
    bool? hasMore,
    bool? isLoadingMore,
    bool? isSubmitting,
    String? errorMessage,
  }) {
    return SalesState(
      status: status ?? this.status,
      sales: sales ?? this.sales,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    sales,
    page,
    hasMore,
    isLoadingMore,
    isSubmitting,
    errorMessage,
  ];
}
