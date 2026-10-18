class BookingExtraLine {
  final String? name;
  final int quantity;
  final int? price;
  final int? lineTotal;
  final bool isDrink;

  const BookingExtraLine({
    required this.name,
    required this.quantity,
    required this.price,
    required this.isDrink,
    this.lineTotal,
  });
}
