class AttendanceFeaturePriceLabel {
  const AttendanceFeaturePriceLabel._();

  static String of(num price) =>
      price == price.roundToDouble() ? price.toInt().toString() : '$price';
}
