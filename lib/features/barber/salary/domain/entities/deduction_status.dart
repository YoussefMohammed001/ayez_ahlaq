enum DeductionStatus {
  pending('PENDING'),
  deducted('DEDUCTED'),
  waived('WAIVED');

  final String wireName;

  const DeductionStatus(this.wireName);

  static DeductionStatus fromWire(String? value) {
    for (final status in values) {
      if (status.wireName == value) return status;
    }
    return pending;
  }
}
