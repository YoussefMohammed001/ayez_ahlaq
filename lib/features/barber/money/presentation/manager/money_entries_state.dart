import 'package:equatable/equatable.dart';
import '../../domain/entities/money_entry.dart';

enum MoneyEntriesStatus { initial, loading, loadingMore, success, failure }

class MoneyEntriesState extends Equatable {
  final MoneyEntriesStatus status;
  final List<MoneyEntry> entries;
  final int page;
  final bool hasMore;
  final String? errorMessage;
  final bool isSubmitting;

  const MoneyEntriesState({
    this.status = MoneyEntriesStatus.initial,
    this.entries = const [],
    this.page = 0,
    this.hasMore = false,
    this.errorMessage,
    this.isSubmitting = false,
  });

  MoneyEntriesState copyWith({
    MoneyEntriesStatus? status,
    List<MoneyEntry>? entries,
    int? page,
    bool? hasMore,
    String? errorMessage,
    bool? isSubmitting,
  }) {
    return MoneyEntriesState(
      status: status ?? this.status,
      entries: entries ?? this.entries,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
      errorMessage: errorMessage,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }

  @override
  List<Object?> get props =>
      [status, entries, page, hasMore, errorMessage, isSubmitting];
}
