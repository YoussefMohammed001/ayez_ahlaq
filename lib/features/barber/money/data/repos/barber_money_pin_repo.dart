import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/response_guard.dart';
import '../../domain/entities/money_pin_reset_status.dart';
import '../../domain/repos/i_barber_money_pin_repo.dart';
import '../apis/barber_money_pin_api.dart';
import '../models/money_pin_reset_status_model.dart';

class BarberMoneyPinRepo implements IBarberMoneyPinRepo {
  final BarberMoneyPinApi _api;

  BarberMoneyPinRepo(this._api);

  @override
  Future<Either<Failure, bool>> hasPin() async {
    final result = await _api.getStatus();
    return result.fold(
      (failure) => failure.statusCode == 404
          ? const Right(false)
          : Left(failure),
      (response) {
        final data = response is Map ? response['data'] : null;
        if (data is Map) {
          final flag = data['hasPin'] ?? data['exists'];
          if (flag is bool) return Right(flag);
        }
        return Right(data != null);
      },
    );
  }

  @override
  Future<Either<Failure, void>> setup(String pin) async {
    return (await _api.setup(pin)).map((_) {});
  }

  @override
  Future<Either<Failure, void>> verify(String pin) async {
    return (await _api.verify(pin)).map((_) {});
  }

  @override
  Future<Either<Failure, void>> change({
    required String currentPin,
    required String newPin,
  }) async {
    return (await _api.change(currentPin: currentPin, newPin: newPin)).map((_) {});
  }

  @override
  Future<Either<Failure, MoneyPinResetStatus>> getResetRequestStatus() async {
    final result = await _api.getResetRequestStatus();
    return result.flatMap(_mapResetStatus);
  }

  @override
  Future<Either<Failure, MoneyPinResetStatus>> sendResetRequest() async {
    final result = await _api.sendResetRequest();
    return result.flatMap(_mapResetStatus);
  }

  Either<Failure, MoneyPinResetStatus> _mapResetStatus(dynamic response) {
    return requireDataMap(response).map(MoneyPinResetStatusModel.fromJson);
  }
}
