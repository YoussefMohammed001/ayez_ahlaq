import 'package:equatable/equatable.dart';
import '../../domain/entities/store_order.dart';

enum StoreOrdersStatus { initial, loading, success, failure }

class StoreOrdersState extends Equatable {
  final StoreOrdersStatus status;
  final List<StoreOrder> orders;
  final String? errorMessage;
  final int? cancellingId;

  const StoreOrdersState({
    this.status = StoreOrdersStatus.initial,
    this.orders = const [],
    this.errorMessage,
    this.cancellingId,
  });

  StoreOrdersState copyWith({
    StoreOrdersStatus? status,
    List<StoreOrder>? orders,
    String? errorMessage,
    int? cancellingId,
    bool clearCancellingId = false,
  }) {
    return StoreOrdersState(
      status: status ?? this.status,
      orders: orders ?? this.orders,
      errorMessage: errorMessage,
      cancellingId: clearCancellingId ? null : (cancellingId ?? this.cancellingId),
    );
  }

  @override
  List<Object?> get props => [status, orders, errorMessage, cancellingId];
}
