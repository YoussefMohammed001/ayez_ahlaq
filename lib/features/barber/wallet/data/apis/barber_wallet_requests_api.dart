import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/constants/endpoints.dart';
import '../../../../../core/network/dio/network_service.dart';

class BarberWalletRequestsApi {
  final NetworkService _networkService;

  BarberWalletRequestsApi(this._networkService);

  Future<Either<Failure, dynamic>> getWalletRequests({
    required int page,
    required int size,
  }) {
    return _networkService.getData(
      endPoint: EndPoints.barberWalletRequests,
      queryParameters: {'page': page, 'size': size},
    );
  }

  Future<Either<Failure, dynamic>> getWalletRequestDetail(int id) {
    return _networkService.getData(
      endPoint: EndPoints.barberWalletRequestById(id),
    );
  }

  Future<Either<Failure, dynamic>> createWalletRequest({
    required String type,
    required int amount,
    String? note,
    String? filePath,
  }) async {
    return _networkService.uploadFile(
      endPoint: EndPoints.barberWalletRequests,
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
      endPoint: EndPoints.barberWalletRequestCancel(id),
      data: const {},
    );
  }

  Future<Either<Failure, dynamic>> getWalletRequestAttachment(int id) {
    return _networkService.getImageData(
      endPoint: EndPoints.barberWalletRequestAttachment(id),
    );
  }
}
