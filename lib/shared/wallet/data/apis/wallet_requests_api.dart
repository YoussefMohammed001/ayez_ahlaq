import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/error/failure.dart';
import '../wallet_endpoints.dart';
import '../../../../core/network/dio/network_service.dart';

class WalletRequestsApi {
  final NetworkService _networkService;
  final WalletEndpoints _endpoints;

  WalletRequestsApi(this._networkService, this._endpoints);

  Future<Either<Failure, dynamic>> getTransferAccounts() {
    return _networkService.getData(endPoint: _endpoints.transferAccount);
  }

  Future<Either<Failure, dynamic>> getWithdrawMethods() {
    return _networkService.getData(endPoint: _endpoints.withdrawMethods);
  }

  Future<Either<Failure, dynamic>> getWalletRequests({
    required int page,
    required int size,
  }) {
    return _networkService.getData(
      endPoint: _endpoints.requests,
      queryParameters: {'page': page, 'size': size},
    );
  }

  Future<Either<Failure, dynamic>> getWalletRequestDetail(int id) {
    return _networkService.getData(
      endPoint: _endpoints.requestById(id),
    );
  }

  Future<Either<Failure, dynamic>> createWalletRequest({
    required String type,
    required int amount,
    int? transferAccountId,
    int? withdrawMethodId,
    String? withdrawAccount,
    String? note,
    String? filePath,
  }) async {
    return _networkService.uploadFile(
      endPoint: _endpoints.requests,
      formData: FormData.fromMap({
        'type': type,
        'amount': amount.toString(),
        if (transferAccountId != null)
          'transferAccountId': transferAccountId.toString(),
        if (withdrawMethodId != null)
          'withdrawMethodId': withdrawMethodId.toString(),
        if (withdrawAccount != null) 'withdrawAccount': withdrawAccount,
        if (note != null) 'note': note,
        if (filePath != null) 'file': await MultipartFile.fromFile(filePath),
      }),
    );
  }

  Future<Either<Failure, dynamic>> cancelWalletRequest(int id) {
    return _networkService.putData(
      endPoint: _endpoints.requestCancel(id),
      data: const {},
    );
  }

  Future<Either<Failure, dynamic>> getWalletRequestAttachment(int id) {
    return _networkService.getImageData(
      endPoint: _endpoints.requestAttachment(id),
    );
  }
}
