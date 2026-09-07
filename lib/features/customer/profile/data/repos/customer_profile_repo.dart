import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../shared/auth/data/local/auth_local_data_source.dart';
import '../../domain/entities/customer_profile.dart';
import '../../domain/repos/i_customer_profile_repo.dart';
import '../apis/customer_profile_api.dart';
import '../models/customer_profile_model.dart';

class CustomerProfileRepo implements ICustomerProfileRepo {
  final CustomerProfileApi _api;
  final AuthLocalDataSource _localDataSource;

  CustomerProfileRepo(this._api, this._localDataSource);

  @override
  Future<Either<Failure, CustomerProfile>> getProfile() async {
    final result = await _api.getProfile();
    return result.map(
      (response) =>
          CustomerProfileModel.fromJson(response['data'] as Map<String, dynamic>),
    );
  }

  @override
  Future<Either<Failure, Unit>> changePassword(
    String currentPassword,
    String newPassword,
  ) async {
    final result = await _api.changePassword(currentPassword, newPassword);
    return result.map((_) => unit);
  }

  @override
  Future<Either<Failure, Unit>> deleteAccount(String password) async {
    final result = await _api.deleteAccount(password);

    await result.fold((_) async {}, (_) => _localDataSource.clearSession());

    return result.map((_) => unit);
  }
}
