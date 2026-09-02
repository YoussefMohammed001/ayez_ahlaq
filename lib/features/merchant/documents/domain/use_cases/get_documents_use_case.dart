import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/merchant_document.dart';
import '../repos/i_merchant_documents_repo.dart';

class GetDocumentsUseCase {
  final IMerchantDocumentsRepo _repo;

  GetDocumentsUseCase(this._repo);

  Future<Either<Failure, List<MerchantDocument>>> call() =>
      _repo.getDocuments();
}
