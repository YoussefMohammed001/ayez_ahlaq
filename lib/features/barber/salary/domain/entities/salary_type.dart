enum SalaryType {
  daily('DAILY'),
  monthly('MONTHLY');

  final String wireName;

  const SalaryType(this.wireName);

  static SalaryType? fromWire(String? value) {
    for (final type in values) {
      if (type.wireName == value) return type;
    }
    return null;
  }
}
