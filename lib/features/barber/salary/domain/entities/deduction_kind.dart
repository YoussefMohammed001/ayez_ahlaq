enum DeductionKind {
  late('LATE'),
  earlyLeave('EARLY_LEAVE'),
  absent('ABSENT'),
  other('');

  final String wireName;

  const DeductionKind(this.wireName);

  static DeductionKind fromWire(String? value) {
    for (final kind in values) {
      if (kind.wireName == value) return kind;
    }
    return other;
  }
}
