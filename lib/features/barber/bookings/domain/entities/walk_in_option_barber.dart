import 'package:equatable/equatable.dart';

class WalkInOptionBarber extends Equatable {
  final int barberId;
  final String barberName;
  final int price;
  final int durationMinutes;

  const WalkInOptionBarber({
    required this.barberId,
    required this.barberName,
    required this.price,
    required this.durationMinutes,
  });

  @override
  List<Object?> get props => [barberId, barberName, price, durationMinutes];
}
