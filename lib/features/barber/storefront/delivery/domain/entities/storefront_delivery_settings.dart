import 'package:equatable/equatable.dart';

class StorefrontDeliverySettings extends Equatable {
  final bool offered;
  final int fee;
  final int? freeOver;

  const StorefrontDeliverySettings({
    required this.offered,
    required this.fee,
    this.freeOver,
  });

  const StorefrontDeliverySettings.disabled()
    : offered = false,
      fee = 0,
      freeOver = null;

  bool get hasFreeThreshold => (freeOver ?? 0) > 0;

  StorefrontDeliverySettings copyWith({
    bool? offered,
    int? fee,
    int? freeOver,
  }) {
    return StorefrontDeliverySettings(
      offered: offered ?? this.offered,
      fee: fee ?? this.fee,
      freeOver: freeOver ?? this.freeOver,
    );
  }

  @override
  List<Object?> get props => [offered, fee, freeOver];
}
