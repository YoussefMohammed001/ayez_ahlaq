class CommissionRules {
  const CommissionRules._();

  static const double min = 0;
  static const double max = 100;

  static bool isValid(double percent) => percent > min && percent <= max;
}
