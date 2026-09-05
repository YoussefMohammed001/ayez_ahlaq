import '../entities/customer_profile.dart';

abstract class ICustomerProfileRepo {
  CustomerProfile getCachedProfile();
}
