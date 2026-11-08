import '../../domain/entities/deduction_kind.dart';
import '../../domain/entities/deduction_status.dart';
import '../../domain/entities/salary_deduction.dart';

class SalaryDeductionModel extends SalaryDeduction {
  const SalaryDeductionModel({
    required super.id,
    required super.barberId,
    required super.barberName,
    required super.workDate,
    required super.kind,
    required super.minutes,
    required super.amount,
    required super.status,
    required super.decisionNote,
  });

  factory SalaryDeductionModel.fromJson(Map<String, dynamic> json) {
    final workDate = json['workDate'] as String?;
    final note = (json['decisionNote'] as String?)?.trim();

    return SalaryDeductionModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      barberId: (json['barberId'] as num?)?.toInt() ?? 0,
      barberName: json['barberName'] as String? ?? '',
      workDate:
          (workDate == null ? null : DateTime.tryParse(workDate)) ??
          DateTime.fromMillisecondsSinceEpoch(0),
      kind: DeductionKind.fromWire(json['kind'] as String?),
      minutes: (json['minutes'] as num?)?.toInt() ?? 0,
      amount: (json['amount'] as num?)?.toDouble() ?? 0,
      status: DeductionStatus.fromWire(json['status'] as String?),
      decisionNote: note == null || note.isEmpty ? null : note,
    );
  }
}
