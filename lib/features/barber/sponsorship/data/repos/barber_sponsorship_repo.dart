import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../shared/sponsorship/sponsorship.dart';
import '../../../../../shared/sponsorship/sponsorship_model.dart';
import '../../domain/repos/i_barber_sponsorship_repo.dart';
import '../apis/barber_sponsorship_api.dart';

class BarberSponsorshipRepo implements IBarberSponsorshipRepo {
  final BarberSponsorshipApi _api;

  BarberSponsorshipRepo(this._api);

  @override
  Future<Either<Failure, Sponsorship>> getSponsorship() async {
    final result = await _api.getSponsorship();
    return result.map(_mapOne);
  }

  @override
  Future<Either<Failure, Sponsorship>> buySponsorship() async {
    final result = await _api.buySponsorship();
    return result.map(_mapOne);
  }

  Sponsorship _mapOne(dynamic response) {
    return SponsorshipModel.fromJson(
      response['data'] as Map<String, dynamic>? ?? const {},
    );
  }
}
