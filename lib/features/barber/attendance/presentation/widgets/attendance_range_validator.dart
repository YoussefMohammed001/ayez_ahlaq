import '../../../../../generated/l10n.dart';
import '../../domain/entities/attendance_range_rules.dart';

class AttendanceRangeValidator {
  const AttendanceRangeValidator._();

  static String? Function(String?) of({required bool Function() enforced}) =>
      (text) {
        final value = text?.trim() ?? '';
        if (value.isEmpty) return enforced() ? S().attendanceRangeInvalid : null;

        final meters = int.tryParse(value);
        final valid = meters != null && AttendanceRangeRules.isValid(meters);
        return valid ? null : S().attendanceRangeInvalid;
      };
}
