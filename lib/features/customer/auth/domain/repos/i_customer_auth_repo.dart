import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../shared/auth/domain/entities/auth_session.dart';
import '../../data/requests/customer_register_request.dart';

abstract class ICustomerAuthRepo {
  Future<Either<Failure, AuthSession>> login(String identifier, String password);

  Future<Either<Failure, AuthSession>> register(CustomerRegisterRequest request);

  Future<void> logout();
}
