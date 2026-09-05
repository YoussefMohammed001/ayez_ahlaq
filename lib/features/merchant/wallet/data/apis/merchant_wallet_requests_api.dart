import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/constants/endpoints.dart';
import '../../../../../core/network/dio/network_service.dart';

class MerchantWalletRequestsApi {
  final NetworkService _networkService;

  MerchantWalletRequestsApi(this._networkService);

  Future<Either<Failure, dynamic>> getWalletRequests({
    required int page,
    required int size,
  }) {
    return _networkService.getData(
      endPoint: EndPoints.merchantWalletRequests,
      queryParameters: {'page': page, 'size': size},
    );
  }

  Future<Either<Failure, dynamic>> getWalletRequestDetail(int id) {
    return _networkService.getData(
      endPoint: EndPoints.merchantWalletRequestById(id),
    );
  }

  Future<Either<Failure, dynamic>> createWalletRequest({
    required String type,
    required int amount,
    String? note,
    String? filePath,
  }) async {
    return _networkService.uploadFile(
      endPoint: EndPoints.merchantWalletRequests,
      formData: FormData.fromMap({
        'type': type,
        'amount': amount.toString(),
        if (note != null) 'note': note,
        if (filePath != null) 'file': await MultipartFile.fromFile(filePath),
      }),
    );
  }

  Future<Either<Failure, dynamic>> cancelWalletRequest(int id) {
    return _networkService.putData(
      endPoint: EndPoints.merchantWalletRequestCancel(id),
      data: const {},
    );
  }

  Future<Either<Failure, dynamic>> getWalletRequestAttachment(int id) {
    return _networkService.getImageData(
      endPoint: EndPoints.merchantWalletRequestAttachment(id),
    );
  }
}
