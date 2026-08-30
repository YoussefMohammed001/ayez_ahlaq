import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../shared/auth/domain/entities/auth_session.dart';
import '../repos/i_merchant_auth_repo.dart';

class MerchantLoginUseCase {
  final IMerchantAuthRepo _repo;

  MerchantLoginUseCase(this._repo);

  Future<Either<Failure, AuthSession>> call(String phone, String password) =>
      _repo.login(phone, password);
}
