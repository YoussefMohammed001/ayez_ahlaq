import '../../../../../generated/l10n.dart';

class SalaryAmountValidator {
  const SalaryAmountValidator._();

  static double? parse(String? text) =>
      double.tryParse((text ?? '').trim().replaceAll(',', '.'));

  static String? validate(String? text) {
    final amount = parse(text);
    return amount != null && amount > 0 ? null : S().salaryAmountInvalid;
  }
}
