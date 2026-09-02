import 'package:equatable/equatable.dart';

class MerchantDocument extends Equatable {
  final int id;
  final String name;
  final bool required;
  final bool hasFile;
  final String? originalFileName;
  final String? contentType;
  final int? sizeBytes;
  final String? uploadedByType;
  final DateTime? uploadedAt;

  const MerchantDocument({
    required this.id,
    required this.name,
    required this.required,
    required this.hasFile,
    this.originalFileName,
    this.contentType,
    this.sizeBytes,
    this.uploadedByType,
    this.uploadedAt,
  });

  bool get isPdf => contentType == 'application/pdf';

  bool get isImage => contentType?.startsWith('image/') ?? false;

  bool get isMissingRequired => required && !hasFile;

  bool get isLockedByAdmin => hasFile && uploadedByType == 'ADMIN';

  @override
  List<Object?> get props => [
    id,
    name,
    required,
    hasFile,
    originalFileName,
    contentType,
    sizeBytes,
    uploadedByType,
    uploadedAt,
  ];
}
