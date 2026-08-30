class BarberService {
  final String id;
  final String name;
  final String desc;
  final int price;
  final int durationMinutes;
  final bool popular;

  const BarberService({
    required this.id,
    required this.name,
    required this.desc,
    required this.price,
    required this.durationMinutes,
    this.popular = false,
  });
}
