class AttendanceRangeRules {
  const AttendanceRangeRules._();

  static const int min = 5;
  static const int max = 5000;

  static bool isValid(int meters) => meters >= min && meters <= max;
}
