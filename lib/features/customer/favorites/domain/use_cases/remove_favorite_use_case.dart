import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../repos/i_customer_favorites_repo.dart';

class RemoveFavoriteUseCase {
  final ICustomerFavoritesRepo _repo;

  RemoveFavoriteUseCase(this._repo);

  Future<Either<Failure, Unit>> call(int barberId) => _repo.removeFavorite(barberId);
}
