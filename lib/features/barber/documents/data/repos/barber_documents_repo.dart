import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../domain/entities/barber_document.dart';
import '../../domain/repos/i_barber_documents_repo.dart';
import '../apis/barber_documents_api.dart';
import '../models/barber_document_model.dart';

class BarberDocumentsRepo implements IBarberDocumentsRepo {
  final BarberDocumentsApi _api;

  BarberDocumentsRepo(this._api);

  @override
  Future<Either<Failure, List<BarberDocument>>> getDocuments() async {
    final result = await _api.getDocuments();
    return result.map(_mapList);
  }

  @override
  Future<Either<Failure, BarberDocument>> uploadDocumentFile(
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

  List<BarberDocument> _mapList(dynamic response) {
    final data = response['data'] as List? ?? const [];
    return data
        .map<BarberDocument>(
          (e) => BarberDocumentModel.fromJson(e as Map<String, dynamic>),
        )
        .toList();
  }

  BarberDocument _mapOne(dynamic response) {
    return BarberDocumentModel.fromJson(
      response['data'] as Map<String, dynamic>,
    );
  }
}
