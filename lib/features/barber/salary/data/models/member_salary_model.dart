import '../../domain/entities/member_salary.dart';
import '../../domain/entities/salary_type.dart';

class MemberSalaryModel extends MemberSalary {
  const MemberSalaryModel({
    required super.barberId,
    required super.month,
    required super.type,
    required super.amount,
    required super.workingDays,
    required super.scheduledHours,
    required super.dailyRate,
    required super.hourlyRate,
    required super.monthlyTotal,
    required super.daysWorked,
    required super.hoursWorked,
    required super.earnedByDays,
    required super.earnedByHours,
    required super.lateMinutes,
    required super.earlyLeaveMinutes,
    required super.absentDays,
    required super.lateDeduction,
    required super.earlyLeaveDeduction,
    required super.absentDeduction,
    required super.deductions,
    required super.grossSalary,
    required super.netSalary,
    required super.pendingDecisions,
  });

  factory MemberSalaryModel.fromJson(Map<String, dynamic> json) {
    double? money(String key) => (json[key] as num?)?.toDouble();
    int count(String key) => (json[key] as num?)?.toInt() ?? 0;

    return MemberSalaryModel(
      barberId: count('barberId'),
      month: json['month'] as String? ?? '',
      type: SalaryType.fromWire(json['type'] as String?),
      amount: money('amount'),
      workingDays: count('workingDays'),
      scheduledHours: money('scheduledHours') ?? 0,
      dailyRate: money('dailyRate'),
      hourlyRate: money('hourlyRate'),
      monthlyTotal: money('monthlyTotal'),
      daysWorked: count('daysWorked'),
      hoursWorked: money('hoursWorked') ?? 0,
      earnedByDays: money('earnedByDays'),
      earnedByHours: money('earnedByHours'),
      lateMinutes: count('lateMinutes'),
      earlyLeaveMinutes: count('earlyLeaveMinutes'),
      absentDays: count('absentDays'),
      lateDeduction: money('lateDeduction'),
      earlyLeaveDeduction: money('earlyLeaveDeduction'),
      absentDeduction: money('absentDeduction'),
      deductions: money('deductions'),
      grossSalary: money('grossSalary'),
      netSalary: money('netSalary'),
      pendingDecisions: count('pendingDecisions'),
    );
  }
}
