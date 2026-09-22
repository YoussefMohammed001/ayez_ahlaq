import '../../domain/entities/walk_in_option_barber.dart';

class WalkInOptionBarberModel extends WalkInOptionBarber {
  const WalkInOptionBarberModel({
    required super.barberId,
    required super.barberName,
    required super.price,
    required super.durationMinutes,
  });

  factory WalkInOptionBarberModel.fromJson(Map<String, dynamic> json) {
    return WalkInOptionBarberModel(
      barberId: (json['barberId'] as num?)?.toInt() ?? 0,
      barberName: json['barberName'] as String? ?? '',
      price: (json['price'] as num?)?.toInt() ?? 0,
      durationMinutes: (json['durationMinutes'] as num?)?.toInt() ?? 0,
    );
  }
}
