import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/customer_profile.dart';

abstract class ICustomerProfileRepo {
  Future<Either<Failure, CustomerProfile>> getProfile();
}
