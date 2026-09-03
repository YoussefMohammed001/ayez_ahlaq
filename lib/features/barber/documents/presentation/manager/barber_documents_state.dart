import 'package:equatable/equatable.dart';
import '../../domain/entities/barber_document.dart';

enum DocumentsStatus { initial, loading, success, failure }

class BarberDocumentsState extends Equatable {
  final DocumentsStatus status;
  final List<BarberDocument> documents;
  final Set<int> busyIds;
  final String? errorMessage;

  const BarberDocumentsState({
    this.status = DocumentsStatus.initial,
    this.documents = const [],
    this.busyIds = const {},
    this.errorMessage,
  });

  int get missingRequiredCount =>
      documents.where((d) => d.isMissingRequired).length;

  int get missingOptionalCount =>
      documents.where((d) => !d.required && !d.hasFile).length;

  int get uploadedCount => documents.where((d) => d.hasFile).length;

  bool get isComplete =>
      documents.isNotEmpty && missingRequiredCount == 0;

  bool isBusy(int id) => busyIds.contains(id);

  BarberDocumentsState copyWith({
    DocumentsStatus? status,
    List<BarberDocument>? documents,
    Set<int>? busyIds,
    String? errorMessage,
  }) {
    return BarberDocumentsState(
      status: status ?? this.status,
      documents: documents ?? this.documents,
      busyIds: busyIds ?? this.busyIds,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, documents, busyIds, errorMessage];
}
