import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../domain/entities/transfer_account.dart';
import '../../domain/entities/wallet_request.dart';
import '../../domain/entities/wallet_request_page.dart';
import '../../domain/entities/wallet_request_type.dart';
import '../../domain/entities/withdraw_method.dart';
import '../../domain/repos/i_customer_wallet_requests_repo.dart';
import '../apis/customer_wallet_requests_api.dart';
import '../models/transfer_account_model.dart';
import '../models/wallet_request_model.dart';
import '../models/wallet_request_page_model.dart';
import '../models/withdraw_method_model.dart';

class CustomerWalletRequestsRepo implements ICustomerWalletRequestsRepo {
  final CustomerWalletRequestsApi _api;

  CustomerWalletRequestsRepo(this._api);

  @override
  Future<Either<Failure, List<TransferAccount>>> getTransferAccounts() async {
    final result = await _api.getTransferAccounts();
    return result.map((response) {
      final data = response['data'] as List? ?? const [];
      return data
          .map((json) => TransferAccountModel.fromJson(json as Map<String, dynamic>))
          .toList();
    });
  }

  @override
  Future<Either<Failure, List<WithdrawMethod>>> getWithdrawMethods() async {
    final result = await _api.getWithdrawMethods();
    return result.map((response) {
      final data = response['data'] as List? ?? const [];
      return data
          .map((json) => WithdrawMethodModel.fromJson(json as Map<String, dynamic>))
          .toList();
    });
  }

  @override
  Future<Either<Failure, WalletRequestPage>> getWalletRequests({
    required int page,
    required int size,
  }) async {
    final result = await _api.getWalletRequests(page: page, size: size);
    return result.map(_mapPage);
  }

  @override
  Future<Either<Failure, WalletRequest>> getWalletRequestDetail(int id) async {
    final result = await _api.getWalletRequestDetail(id);
    return result.map(_mapOne);
  }

  @override
  Future<Either<Failure, WalletRequest>> createWalletRequest({
    required WalletRequestType type,
    required int amount,
    int? transferAccountId,
    int? withdrawMethodId,
    String? withdrawAccount,
    String? note,
    String? filePath,
  }) async {
    final result = await _api.createWalletRequest(
      type: type.toApi(),
      amount: amount,
      transferAccountId: transferAccountId,
      withdrawMethodId: withdrawMethodId,
      withdrawAccount: withdrawAccount,
      note: note,
      filePath: filePath,
    );
    return result.map(_mapOne);
  }

  @override
  Future<Either<Failure, WalletRequest>> cancelWalletRequest(int id) async {
    final result = await _api.cancelWalletRequest(id);
    return result.map(_mapOne);
  }

  @override
  Future<Either<Failure, Uint8List>> getWalletRequestAttachment(int id) async {
    final result = await _api.getWalletRequestAttachment(id);
    return result.map((bytes) => Uint8List.fromList(bytes as List<int>));
  }

  WalletRequestPage _mapPage(dynamic response) {
    return WalletRequestPageModel.fromJson(
      response['data'] as Map<String, dynamic>,
    );
  }

  WalletRequest _mapOne(dynamic response) {
    return WalletRequestModel.fromJson(response['data'] as Map<String, dynamic>);
  }
}
