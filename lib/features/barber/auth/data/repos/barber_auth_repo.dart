import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../shared/auth/domain/entities/auth_session.dart';
import '../../../../../shared/auth/data/local/auth_local_data_source.dart';
import '../../../../../shared/auth/data/models/auth_session_model.dart';
import '../../../../../shared/user_type.dart';
import '../../domain/repos/i_barber_auth_repo.dart';
import '../apis/barber_auth_api.dart';

class BarberAuthRepo implements IBarberAuthRepo {
  final BarberAuthApi _api;
  final AuthLocalDataSource _localDataSource;

  BarberAuthRepo(this._api, this._localDataSource);

  @override
  Future<Either<Failure, AuthSession>> login(
    String identifier,
    String password,
  ) async {
    final result = await _api.login(identifier, password);

    final session = result.map(
      (response) =>
          AuthSessionModel.fromJson(response['data'] as Map<String, dynamic>),
    );

    await session.fold(
      (_) async {},
      (value) => _localDataSource.saveSession(value, identifier, UserType.barber),
    );

    return session;
  }

  @override
  Future<void> logout() => _localDataSource.clearSession();
}
