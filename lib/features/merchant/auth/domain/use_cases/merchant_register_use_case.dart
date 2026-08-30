import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../data/requests/register_request.dart';
import '../../../../../shared/auth/domain/entities/auth_session.dart';
import '../repos/i_merchant_auth_repo.dart';

class MerchantRegisterUseCase {
  final IMerchantAuthRepo _repo;

  MerchantRegisterUseCase(this._repo);

  Future<Either<Failure, AuthSession>> call(RegisterRequest request) =>
      _repo.register(request);
}
