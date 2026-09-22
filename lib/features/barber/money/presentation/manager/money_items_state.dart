import 'package:equatable/equatable.dart';
import '../../domain/entities/money_item.dart';

enum MoneyItemsStatus { initial, loading, success, failure }

class MoneyItemsState extends Equatable {
  final MoneyItemsStatus status;
  final List<MoneyItem> items;
  final Set<int> mutatingIds;
  final String? errorMessage;

  const MoneyItemsState({
    this.status = MoneyItemsStatus.initial,
    this.items = const [],
    this.mutatingIds = const {},
    this.errorMessage,
  });

  bool isMutating(int id) => mutatingIds.contains(id);

  MoneyItemsState copyWith({
    MoneyItemsStatus? status,
    List<MoneyItem>? items,
    Set<int>? mutatingIds,
    String? errorMessage,
  }) {
    return MoneyItemsState(
      status: status ?? this.status,
      items: items ?? this.items,
      mutatingIds: mutatingIds ?? this.mutatingIds,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, items, mutatingIds, errorMessage];
}
