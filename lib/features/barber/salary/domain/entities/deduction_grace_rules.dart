class DeductionGraceRules {
  const DeductionGraceRules._();

  static const int min = 0;
  static const int max = 120;

  static bool isValid(int minutes) => minutes >= min && minutes <= max;
}
