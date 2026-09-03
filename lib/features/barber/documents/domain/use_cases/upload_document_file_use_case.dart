import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/barber_document.dart';
import '../repos/i_barber_documents_repo.dart';

class UploadDocumentFileUseCase {
  final IBarberDocumentsRepo _repo;

  UploadDocumentFileUseCase(this._repo);

  Future<Either<Failure, BarberDocument>> call(int id, String filePath) =>
      _repo.uploadDocumentFile(id, filePath);
}