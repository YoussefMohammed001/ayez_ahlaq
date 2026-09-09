import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../domain/entities/customer_rating.dart';
import '../../domain/repos/i_customer_ratings_repo.dart';
import '../apis/customer_ratings_api.dart';
import '../models/customer_rating_model.dart';

class CustomerRatingsRepo implements ICustomerRatingsRepo {
  final CustomerRatingsApi _api;

  CustomerRatingsRepo(this._api);

  @override
  Future<Either<Failure, List<CustomerRating>>> getRatings() async {
    final result = await _api.getRatings();
    return result.map((response) {
      final data = response['data'] as List? ?? const [];
      return data
          .map((json) => CustomerRatingModel.fromJson(json as Map<String, dynamic>))
          .toList();
    });
  }
}
