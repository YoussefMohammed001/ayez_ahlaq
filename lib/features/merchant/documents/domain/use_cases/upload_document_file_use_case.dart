import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/merchant_document.dart';
import '../repos/i_merchant_documents_repo.dart';

class UploadDocumentFileUseCase {
  final IMerchantDocumentsRepo _repo;

  UploadDocumentFileUseCase(this._repo);

  Future<Either<Failure, MerchantDocument>> call(int id, String filePath) =>
      _repo.uploadDocumentFile(id, filePath);
}
