import '../../../../../generated/l10n.dart';
import '../../domain/entities/commission_rules.dart';

class CommissionPercentValidator {
  const CommissionPercentValidator._();

  static double? parse(String? text) =>
      double.tryParse((text ?? '').trim().replaceAll(',', '.'));

  static String? validate(String? text) {
    final percent = parse(text);
    return percent != null && CommissionRules.isValid(percent)
        ? null
        : S().commissionPercentInvalid;
  }
}
