import 'package:equatable/equatable.dart';
import '../../domain/entities/shop_detail.dart';

enum CustomerShopDetailStatus { initial, loading, success, failure }

class CustomerShopDetailState extends Equatable {
  final CustomerShopDetailStatus status;
  final ShopDetail? detail;
  final String? errorMessage;

  const CustomerShopDetailState({
    this.status = CustomerShopDetailStatus.initial,
    this.detail,
    this.errorMessage,
  });

  CustomerShopDetailState copyWith({
    CustomerShopDetailStatus? status,
    ShopDetail? detail,
    String? errorMessage,
  }) {
    return CustomerShopDetailState(
      status: status ?? this.status,
      detail: detail ?? this.detail,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, detail, errorMessage];
}
