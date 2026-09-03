import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/barber_document.dart';

abstract class IBarberDocumentsRepo {
  Future<Either<Failure, List<BarberDocument>>> getDocuments();

  Future<Either<Failure, BarberDocument>> uploadDocumentFile(
    int id,
    String filePath,
  );

  Future<Either<Failure, Uint8List>> downloadDocumentFile(int id);

  Future<Either<Failure, Unit>> deleteDocumentFile(int id);
}
