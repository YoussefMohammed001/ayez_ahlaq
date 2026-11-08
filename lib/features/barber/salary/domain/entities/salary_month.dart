class SalaryMonth {
  const SalaryMonth._();

  static String format(DateTime date) =>
      '${date.year.toString().padLeft(4, '0')}-'
      '${date.month.toString().padLeft(2, '0')}';

  static DateTime previous(DateTime date) =>
      DateTime(date.year, date.month - 1);

  static DateTime next(DateTime date) => DateTime(date.year, date.month + 1);

  static bool isSameMonth(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month;
}
