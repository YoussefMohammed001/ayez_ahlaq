import 'package:equatable/equatable.dart';
import '../../domain/entities/wallet_request.dart';

enum WalletRequestsListStatus { initial, loading, loadingMore, success, failure }

class MerchantWalletRequestsState extends Equatable {
  final WalletRequestsListStatus status;
  final List<WalletRequest> requests;
  final int page;
  final bool hasMore;
  final Set<int> cancellingIds;
  final String? errorMessage;

  const MerchantWalletRequestsState({
    this.status = WalletRequestsListStatus.initial,
    this.requests = const [],
    this.page = 0,
    this.hasMore = false,
    this.cancellingIds = const {},
    this.errorMessage,
  });

  bool isCancelling(int id) => cancellingIds.contains(id);

  MerchantWalletRequestsState copyWith({
    WalletRequestsListStatus? status,
    List<WalletRequest>? requests,
    int? page,
    bool? hasMore,
    Set<int>? cancellingIds,
    String? errorMessage,
  }) {
    return MerchantWalletRequestsState(
      status: status ?? this.status,
      requests: requests ?? this.requests,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
      cancellingIds: cancellingIds ?? this.cancellingIds,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    requests,
    page,
    hasMore,
    cancellingIds,
    errorMessage,
  ];
}
