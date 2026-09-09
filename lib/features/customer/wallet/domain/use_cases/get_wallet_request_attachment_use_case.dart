import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../repos/i_customer_wallet_requests_repo.dart';

class GetWalletRequestAttachmentUseCase {
  final ICustomerWalletRequestsRepo _repo;

  GetWalletRequestAttachmentUseCase(this._repo);

  Future<Either<Failure, Uint8List>> call(int id) =>
      _repo.getWalletRequestAttachment(id);
}
