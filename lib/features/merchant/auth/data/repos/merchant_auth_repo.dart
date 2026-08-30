import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../shared/auth/domain/entities/auth_session.dart';
import '../../domain/repos/i_merchant_auth_repo.dart';
import '../apis/merchant_auth_api.dart';
import '../../../../../shared/auth/data/local/auth_local_data_source.dart';
import '../../../../../shared/auth/data/models/auth_session_model.dart';
import '../requests/register_request.dart';

class MerchantAuthRepo implements IMerchantAuthRepo {
  final MerchantAuthApi _api;
  final AuthLocalDataSource _localDataSource;

  MerchantAuthRepo(this._api, this._localDataSource);

  @override
  Future<Either<Failure, AuthSession>> login(
    String phone,
    String password,
  ) async {
    final result = await _api.login(phone, password);
    return _persist(result, phone);
  }

  @override
  Future<Either<Failure, AuthSession>> register(
    RegisterRequest request,
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
      (value) => _localDataSource.saveSession(value, phone),
    );

    return session;
  }
}
