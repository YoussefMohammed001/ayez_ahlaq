import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../shared/auth/data/local/auth_local_data_source.dart';
import '../../../../../shared/auth/data/models/auth_session_model.dart';
import '../../../../../shared/auth/domain/entities/auth_session.dart';
import '../../../../../shared/user_type.dart';
import '../../domain/repos/i_customer_auth_repo.dart';
import '../apis/customer_auth_api.dart';
import '../requests/customer_register_request.dart';

class CustomerAuthRepo implements ICustomerAuthRepo {
  final CustomerAuthApi _api;
  final AuthLocalDataSource _localDataSource;

  CustomerAuthRepo(this._api, this._localDataSource);

  @override
  Future<Either<Failure, AuthSession>> login(
    String identifier,
    String password,
  ) async {
    final result = await _api.login(identifier, password);
    return _persist(result, identifier);
  }

  @override
  Future<Either<Failure, AuthSession>> register(
    CustomerRegisterRequest request,
  ) async {
    final result = await _api.register(request);
    return _persist(result, request.phoneNumber);
  }

  @override
  Future<void> logout() => _localDataSource.clearSession();

  Future<Either<Failure, AuthSession>> _persist(
    Either<Failure, dynamic> result,
    String phone,
  ) async {
    final session = result.map(
      (response) =>
          AuthSessionModel.fromJson(response['data'] as Map<String, dynamic>),
    );

    await session.fold(
      (_) async {},
      (value) => _localDataSource.saveSession(value, phone, UserType.customer),
    );

    return session;
  }
}
