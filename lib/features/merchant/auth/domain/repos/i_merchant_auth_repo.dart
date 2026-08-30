import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../data/requests/register_request.dart';
import '../../../../../shared/auth/domain/entities/auth_session.dart';

abstract class IMerchantAuthRepo {
  Future<Either<Failure, AuthSession>> login(String phone, String password);

  Future<Either<Failure, AuthSession>> register(RegisterRequest request);

  Future<void> logout();
}
