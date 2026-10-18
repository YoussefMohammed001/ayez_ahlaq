import '../../domain/entities/haircut_style.dart';

class HaircutStyleModel extends HaircutStyle {
  const HaircutStyleModel({
    required super.id,
    required super.name,
    required super.priceDelta,
    super.serviceTypeId,
  });

  factory HaircutStyleModel.fromJson(Map<String, dynamic> json) {
    return HaircutStyleModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
      priceDelta: (json['priceDelta'] as num?)?.toInt() ?? 0,
      serviceTypeId: (json['serviceTypeId'] as num?)?.toInt(),
    );
  }
}
