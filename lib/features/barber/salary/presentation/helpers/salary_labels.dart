import '../../../../../generated/l10n.dart';
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
}
