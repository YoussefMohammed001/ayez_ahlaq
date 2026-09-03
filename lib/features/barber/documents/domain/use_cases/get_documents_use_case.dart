import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/barber_document.dart';
import '../repos/i_barber_documents_repo.dart';

class GetDocumentsUseCase {
  final IBarberDocumentsRepo _repo;

  GetDocumentsUseCase(this._repo);

  Future<Either<Failure, List<BarberDocument>>> call() => _repo.getDocuments();
}
