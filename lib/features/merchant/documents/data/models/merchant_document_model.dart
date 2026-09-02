import '../../domain/entities/merchant_document.dart';

class MerchantDocumentModel extends MerchantDocument {
  const MerchantDocumentModel({
    required super.id,
    required super.name,
    required super.required,
    required super.hasFile,
    super.originalFileName,
    super.contentType,
    super.sizeBytes,
    super.uploadedByType,
    super.uploadedAt,
  });

  factory MerchantDocumentModel.fromJson(Map<String, dynamic> json) {
    return MerchantDocumentModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
      required: json['required'] as bool? ?? false,
      hasFile: json['hasFile'] as bool? ?? false,
      originalFileName: json['originalFileName'] as String?,
      contentType: json['contentType'] as String?,
      sizeBytes: (json['sizeBytes'] as num?)?.toInt(),
      uploadedByType: json['uploadedByType'] as String?,
      uploadedAt: DateTime.tryParse(json['uploadedAt'] as String? ?? ''),
    );
  }
}
