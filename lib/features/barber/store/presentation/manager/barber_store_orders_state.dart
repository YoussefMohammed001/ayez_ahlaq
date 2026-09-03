import 'package:equatable/equatable.dart';
import '../../domain/entities/store_order.dart';

enum BarberStoreOrdersStatus { initial, loading, success, failure }

class BarberStoreOrdersState extends Equatable {
  final BarberStoreOrdersStatus status;
  final List<StoreOrder> orders;
  final String? errorMessage;
  final int? cancellingId;

  const BarberStoreOrdersState({
    this.status = BarberStoreOrdersStatus.initial,
    this.orders = const [],
    this.errorMessage,
    this.cancellingId,
  });

  BarberStoreOrdersState copyWith({
    BarberStoreOrdersStatus? status,
    List<StoreOrder>? orders,
    String? errorMessage,
    int? cancellingId,
    bool clearCancellingId = false,
  }) {
    return BarberStoreOrdersState(
      status: status ?? this.status,
      orders: orders ?? this.orders,
      errorMessage: errorMessage,
      cancellingId: clearCancellingId ? null : (cancellingId ?? this.cancellingId),
    );
  }

  @override
  List<Object?> get props => [status, orders, errorMessage, cancellingId];
}
