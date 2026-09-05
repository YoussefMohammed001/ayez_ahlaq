import 'package:equatable/equatable.dart';

class StoreDelivery extends Equatable {
  final bool offered;
  final int fee;
  final int? freeOver;

  const StoreDelivery({required this.offered, required this.fee, this.freeOver});

  @override
  List<Object?> get props => [offered, fee, freeOver];
}
