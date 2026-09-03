import 'package:equatable/equatable.dart';
import '../../domain/entities/store_merchant.dart';

enum BarberStoreMerchantsStatus { initial, loading, success, failure }

class BarberStoreMerchantsState extends Equatable {
  final BarberStoreMerchantsStatus status;
  final List<StoreMerchant> merchants;
  final String? errorMessage;

  const BarberStoreMerchantsState({
    this.status = BarberStoreMerchantsStatus.initial,
    this.merchants = const [],
    this.errorMessage,
  });

  BarberStoreMerchantsState copyWith({
    BarberStoreMerchantsStatus? status,
    List<StoreMerchant>? merchants,
    String? errorMessage,
  }) {
    return BarberStoreMerchantsState(
      status: status ?? this.status,
      merchants: merchants ?? this.merchants,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, merchants, errorMessage];
}
