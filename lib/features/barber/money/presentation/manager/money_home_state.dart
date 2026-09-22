import 'package:equatable/equatable.dart';
import '../../domain/entities/money_occurrence.dart';
import '../../domain/entities/money_summary.dart';

enum MoneyHomeStatus { initial, loading, success, failure }

class MoneyHomeState extends Equatable {
  final MoneyHomeStatus status;
  final MoneySummary? summary;
  final List<MoneyOccurrence> pendingOccurrences;
  final Set<int> processingOccurrenceIds;
  final String? errorMessage;

  const MoneyHomeState({
    this.status = MoneyHomeStatus.initial,
    this.summary,
    this.pendingOccurrences = const [],
    this.processingOccurrenceIds = const {},
    this.errorMessage,
  });

  bool isProcessing(int id) => processingOccurrenceIds.contains(id);

  MoneyHomeState copyWith({
    MoneyHomeStatus? status,
    MoneySummary? summary,
    List<MoneyOccurrence>? pendingOccurrences,
    Set<int>? processingOccurrenceIds,
    String? errorMessage,
  }) {
    return MoneyHomeState(
      status: status ?? this.status,
      summary: summary ?? this.summary,
      pendingOccurrences: pendingOccurrences ?? this.pendingOccurrences,
      processingOccurrenceIds: processingOccurrenceIds ?? this.processingOccurrenceIds,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    summary,
    pendingOccurrences,
    processingOccurrenceIds,
    errorMessage,
  ];
}
