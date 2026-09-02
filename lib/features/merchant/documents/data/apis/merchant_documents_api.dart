import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/constants/endpoints.dart';
import '../../../../../core/network/dio/network_service.dart';

class MerchantDocumentsApi {
  final NetworkService _networkService;

  MerchantDocumentsApi(this._networkService);

  Future<Either<Failure, dynamic>> getDocuments() {
    return _networkService.getData(endPoint: EndPoints.merchantAttachment);
  }

  Future<Either<Failure, dynamic>> uploadDocumentFile(
    int id,
    String filePath,
  ) async {
    return _networkService.uploadFile(
      endPoint: EndPoints.merchantAttachmentFile(id),
      formData: FormData.fromMap({
        'file': await MultipartFile.fromFile(filePath),
      }),
    );
  }

  Future<Either<Failure, dynamic>> downloadDocumentFile(int id) {
    return _networkService.getImageData(
      endPoint: EndPoints.merchantAttachmentFile(id),
    );
  }

  Future<Either<Failure, dynamic>> deleteDocumentFile(int id) {
    return _networkService.deleteData(
      endPoint: EndPoints.merchantAttachmentFile(id),
    );
  }
}
