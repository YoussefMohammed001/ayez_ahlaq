import 'package:equatable/equatable.dart';
import '../../domain/entities/deduction_status.dart';
import '../../domain/entities/salary_deduction.dart';

enum SalaryDeductionsStatus { initial, loading, success, failure }

class SalaryDeductionsState extends Equatable {
  final SalaryDeductionsStatus status;
  final List<SalaryDeduction> items;
  final DeductionStatus? filter;
  final int page;
  final bool hasMore;
  final bool isLoadingMore;
  final bool isDeciding;
  final int pendingCount;
  final String? errorMessage;

  const SalaryDeductionsState({
    this.status = SalaryDeductionsStatus.initial,
    this.items = const [],
    this.filter,
    this.page = 0,
    this.hasMore = false,
    this.isLoadingMore = false,
    this.isDeciding = false,
    this.pendingCount = 0,
    this.errorMessage,
  });

  SalaryDeductionsState copyWith({
    SalaryDeductionsStatus? status,
    List<SalaryDeduction>? items,
    DeductionStatus? filter,
    bool clearFilter = false,
    int? page,
    bool? hasMore,
    bool? isLoadingMore,
    bool? isDeciding,
    int? pendingCount,
    String? errorMessage,
  }) {
    return SalaryDeductionsState(
      status: status ?? this.status,
      items: items ?? this.items,
      filter: clearFilter ? null : (filter ?? this.filter),
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      isDeciding: isDeciding ?? this.isDeciding,
      pendingCount: pendingCount ?? this.pendingCount,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    items,
    filter,
    page,
    hasMore,
    isLoadingMore,
    isDeciding,
    pendingCount,
    errorMessage,
  ];
}
