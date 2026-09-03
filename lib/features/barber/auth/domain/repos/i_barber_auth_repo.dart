import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../shared/auth/domain/entities/auth_session.dart';

abstract class IBarberAuthRepo {
  Future<Either<Failure, AuthSession>> login(
    String identifier,
    String password,
  );

  Future<void> logout();
}
