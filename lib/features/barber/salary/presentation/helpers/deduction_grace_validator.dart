import '../../../../../generated/l10n.dart';
import '../../domain/entities/deduction_grace_rules.dart';

class DeductionGraceValidator {
  const DeductionGraceValidator._();

  static int? parse(String? text) => int.tryParse((text ?? '').trim());

  static String? validate(String? text) {
    final minutes = parse(text);
    return minutes != null && DeductionGraceRules.isValid(minutes)
        ? null
        : S().graceInvalid;
  }
}
