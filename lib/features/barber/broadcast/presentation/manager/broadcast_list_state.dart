import 'package:equatable/equatable.dart';
import '../../domain/entities/broadcast.dart';

enum BroadcastListStatus { initial, loading, loadingMore, success, failure }

class BroadcastListState extends Equatable {
  final BroadcastListStatus status;
  final List<Broadcast> broadcasts;
  final int page;
  final bool hasMore;
  final String? errorMessage;

  const BroadcastListState({
    this.status = BroadcastListStatus.initial,
    this.broadcasts = const [],
    this.page = 0,
    this.hasMore = false,
    this.errorMessage,
  });

  BroadcastListState copyWith({
    BroadcastListStatus? status,
    List<Broadcast>? broadcasts,
    int? page,
    bool? hasMore,
    String? errorMessage,
  }) {
    return BroadcastListState(
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
