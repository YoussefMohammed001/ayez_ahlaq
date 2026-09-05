import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../domain/entities/customer_profile.dart';
import '../../domain/repos/i_customer_profile_repo.dart';
import '../apis/customer_profile_api.dart';
import '../models/customer_profile_model.dart';

class CustomerProfileRepo implements ICustomerProfileRepo {
  final CustomerProfileApi _api;

  CustomerProfileRepo(this._api);

  @override
  Future<Either<Failure, CustomerProfile>> getProfile() async {
    final result = await _api.getProfile();
    return result.map(
      (response) =>
          CustomerProfileModel.fromJson(response['data'] as Map<String, dynamic>),
    );
  }
}
