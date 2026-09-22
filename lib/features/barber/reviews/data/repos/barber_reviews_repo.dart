import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/response_guard.dart';
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
    return result.flatMap(_mapSummary);
  }

  Either<Failure, BarberReviewsSummary> _mapSummary(dynamic response) {
    return requireDataMap(response).map(BarberReviewsSummaryModel.fromJson);
  }
}
