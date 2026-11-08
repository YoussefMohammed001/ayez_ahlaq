import 'package:equatable/equatable.dart';
import '../../domain/entities/shop.dart';
import '../../domain/entities/shops_area.dart';
import '../../domain/entities/shops_browse_mode.dart';

enum CustomerShopsStatus { initial, loading, success, failure }

class CustomerShopsState extends Equatable {
  final CustomerShopsStatus status;
  final List<Shop> shops;
  final bool sortedByDistance;
  final ShopsArea? area;
  final bool browseAll;
  final String? errorMessage;

  const CustomerShopsState({
    this.status = CustomerShopsStatus.initial,
    this.shops = const [],
    this.sortedByDistance = false,
    this.area,
    this.browseAll = false,
    this.errorMessage,
  });

  ShopsBrowseMode get mode {
    if (browseAll) return ShopsBrowseMode.all;
    return area == null ? ShopsBrowseMode.device : ShopsBrowseMode.custom;
  }

  bool get usesDeviceLocation => mode == ShopsBrowseMode.device;

  CustomerShopsState copyWith({
    CustomerShopsStatus? status,
    List<Shop>? shops,
    bool? sortedByDistance,
    ShopsArea? area,
    bool clearArea = false,
    bool? browseAll,
    String? errorMessage,
  }) {
    return CustomerShopsState(
      status: status ?? this.status,
      shops: shops ?? this.shops,
      sortedByDistance: sortedByDistance ?? this.sortedByDistance,
      area: clearArea ? null : (area ?? this.area),
      browseAll: browseAll ?? this.browseAll,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    shops,
    sortedByDistance,
    area,
    browseAll,
    errorMessage,
  ];
}
