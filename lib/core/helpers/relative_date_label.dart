import 'package:intl/intl.dart';
import '../../generated/l10n.dart';
import '../cache/preferences_storage/preferences_storage.dart';
import '../di/services_locator.dart';

class RelativeDateLabel {
  static String format(DateTime? date) {
    if (date == null) return '';

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final target = DateTime(date.year, date.month, date.day);
    final days = today.difference(target).inDays;

    if (days == 0) return S().today;
    if (days == 1) return S().yesterday;
    if (days < 7) return S().daysAgo(days);

    final locale = sl<PreferencesStorage>().getCurrentLanguage();
    return DateFormat('d MMMM', locale).format(date);
  }
}
