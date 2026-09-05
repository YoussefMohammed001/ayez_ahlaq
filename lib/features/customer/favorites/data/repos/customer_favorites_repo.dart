import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../domain/entities/barber_invite_preview.dart';
import '../../domain/entities/favorite_barber.dart';
import '../../domain/repos/i_customer_favorites_repo.dart';
import '../apis/customer_favorites_api.dart';
import '../models/barber_invite_preview_model.dart';
import '../models/favorite_barber_model.dart';

class CustomerFavoritesRepo implements ICustomerFavoritesRepo {
  final CustomerFavoritesApi _api;

  CustomerFavoritesRepo(this._api);

  @override
  Future<Either<Failure, List<FavoriteBarber>>> getFavorites() async {
    final result = await _api.getFavorites();

    return result.map(
      (response) => (response['data'] as List<dynamic>? ?? [])
          .map((e) => FavoriteBarberModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  Future<Either<Failure, Unit>> addFavorite(int barberId) async {
    final result = await _api.addFavorite(barberId);
    return result.map((_) => unit);
  }

  @override
  Future<Either<Failure, Unit>> removeFavorite(int barberId) async {
    final result = await _api.removeFavorite(barberId);
    return result.map((_) => unit);
  }

  @override
  Future<Either<Failure, Unit>> addFavoriteViaInvite(String inviteCode) async {
    final result = await _api.addFavoriteViaInvite(inviteCode);
    return result.map((_) => unit);
  }

  @override
  Future<Either<Failure, BarberInvitePreview>> getInvitePreview(String code) async {
    final result = await _api.getInvitePreview(code);

    return result.map(
      (response) =>
          BarberInvitePreviewModel.fromJson(response['data'] as Map<String, dynamic>),
    );
  }
}
