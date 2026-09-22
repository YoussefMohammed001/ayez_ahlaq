import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/response_guard.dart';
import '../../../../../shared/auth/data/local/auth_local_data_source.dart';
import '../../domain/entities/merchant_phone.dart';
import '../../domain/entities/merchant_profile.dart';
import '../../domain/repos/i_merchant_profile_repo.dart';
import '../apis/merchant_profile_api.dart';
import '../models/merchant_phone_model.dart';
import '../models/merchant_profile_model.dart';

class MerchantProfileRepo implements IMerchantProfileRepo {
  final MerchantProfileApi _api;
  final AuthLocalDataSource _localDataSource;

  MerchantProfileRepo(this._api, this._localDataSource);

  @override
  Future<Either<Failure, MerchantProfile>> getProfile() async {
    final result = await _api.getProfile();
    return result.flatMap(_mapOne);
  }

  @override
  Future<Either<Failure, MerchantProfile>> updateProfile({
    required String businessName,
    required String ownerName,
    String? email,
  }) async {
    final result = await _api.updateProfile({
      'businessName': businessName,
      'ownerName': ownerName,
      if (email != null && email.isNotEmpty) 'email': email,
    });
    return result.flatMap(_mapOne);
  }

  @override
  Future<Either<Failure, MerchantProfile>> updateLocation({
    double? latitude,
    double? longitude,
    String? address,
  }) async {
    final result = await _api.updateLocation({
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
    });
    return result.flatMap(_mapOne);
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
  Future<Either<Failure, List<MerchantPhone>>> getPhones() async {
    final result = await _api.getPhones();
    return result.map((response) {
      final data = response['data'] as List? ?? const [];
      return data
          .map<MerchantPhone>(
            (e) => MerchantPhoneModel.fromJson(e as Map<String, dynamic>),
          )
          .toList();
    });
  }

  @override
  Future<Either<Failure, MerchantPhone>> addPhone(
    String phone,
    String? label,
  ) async {
    final result = await _api.addPhone(phone, label);
    return result.flatMap(
      (response) => requireDataMap(response).map(MerchantPhoneModel.fromJson),
    );
  }

  @override
  Future<Either<Failure, Unit>> deletePhone(int id) async {
    final result = await _api.deletePhone(id);
    return result.map((_) => unit);
  }

  Either<Failure, MerchantProfile> _mapOne(dynamic response) {
    return requireDataMap(response).map(MerchantProfileModel.fromJson);
  }

  @override
  Future<Either<Failure, Unit>> deleteAccount(String password) async {
    final result = await _api.deleteAccount(password);

    await result.fold((_) async {}, (_) => _localDataSource.clearSession());

    return result.map((_) => unit);
  }
}
