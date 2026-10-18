import 'package:equatable/equatable.dart';

class ShopHaircutStyle extends Equatable {
  final int id;
  final String name;
  final int serviceTypeId;
  final int priceDelta;
  final bool active;

  const ShopHaircutStyle({
    required this.id,
    required this.name,
    required this.serviceTypeId,
    required this.priceDelta,
    required this.active,
  });

  ShopHaircutStyle copyWith({int? priceDelta, bool? active}) {
    return ShopHaircutStyle(
      id: id,
      name: name,
      serviceTypeId: serviceTypeId,
      priceDelta: priceDelta ?? this.priceDelta,
      active: active ?? this.active,
    );
  }

  @override
  List<Object?> get props => [id, name, serviceTypeId, priceDelta, active];
}
