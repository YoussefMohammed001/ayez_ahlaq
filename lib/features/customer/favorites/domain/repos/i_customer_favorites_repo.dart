import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/barber_invite_preview.dart';
import '../entities/favorite_barber.dart';

abstract class ICustomerFavoritesRepo {
  Future<Either<Failure, List<FavoriteBarber>>> getFavorites();

  Future<Either<Failure, Unit>> addFavorite(int barberId);

  Future<Either<Failure, Unit>> removeFavorite(int barberId);

  Future<Either<Failure, Unit>> addFavoriteViaInvite(String inviteCode);

  Future<Either<Failure, BarberInvitePreview>> getInvitePreview(String code);
}
