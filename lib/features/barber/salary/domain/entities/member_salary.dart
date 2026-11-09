import 'package:equatable/equatable.dart';
import 'salary_type.dart';

class MemberSalary extends Equatable {
  final int barberId;
  final String month;
  final SalaryType? type;
  final double? amount;
  final int workingDays;
  final double scheduledHours;
  final double? dailyRate;
  final double? hourlyRate;
  final double? monthlyTotal;
  final int daysWorked;
  final double hoursWorked;
  final double? earnedByDays;
  final double? earnedByHours;
  final int lateMinutes;
  final int earlyLeaveMinutes;
  final int absentDays;
  final double? lateDeduction;
  final double? earlyLeaveDeduction;
  final double? absentDeduction;
  final double? deductions;
  final double? grossSalary;
  final double? netSalary;
  final int pendingDecisions;
  final bool commissionEnabled;
  final double? commissionPercent;
  final int commissionBookings;
  final double commissionBase;
  final double commissionAmount;
  final double? totalPay;

  const MemberSalary({
    required this.barberId,
    required this.month,
    required this.type,
    required this.amount,
    required this.workingDays,
    required this.scheduledHours,
    required this.dailyRate,
    required this.hourlyRate,
    required this.monthlyTotal,
    required this.daysWorked,
    required this.hoursWorked,
    required this.earnedByDays,
    required this.earnedByHours,
    required this.lateMinutes,
    required this.earlyLeaveMinutes,
    required this.absentDays,
    required this.lateDeduction,
    required this.earlyLeaveDeduction,
    required this.absentDeduction,
    required this.deductions,
    required this.grossSalary,
    required this.netSalary,
    required this.pendingDecisions,
    this.commissionEnabled = false,
    this.commissionPercent,
    this.commissionBookings = 0,
    this.commissionBase = 0,
    this.commissionAmount = 0,
    this.totalPay,
  });

  bool get hasSalary => type != null && amount != null;

  bool get hasPay => hasSalary || commissionEnabled;

  bool get hasIncidents =>
      lateMinutes > 0 || earlyLeaveMinutes > 0 || absentDays > 0;

  @override
  List<Object?> get props => [
    barberId,
    month,
    type,
    amount,
    workingDays,
    scheduledHours,
    dailyRate,
    hourlyRate,
    monthlyTotal,
    daysWorked,
    hoursWorked,
    earnedByDays,
    earnedByHours,
    lateMinutes,
    earlyLeaveMinutes,
    absentDays,
    lateDeduction,
    earlyLeaveDeduction,
    absentDeduction,
    deductions,
    grossSalary,
    netSalary,
    pendingDecisions,
    commissionEnabled,
    commissionPercent,
    commissionBookings,
    commissionBase,
    commissionAmount,
    totalPay,
  ];
}
