import 'package:equatable/equatable.dart';
import '../../domain/entities/home_service_shop.dart';

enum HomeServiceShopsStatus { initial, loading, success, failure }

class HomeServiceShopsState extends Equatable {
  final HomeServiceShopsStatus status;
  final List<HomeServiceShop> shops;
  final bool sortedByDistance;
  final String? errorMessage;

  const HomeServiceShopsState({
    this.status = HomeServiceShopsStatus.initial,
    this.shops = const [],
    this.sortedByDistance = false,
    this.errorMessage,
  });

  HomeServiceShopsState copyWith({
    HomeServiceShopsStatus? status,
    List<HomeServiceShop>? shops,
    bool? sortedByDistance,
    String? errorMessage,
  }) {
    return HomeServiceShopsState(
      status: status ?? this.status,
      shops: shops ?? this.shops,
      sortedByDistance: sortedByDistance ?? this.sortedByDistance,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, shops, sortedByDistance, errorMessage];
}
