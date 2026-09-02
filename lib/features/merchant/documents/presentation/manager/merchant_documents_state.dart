import 'package:equatable/equatable.dart';
import '../../domain/entities/merchant_document.dart';

enum DocumentsStatus { initial, loading, success, failure }

class MerchantDocumentsState extends Equatable {
  final DocumentsStatus status;
  final List<MerchantDocument> documents;
  final Set<int> busyIds;
  final String? errorMessage;

  const MerchantDocumentsState({
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

  MerchantDocumentsState copyWith({
    DocumentsStatus? status,
    List<MerchantDocument>? documents,
    Set<int>? busyIds,
    String? errorMessage,
  }) {
    return MerchantDocumentsState(
      status: status ?? this.status,
      documents: documents ?? this.documents,
      busyIds: busyIds ?? this.busyIds,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, documents, busyIds, errorMessage];
}
