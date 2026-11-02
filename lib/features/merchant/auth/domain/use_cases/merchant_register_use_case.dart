import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../shared/auth/domain/entities/register_outcome.dart';
import '../../data/requests/register_request.dart';
import '../repos/i_merchant_auth_repo.dart';

class MerchantRegisterUseCase {
  final IMerchantAuthRepo _repo;

  MerchantRegisterUseCase(this._repo);

  Future<Either<Failure, RegisterOutcome>> call(RegisterRequest request) =>
      _repo.register(request);
}
