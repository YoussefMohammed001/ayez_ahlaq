import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../domain/entities/barber_reviews_summary.dart';
import '../../domain/repos/i_barber_reviews_repo.dart';
import '../apis/barber_reviews_api.dart';
import '../models/barber_reviews_summary_model.dart';

class BarberReviewsRepo implements IBarberReviewsRepo {
  final BarberReviewsApi _api;

  BarberReviewsRepo(this._api);

  @override
  Future<Either<Failure, BarberReviewsSummary>> getReviews() async {
    final result = await _api.getReviews();
    return result.map(_mapSummary);
  }

  BarberReviewsSummary _mapSummary(dynamic response) {
    return BarberReviewsSummaryModel.fromJson(
      response['data'] as Map<String, dynamic>,
    );
  }
}
