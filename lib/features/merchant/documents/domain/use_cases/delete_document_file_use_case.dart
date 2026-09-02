import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../repos/i_merchant_documents_repo.dart';

class DeleteDocumentFileUseCase {
  final IMerchantDocumentsRepo _repo;

  DeleteDocumentFileUseCase(this._repo);

  Future<Either<Failure, Unit>> call(int id) => _repo.deleteDocumentFile(id);
}
