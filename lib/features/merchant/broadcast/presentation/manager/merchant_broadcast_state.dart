import 'package:equatable/equatable.dart';

enum MerchantBroadcastStatus { initial, sending, success, failure }

enum MerchantBroadcastScope { all, zone }

class MerchantBroadcastState extends Equatable {
  final MerchantBroadcastStatus status;
  final MerchantBroadcastScope scope;
  final String? errorMessage;

  const MerchantBroadcastState({
    this.status = MerchantBroadcastStatus.initial,
    this.scope = MerchantBroadcastScope.all,
    this.errorMessage,
  });

  MerchantBroadcastState copyWith({
    MerchantBroadcastStatus? status,
    MerchantBroadcastScope? scope,
    String? errorMessage,
  }) {
    return MerchantBroadcastState(
      status: status ?? this.status,
      scope: scope ?? this.scope,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, scope, errorMessage];
}
