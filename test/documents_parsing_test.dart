import 'package:flutter_test/flutter_test.dart';
import 'package:ayez_ahlaq/features/merchant/documents/data/models/merchant_document_model.dart';

void main() {
  test('parses live attachment payload with an uploaded file', () {
    final document = MerchantDocumentModel.fromJson({
      'id': 3,
      'name': 'سجل تجاري',
      'required': true,
      'createdByType': 'ADMIN',
      'hasFile': true,
      'originalFileName': '1.jpg',
      'contentType': 'image/jpeg',
      'sizeBytes': 607984,
      'uploadedByType': 'ADMIN',
      'uploadedAt': '2026-08-28T00:35:24',
      'createdAt': '2026-08-28T00:30:11',
      'deletedAt': null,
    });

    expect(document.id, 3);
    expect(document.required, isTrue);
    expect(document.hasFile, isTrue);
    expect(document.isImage, isTrue);
    expect(document.isPdf, isFalse);
    expect(document.isMissingRequired, isFalse);
    expect(document.isLockedByAdmin, isTrue);
    expect(document.uploadedAt, isNotNull);
  });

  test('parses an empty required slot', () {
    final document = MerchantDocumentModel.fromJson({
      'id': 4,
      'name': 'بطاقة ضريبية',
      'required': true,
      'createdByType': 'ADMIN',
      'hasFile': false,
      'originalFileName': null,
      'contentType': null,
      'sizeBytes': null,
      'uploadedByType': null,
      'uploadedAt': null,
      'createdAt': '2026-08-28T00:30:20',
      'deletedAt': null,
    });

    expect(document.hasFile, isFalse);
    expect(document.isMissingRequired, isTrue);
    expect(document.isLockedByAdmin, isFalse);
    expect(document.uploadedAt, isNull);
    expect(document.isImage, isFalse);
  });

  test('detects a pdf upload made by the merchant', () {
    final document = MerchantDocumentModel.fromJson({
      'id': 5,
      'name': 'صورة عقد المحل (ايجار - ملك)',
      'required': false,
      'hasFile': true,
      'originalFileName': 'contract.pdf',
      'contentType': 'application/pdf',
      'sizeBytes': 1024,
      'uploadedByType': 'MERCHANT',
      'uploadedAt': '2026-09-02T13:24:42.48954979',
    });

    expect(document.isPdf, isTrue);
    expect(document.isImage, isFalse);
    expect(document.isMissingRequired, isFalse);
    expect(document.isLockedByAdmin, isFalse);
    expect(document.uploadedAt, isNotNull);
  });
}
