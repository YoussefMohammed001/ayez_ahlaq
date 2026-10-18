import 'package:equatable/equatable.dart';
import '../../domain/entities/home_service_broadcast.dart';

enum HomeServiceBroadcastStatus { initial, loading, success, failure }

class HomeServiceBroadcastState extends Equatable {
  final HomeServiceBroadcastStatus status;
  final List<HomeServiceBroadcast> broadcasts;
  final String? errorMessage;
  final int? updatingBroadcastId;

  const HomeServiceBroadcastState({
    this.status = HomeServiceBroadcastStatus.initial,
    this.broadcasts = const [],
    this.errorMessage,
    this.updatingBroadcastId,
  });

  HomeServiceBroadcastState copyWith({
    HomeServiceBroadcastStatus? status,
    List<HomeServiceBroadcast>? broadcasts,
    String? errorMessage,
    int? updatingBroadcastId,
    bool clearUpdatingBroadcastId = false,
  }) {
    return HomeServiceBroadcastState(
      status: status ?? this.status,
      broadcasts: broadcasts ?? this.broadcasts,
      errorMessage: errorMessage,
      updatingBroadcastId: clearUpdatingBroadcastId
          ? null
          : (updatingBroadcastId ?? this.updatingBroadcastId),
    );
  }

  @override
  List<Object?> get props => [
    status,
    broadcasts,
    errorMessage,
    updatingBroadcastId,
  ];
}
