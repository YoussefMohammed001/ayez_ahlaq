class AttendanceRangeRules {
  const AttendanceRangeRules._();

  static const int min = 150;
  static const int max = 5000;

  static bool isValid(int meters) => meters >= min && meters <= max;
}
