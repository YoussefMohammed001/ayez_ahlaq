import '../../../../../generated/l10n.dart';
import '../../domain/entities/deduction_kind.dart';
import '../../domain/entities/deduction_status.dart';
import '../../domain/entities/salary_type.dart';

class SalaryLabels {
  const SalaryLabels._();

  static String money(double value) {
    final text = value.toStringAsFixed(2);
    return S().currencyEgp(
      text.endsWith('.00') ? text.substring(0, text.length - 3) : text,
    );
  }

  static String hours(double value) => S().salaryHoursValue(
    value.toStringAsFixed(1).replaceFirst(RegExp(r'\.0$'), ''),
  );

  static String percent(double value) =>
      value.toStringAsFixed(1).replaceFirst(RegExp(r'\.0$'), '');

  static String minutes(int value) => S().salaryMinutesValue('$value');

  static String month(DateTime date) =>
      S().salaryMonthLabel('${date.month}', '${date.year}');

  static String type(SalaryType type) => switch (type) {
    SalaryType.daily => S().salaryTypeDaily,
    SalaryType.monthly => S().salaryTypeMonthly,
  };

  static String typeHint(SalaryType type) => switch (type) {
    SalaryType.daily => S().salaryDailyHint,
    SalaryType.monthly => S().salaryMonthlyHint,
  };

  static String kind(DeductionKind kind) => switch (kind) {
    DeductionKind.late => S().deductionKindLate,
    DeductionKind.earlyLeave => S().deductionKindEarlyLeave,
    DeductionKind.absent => S().deductionKindAbsent,
    DeductionKind.other => S().deductionKindOther,
  };

  static String status(DeductionStatus status) => switch (status) {
    DeductionStatus.pending => S().deductionStatusPending,
    DeductionStatus.deducted => S().deductionStatusDeducted,
    DeductionStatus.waived => S().deductionStatusWaived,
  };

  static String filter(DeductionStatus status) => switch (status) {
    DeductionStatus.pending => S().deductionFilterPending,
    DeductionStatus.deducted => S().deductionFilterDeducted,
    DeductionStatus.waived => S().deductionFilterWaived,
  };

  static String date(DateTime date) =>
      '${date.year.toString().padLeft(4, '0')}-'
      '${date.month.toString().padLeft(2, '0')}-'
      '${date.day.toString().padLeft(2, '0')}';
}
