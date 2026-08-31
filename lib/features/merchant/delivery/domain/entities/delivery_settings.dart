import 'package:equatable/equatable.dart';

class DeliverySettings extends Equatable {
  final bool offered;
  final int fee;
  final int? freeOver;

  const DeliverySettings({
    required this.offered,
    required this.fee,
    this.freeOver,
  });

  const DeliverySettings.disabled() : offered = false, fee = 0, freeOver = null;

  bool get hasFreeThreshold => (freeOver ?? 0) > 0;

  DeliverySettings copyWith({bool? offered, int? fee, int? freeOver}) {
    return DeliverySettings(
      offered: offered ?? this.offered,
      fee: fee ?? this.fee,
      freeOver: freeOver ?? this.freeOver,
    );
  }

  @override
  List<Object?> get props => [offered, fee, freeOver];
}
