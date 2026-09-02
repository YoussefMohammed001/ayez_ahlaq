import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../domain/entities/merchant_document.dart';
import '../../domain/repos/i_merchant_documents_repo.dart';
import '../apis/merchant_documents_api.dart';
import '../models/merchant_document_model.dart';

class MerchantDocumentsRepo implements IMerchantDocumentsRepo {
  final MerchantDocumentsApi _api;

  MerchantDocumentsRepo(this._api);

  @override
  Future<Either<Failure, List<MerchantDocument>>> getDocuments() async {
    final result = await _api.getDocuments();
    return result.map(_mapList);
  }

  @override
  Future<Either<Failure, MerchantDocument>> uploadDocumentFile(
    int id,
    String filePath,
  ) async {
    final result = await _api.uploadDocumentFile(id, filePath);
    return result.map(_mapOne);
  }

  @override
  Future<Either<Failure, Uint8List>> downloadDocumentFile(int id) async {
    final result = await _api.downloadDocumentFile(id);
    return result.map((bytes) => Uint8List.fromList(bytes as List<int>));
  }

  @override
  Future<Either<Failure, Unit>> deleteDocumentFile(int id) async {
    final result = await _api.deleteDocumentFile(id);
    return result.map((_) => unit);
  }

  List<MerchantDocument> _mapList(dynamic response) {
    final data = response['data'] as List? ?? const [];
    return data
        .map<MerchantDocument>(
          (e) => MerchantDocumentModel.fromJson(e as Map<String, dynamic>),
        )
        .toList();
  }

  MerchantDocument _mapOne(dynamic response) {
    return MerchantDocumentModel.fromJson(
      response['data'] as Map<String, dynamic>,
    );
  }
}
