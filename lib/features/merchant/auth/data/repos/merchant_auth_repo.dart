import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/response_guard.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../shared/auth/data/local/auth_local_data_source.dart';
import '../../../../../shared/auth/data/models/auth_session_model.dart';
import '../../../../../shared/auth/domain/entities/auth_session.dart';
import '../../../../../shared/auth/domain/entities/password_reset_ticket.dart';
import '../../../../../shared/user_type.dart';
import '../../domain/repos/i_merchant_auth_repo.dart';
import '../apis/merchant_auth_api.dart';
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
  Future<Either<Failure, Unit>> register(RegisterRequest request) async {
    final result = await _api.register(request);
    return result.map((_) => unit);
  }

  @override
  Future<Either<Failure, AuthSession>> verifyRegisterOtp(
    String phone,
    String otp,
  ) async {
    final result = await _api.verifyRegisterOtp(phone, otp);
    return _persist(result, phone);
  }

  @override
  Future<Either<Failure, String>> resendRegisterOtp(String phone) async {
    final result = await _api.resendRegisterOtp(phone);
    return result.map(
      (response) => response['message'] as String? ?? S().otpResentMessage,
    );
  }

  @override
  Future<Either<Failure, Unit>> forgotPassword(String phone) async {
    final result = await _api.forgotPassword(phone);
    return result.map((_) => unit);
  }

  @override
  Future<Either<Failure, PasswordResetTicket>> verifyPasswordOtp(
    String phone,
    String code,
  ) async {
    final result = await _api.verifyPasswordOtp(phone, code);
    return result.map(
      (response) => PasswordResetTicket(
        resetToken: response['data']?['resetToken'] as String? ?? '',
      ),
    );
  }

  @override
  Future<Either<Failure, Unit>> resetPassword(
    String resetToken,
    String newPassword,
  ) async {
    final result = await _api.resetPassword(resetToken, newPassword);
    return result.map((_) => unit);
  }

  @override
  Future<void> logout() => _localDataSource.clearSession();

  Future<Either<Failure, AuthSession>> _persist(
    Either<Failure, dynamic> result,
    String phone,
  ) async {
    final session = result.flatMap(
      (response) => requireDataMap(response).map(AuthSessionModel.fromJson),
    );

    await session.fold(
      (_) async {},
      (value) => _localDataSource.saveSession(value, phone, UserType.merchant),
    );

    return session;
  }
}
