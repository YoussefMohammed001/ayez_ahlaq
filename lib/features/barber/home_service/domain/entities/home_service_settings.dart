import 'package:equatable/equatable.dart';

class HomeServiceSettings extends Equatable {
  final bool enabled;
  final num? price;
  final String? note;

  const HomeServiceSettings({
    required this.enabled,
    required this.price,
    required this.note,
  });

  HomeServiceSettings copyWith({bool? enabled, num? price, String? note}) {
    return HomeServiceSettings(
      enabled: enabled ?? this.enabled,
      price: price ?? this.price,
      note: note ?? this.note,
    );
  }

  @override
  List<Object?> get props => [enabled, price, note];
}
