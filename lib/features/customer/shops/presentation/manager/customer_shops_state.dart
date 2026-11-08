import 'package:equatable/equatable.dart';
import '../../domain/entities/shop.dart';
import '../../domain/entities/shops_area.dart';

enum CustomerShopsStatus { initial, loading, success, failure }

class CustomerShopsState extends Equatable {
  final CustomerShopsStatus status;
  final List<Shop> shops;
  final bool sortedByDistance;
  final ShopsArea? area;
  final String? errorMessage;

  const CustomerShopsState({
    this.status = CustomerShopsStatus.initial,
    this.shops = const [],
    this.sortedByDistance = false,
    this.area,
    this.errorMessage,
  });

  bool get isBrowsingElsewhere => area != null;

  CustomerShopsState copyWith({
    CustomerShopsStatus? status,
    List<Shop>? shops,
    bool? sortedByDistance,
    ShopsArea? area,
    bool clearArea = false,
    String? errorMessage,
  }) {
    return CustomerShopsState(
      status: status ?? this.status,
      shops: shops ?? this.shops,
      sortedByDistance: sortedByDistance ?? this.sortedByDistance,
      area: clearArea ? null : (area ?? this.area),
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    shops,
    sortedByDistance,
    area,
    errorMessage,
  ];
}
