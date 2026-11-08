import 'package:equatable/equatable.dart';
import 'salary_deduction.dart';

class SalaryDeductionsPage extends Equatable {
  final List<SalaryDeduction> items;
  final int page;
  final int totalPages;

  const SalaryDeductionsPage({
    required this.items,
    required this.page,
    required this.totalPages,
  });

  bool get hasMore => page + 1 < totalPages;

  @override
  List<Object?> get props => [items, page, totalPages];
}
