import 'package:equatable/equatable.dart';
import '../../domain/entities/member_salary.dart';
import '../../domain/entities/salary_month.dart';

enum SalaryViewStatus { initial, loading, success, failure }

class SalaryViewState extends Equatable {
  final SalaryViewStatus status;
  final DateTime month;
  final MemberSalary? salary;
  final bool isSaving;
  final String? errorMessage;

  const SalaryViewState({
    required this.month,
    this.status = SalaryViewStatus.initial,
    this.salary,
    this.isSaving = false,
    this.errorMessage,
  });

  bool canShowNext(DateTime now) =>
      !SalaryMonth.isSameMonth(month, now) && month.isBefore(now);

  SalaryViewState copyWith({
    SalaryViewStatus? status,
    DateTime? month,
    MemberSalary? salary,
    bool? isSaving,
    String? errorMessage,
  }) {
    return SalaryViewState(
      status: status ?? this.status,
      month: month ?? this.month,
      salary: salary ?? this.salary,
      isSaving: isSaving ?? this.isSaving,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, month, salary, isSaving, errorMessage];
}
