import 'package:equatable/equatable.dart';
import '../../domain/entities/broadcast.dart';

enum MerchantBroadcastListStatus { initial, loading, loadingMore, success, failure }

class MerchantBroadcastListState extends Equatable {
  final MerchantBroadcastListStatus status;
  final List<Broadcast> broadcasts;
  final int page;
  final bool hasMore;
  final String? errorMessage;

  const MerchantBroadcastListState({
    this.status = MerchantBroadcastListStatus.initial,
    this.broadcasts = const [],
    this.page = 0,
    this.hasMore = false,
    this.errorMessage,
  });

  MerchantBroadcastListState copyWith({
    MerchantBroadcastListStatus? status,
    List<Broadcast>? broadcasts,
    int? page,
    bool? hasMore,
    String? errorMessage,
  }) {
    return MerchantBroadcastListState(
      status: status ?? this.status,
      broadcasts: broadcasts ?? this.broadcasts,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, broadcasts, page, hasMore, errorMessage];
}
