import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/wallet_request.dart';
import '../entities/wallet_request_page.dart';
import '../entities/wallet_request_type.dart';

abstract class IMerchantWalletRequestsRepo {
  Future<Either<Failure, WalletRequestPage>> getWalletRequests({
    required int page,
    required int size,
  });

  Future<Either<Failure, WalletRequest>> getWalletRequestDetail(int id);

  Future<Either<Failure, WalletRequest>> createWalletRequest({
    required WalletRequestType type,
    required int amount,
    String? note,
    String? filePath,
  });

  Future<Either<Failure, WalletRequest>> cancelWalletRequest(int id);

  Future<Either<Failure, Uint8List>> getWalletRequestAttachment(int id);
}
