import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../repos/i_merchant_documents_repo.dart';

class DownloadDocumentFileUseCase {
  final IMerchantDocumentsRepo _repo;

  DownloadDocumentFileUseCase(this._repo);

  Future<Either<Failure, Uint8List>> call(int id) =>
      _repo.downloadDocumentFile(id);
}
