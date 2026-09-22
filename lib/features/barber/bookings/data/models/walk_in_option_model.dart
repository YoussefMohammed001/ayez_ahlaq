import '../../domain/entities/walk_in_option.dart';
import 'walk_in_option_barber_model.dart';

class WalkInOptionModel extends WalkInOption {
  const WalkInOptionModel({
    required super.serviceTypeId,
    required super.name,
    required super.barbers,
  });

  factory WalkInOptionModel.fromJson(Map<String, dynamic> json) {
    final barbers = json['barbers'] as List? ?? const [];
    return WalkInOptionModel(
      serviceTypeId: (json['serviceTypeId'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
      barbers: barbers
          .map<WalkInOptionBarberModel>(
            (e) => WalkInOptionBarberModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );
  }
}
