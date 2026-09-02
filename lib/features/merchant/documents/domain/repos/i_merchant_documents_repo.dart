import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/merchant_document.dart';

abstract class IMerchantDocumentsRepo {
  Future<Either<Failure, List<MerchantDocument>>> getDocuments();

  Future<Either<Failure, MerchantDocument>> uploadDocumentFile(
    int id,
    String filePath,
  );

  Future<Either<Failure, Uint8List>> downloadDocumentFile(int id);

  Future<Either<Failure, Unit>> deleteDocumentFile(int id);
}
