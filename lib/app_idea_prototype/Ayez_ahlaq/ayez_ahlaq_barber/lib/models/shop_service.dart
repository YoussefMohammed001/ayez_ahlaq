class ShopService {
  final String id;
  final String name;
  final int price;
  final int durationMinutes;
  bool active;

  ShopService({
    required this.id,
    required this.name,
    required this.price,
    required this.durationMinutes,
    this.active = true,
  });
}
