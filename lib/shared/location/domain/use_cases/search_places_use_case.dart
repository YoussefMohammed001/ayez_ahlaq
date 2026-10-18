import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/place_suggestion.dart';
import '../repos/i_location_repo.dart';

class SearchPlacesUseCase {
  final ILocationRepo _repo;

  SearchPlacesUseCase(this._repo);

  Future<Either<Failure, List<PlaceSuggestion>>> call(String query) =>
      _repo.search(query);
}
