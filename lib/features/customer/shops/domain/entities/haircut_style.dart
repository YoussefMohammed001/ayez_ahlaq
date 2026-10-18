import 'package:equatable/equatable.dart';

class HaircutStyle extends Equatable {
  final int id;
  final String name;
  final int priceDelta;
  final int? serviceTypeId;

  const HaircutStyle({
    required this.id,
    required this.name,
    required this.priceDelta,
    this.serviceTypeId,
  });

  bool appliesTo(int? serviceTypeId) =>
      this.serviceTypeId == null || this.serviceTypeId == serviceTypeId;

  @override
  List<Object?> get props => [id, name, priceDelta, serviceTypeId];
}
