import 'package:equatable/equatable.dart';
import 'deduction_kind.dart';
import 'deduction_status.dart';

class SalaryDeduction extends Equatable {
  final int id;
  final int barberId;
  final String barberName;
  final DateTime workDate;
  final DeductionKind kind;
  final int minutes;
  final double amount;
  final DeductionStatus status;
  final String? decisionNote;

  const SalaryDeduction({
    required this.id,
    required this.barberId,
    required this.barberName,
    required this.workDate,
    required this.kind,
    required this.minutes,
    required this.amount,
    required this.status,
    required this.decisionNote,
  });

  bool get isDecided => status != DeductionStatus.pending;

  bool get isDeducted => status != DeductionStatus.waived;

  @override
  List<Object?> get props => [
    id,
    barberId,
    barberName,
    workDate,
    kind,
    minutes,
    amount,
    status,
    decisionNote,
  ];
}
